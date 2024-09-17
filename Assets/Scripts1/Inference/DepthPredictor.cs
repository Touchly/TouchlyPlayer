using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NatML;
using NatML.Vision;
using NatML.Features;
using System.Threading.Tasks;
using TMPro;

public class DepthPredictor : MonoBehaviour
{
    public enum Algorithm
    {
        Box = 1,
        Gaussian = 2
    }
    int counter = 0, bufferFrames = 0;

    [Header("Blur filter settings")]
    public Algorithm algorithm = Algorithm.Box;
    [Range(0, 2)]
    public float BlurAmount = 1;
    [Range(2, 3)]
    public int KernelSize = 2;
    public Texture2D maskTexture; 
    private Texture2D previous;
    public Material material = null;

    static readonly string kernelKeyword = "KERNEL";
    static readonly int blurAmountString = Shader.PropertyToID("_BlurAmount");
    static readonly int blurTexString = Shader.PropertyToID("_BlurTex");
    static readonly int maskTexString = Shader.PropertyToID("_MaskTex");
    private int numberOfPasses, pass;

    [SerializeField] TextMeshProUGUI debugText;

    RenderTextureDescriptor half, quarter, eighths, sixths;
    
    
    [SerializeField] GameObject DepthFromImage;
    [Header("Depth predictor settings")]
    public UnityEvent<RenderTexture> OnDepthSolved;
    public UnityEvent<float> OnImageResized; 
    public UnityEvent<float> SetBufferFrames;
    public RenderTexture inputVideo, DepthTex, outputTex;
    public Material filter;
    public bool useFilter = false;
    RenderTexture modelInL, modelInR, inter;
    Texture2D warpedL, warpedR;
    //NatML
    public MLModelData modelDataCRE, modelDataHit;
    MLImageFeature inputFeatureLeft, inputFeatureRight;
    MLImageFeature[] inputFeatures;
    MLModel model;
    DepthNetPredictor predictor;
    MLAsyncPredictor<DepthNetPredictor.Matte> asyncPredictor;

    RenderTexture depthMap, outputVideo;
    ComputeShader rectify, flow2depth, warp2ref, renderer;
    RenderTextureDescriptor descriptorEq, descriptorSwap;
    
    int modelW, modelH;
    bool preprocessed = false;
    bool convert = false;
    bool isProcessing = false;
    int modelIndex = 0;
    
    float inferTime = 0f;
    float debugTime = 0f;
    float debugInterval = 5f;

    //private SemaphoreSlim semaphore = new SemaphoreSlim(1);
    //private Queue<Task> taskQueue = new Queue<Task>();

    public void SetSettings(bool _preprocessed, int format)
    {
        preprocessed = _preprocessed;
        if (format==0 || format==2 || format==3){
            convert = true;
            Begin();
        }
    }

    private async Task Infer(){
        //Rectify
        Rectify();

        //Write rectified image to warpedL and warpedR
        toTexture2D(modelInL, warpedL);
        toTexture2D(modelInR, warpedR);

        //Normalization
        inputFeatureLeft = new MLImageFeature(warpedL);
        inputFeatureRight = new MLImageFeature(warpedR);

        if (modelIndex == 0){
            inputFeatureLeft.std = Vector3.one * 1f / 255;
            inputFeatureRight.std =  Vector3.one * 1f / 255;
        }

        //Image as model features
        inputFeatures = new MLImageFeature[] {inputFeatureLeft,inputFeatureRight};

        //var startTime = System.DateTime.UtcNow;
        // Prediction
        if (asyncPredictor.readyForPrediction){
            var matte = await asyncPredictor.Predict(inputFeatures);
            if (depthMap != null)
                matte.Render(depthMap);
            PostProcessing();
        }
        //inputFeatureLeft.Dispose();
        //inputFeatureRight.Dispose();

        if (useFilter){
            OnDepthSolved.Invoke(outputTex);
        } else {
            OnDepthSolved.Invoke(outputVideo);
        }
        
        return;
    }

    void OnDisable(){
        convert = false;

        if (!preprocessed){ asyncPredictor?.Dispose();}
        model?.Dispose();
        if (modelInL != null) modelInL.Release();
        if (modelInR != null) modelInR.Release();
        if (inter != null) inter.Release();
        if (outputVideo != null) outputVideo.Release();
        if (depthMap != null) depthMap.Release();
    }

    // Start is called before the first frame update
    void Begin()
    {
        if (!preprocessed){
            if (debugText){
                debugText.gameObject.SetActive(true);
            }
            
            //Load model
            modelIndex = PlayerPrefs.GetInt("modelIndex", 0);
            Debug.Log("Using model with index: " + modelIndex.ToString());
            MLModelData modelData = modelIndex == 0 ? modelDataCRE : modelDataHit;

            modelData.computeTarget = MLModelData.ComputeTarget.All;
            model = modelData.Deserialize();

            //Predictor
            predictor = new DepthNetPredictor(model);
            if (predictor == null)
                return;
            
            asyncPredictor = predictor.ToAsync();
            modelW = 480; //480 x 480
            modelH = 480;
            depthMap = new RenderTexture(modelW, modelH, 0);

            //Inputs for model
            modelInL = new RenderTexture(modelW, modelH, 0);
            modelInR = new RenderTexture(modelW, modelH, 0);
            
            inter = new RenderTexture(modelH, modelH, 0);
            //Make Rfloat

            outputVideo = new RenderTexture(modelH, modelH, 0);
            outputVideo.format = RenderTextureFormat.RFloat;

            inter.enableRandomWrite=true;

            //Render Texture Descriptors
            descriptorEq = new RenderTextureDescriptor(modelW, modelH, RenderTextureFormat.ARGB32, 0);
            descriptorSwap = new RenderTextureDescriptor(modelH, modelW, RenderTextureFormat.ARGB32, 0);
            descriptorEq.enableRandomWrite = true;
            descriptorSwap.enableRandomWrite = true;

            //Create Textures for the model
            if (warpedL == null)
            {
                warpedL = new Texture2D(modelInL.width, modelInL.height);
            }
            if (warpedR == null)
            {
                warpedR = new Texture2D(modelInL.width, modelInL.height);
            }

            // Compute shaders
            flow2depth = flow2depth ?? (ComputeShader)Resources.Load(@"ComputeShaders/Flow2Depth");
            warp2ref = warp2ref ?? (ComputeShader)Resources.Load(@"ComputeShaders/DeRectify");
            rectify = rectify ?? (ComputeShader)Resources.Load(@"ComputeShaders/Rectify180");
        } else {
            if (debugText){
                debugText.gameObject.SetActive(false);
            }
            
        }

    }

    void PostProcessing(){

        //Temp buffers
        var tempBufferIn = RenderTexture.GetTemporary(descriptorEq);
        var tempBufferOut = RenderTexture.GetTemporary(descriptorEq);
        tempBufferIn.Create();
        tempBufferOut.Create();
        //Copy depth map to tempBufferIn
        Graphics.Blit(depthMap, tempBufferIn);
        //Graphics.Blit(depthMap, outputVideo);
        //Input
        flow2depth.SetTexture(0, @"In", tempBufferIn);
        flow2depth.SetTexture(0, @"Result", tempBufferOut);
        //Run
        flow2depth.GetKernelThreadGroupSizes(0, out var gx, out var gy, out var _);
        flow2depth.Dispatch(0, Mathf.CeilToInt((float)modelW / gx), Mathf.CeilToInt((float)modelH / gy), 1);

        Graphics.Blit(tempBufferOut, inter);
        //Debug this step
        //Graphics.Blit(tempBufferOut, outputTex);

        tempBufferIn.Release();
        tempBufferOut.Release();

        //Warp to reference
        var descriptorSquare = new RenderTextureDescriptor(modelH, modelH, RenderTextureFormat.ARGB32, 0);
        descriptorSquare.enableRandomWrite = true;

        var tempBufferIn2 = RenderTexture.GetTemporary(descriptorSquare);
        var tempBufferOut2 = RenderTexture.GetTemporary(descriptorSquare);
        tempBufferIn2.Create();
        tempBufferOut2.Create();
        
        //Input
        Graphics.Blit(inter, tempBufferIn2);

        warp2ref.SetTexture(0, @"In", tempBufferIn2);
        warp2ref.SetTexture(0, @"Result", tempBufferOut2);
        //Run
        warp2ref.GetKernelThreadGroupSizes(0, out gx, out gy, out var _);
        warp2ref.Dispatch(0, Mathf.CeilToInt((float)modelW / gy), Mathf.CeilToInt((float)modelH / gx), 1);
        
        //scale 2 
        Graphics.Blit(tempBufferOut2, outputVideo, new Vector2(0.5f, 1f), new Vector2(0.25f, 0f));
        //Graphics.Blit(outputVideo, outputTex, filter);

        if (useFilter){
            RenderTex(outputVideo, outputTex);
        }
        
        //Graphics.Blit(tempBufferOut2, outputTex, new Vector2(0.5f, 1f), new Vector2(0.25f, 0f));
        //Dispose
        //RenderTexture.active = null;
        tempBufferIn2.Release();
        tempBufferOut2.Release();
    }

    void Rectify()
    {

        //Temp buffers
        var tempBufferIn = RenderTexture.GetTemporary(descriptorEq);
        var tempBufferOut = RenderTexture.GetTemporary(descriptorSwap);
        tempBufferIn.Create();
        tempBufferOut.Create();
        //Copy input to tempBufferIn
        Graphics.Blit(inputVideo, tempBufferIn, new Vector2(0.5f, 1), new Vector2(0, 0));
        //  I/O
        rectify.SetTexture(0, @"In", tempBufferIn);
        rectify.SetTexture(0, @"Result", tempBufferOut);
        
        //Run
        rectify.GetKernelThreadGroupSizes(0, out var gx, out var gy, out var _);
        rectify.Dispatch(0, Mathf.CeilToInt((float)modelH / gy), Mathf.CeilToInt((float)modelW / gx), 1);
        
        //Write to modelInL
        Graphics.Blit(tempBufferOut, modelInL, new Vector2(1f, 0.5f), new Vector2(0f, 0.25f));
        //Debug Step
        //Graphics.Blit(tempBufferOut, outputTex, new Vector2(1f, 0.5f), new Vector2(0f, 0.25f));

        //Now for the right image
        Graphics.Blit(inputVideo, tempBufferIn, new Vector2(0.5f, 1), new Vector2(0.5f, 0));
        //Input
        rectify.SetTexture(0, @"In", tempBufferIn);
        rectify.SetTexture(0, @"Result", tempBufferOut);
        //Run
        rectify.Dispatch(0, Mathf.CeilToInt((float)modelH / gy), Mathf.CeilToInt((float)modelW / gx), 1);
        
        //Write to modelInR
        Graphics.Blit(tempBufferOut, modelInR, new Vector2(1f, 0.5f), new Vector2(0f, 0.25f));
        //Graphics.Blit(tempBufferOut, outputTex, new Vector2(1f, 0.5f), new Vector2(0f, 0.25f));
        //Dispose
        tempBufferIn.Release();
        tempBufferOut.Release();
    }

    static void toTexture2D(RenderTexture source, Texture2D destination)
    {
        RenderTexture.active = source;

        destination.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0);
        destination.Apply();

        RenderTexture.active = null;
    }

    async void Update(){
        //counter++;
        if(DepthFromImage.activeSelf && convert && !isProcessing){
            if (!preprocessed){
                isProcessing = true;
                float startTime = Time.realtimeSinceStartup;
                await Infer();
                inferTime = Time.realtimeSinceStartup - startTime;
                isProcessing = false;
                // Check the amount of frames required to buffer
                
            } else {
                OnDepthSolved.Invoke(DepthTex);
            }
        }

        debugTime += Time.deltaTime;
        if (debugTime >= debugInterval){
            //Debug.Log($"Inference frequency: {1f / inferTime } Hz");
            debugText.SetText($"Inference frequency: {(int)(1f / inferTime) } Hz");
            SetBufferFrames.Invoke((float)inferTime);
            debugTime = 0f;
        }
    }



    void RenderTex(RenderTexture source, RenderTexture destination)
    {
        if (BlurAmount == 0)
        {
            Graphics.Blit(source, destination);
            return;
        }

        half = new RenderTextureDescriptor(Screen.width / 2, Screen.height / 2);
        quarter = new RenderTextureDescriptor(Screen.width / 4, Screen.height / 4);
        eighths = new RenderTextureDescriptor(Screen.width / 8, Screen.height / 8);
        sixths = new RenderTextureDescriptor(Screen.width / 16, Screen.height / 16);

        if (KernelSize == 2)
            material.DisableKeyword(kernelKeyword);
        else
            material.EnableKeyword(kernelKeyword);

        pass = algorithm == Algorithm.Box ? 0 : 1;

        if(maskTexture != null || previous != maskTexture)
        {
            previous = maskTexture;
            material.SetTexture(maskTexString, maskTexture);
        }

        RenderTexture blurTex = null;
        numberOfPasses = Mathf.Clamp(Mathf.CeilToInt(BlurAmount * 4), 1, 4);
        material.SetFloat(blurAmountString, numberOfPasses > 1 ? BlurAmount > 1 ? BlurAmount : (BlurAmount * 4 - Mathf.FloorToInt(BlurAmount * 4 - 0.001f)) * 0.5f + 0.5f : BlurAmount * 4);

        if (numberOfPasses == 1)
        {
            blurTex = RenderTexture.GetTemporary(half);
            blurTex.filterMode = FilterMode.Bilinear;
            Graphics.Blit(source, blurTex, material, pass);
        }
        else if (numberOfPasses == 2)
        {
            blurTex = RenderTexture.GetTemporary(half);
            var temp1 = RenderTexture.GetTemporary(quarter);
            blurTex.filterMode = FilterMode.Bilinear;
            temp1.filterMode = FilterMode.Bilinear;
            Graphics.Blit(source, temp1, material, pass);
            Graphics.Blit(temp1, blurTex, material, pass);
            RenderTexture.ReleaseTemporary(temp1);
        }
        else if (numberOfPasses == 3)
        {
            blurTex = RenderTexture.GetTemporary(quarter);
            var temp1 = RenderTexture.GetTemporary(eighths);
            blurTex.filterMode = FilterMode.Bilinear;
            temp1.filterMode = FilterMode.Bilinear;
            Graphics.Blit(source, blurTex, material, pass);
            Graphics.Blit(blurTex, temp1, material, pass);
            Graphics.Blit(temp1, blurTex, material, pass);
            RenderTexture.ReleaseTemporary(temp1);
        }
        else if (numberOfPasses == 4)
        {
            blurTex = RenderTexture.GetTemporary(quarter);
            var temp1 = RenderTexture.GetTemporary(eighths);
            var temp2 = RenderTexture.GetTemporary(sixths);
            blurTex.filterMode = FilterMode.Bilinear;
            temp1.filterMode = FilterMode.Bilinear;
            temp2.filterMode = FilterMode.Bilinear;
            Graphics.Blit(source, blurTex, material, pass);
            Graphics.Blit(blurTex, temp1, material, pass);
            Graphics.Blit(temp1, temp2, material, pass);
            Graphics.Blit(temp2, temp1, material, pass);
            Graphics.Blit(temp1, blurTex, material, pass);
            RenderTexture.ReleaseTemporary(temp1);
            RenderTexture.ReleaseTemporary(temp2);
        }

        material.SetTexture(blurTexString, blurTex);
        RenderTexture.ReleaseTemporary(blurTex);

        Graphics.Blit(source, destination, material, 2);
    }
}

