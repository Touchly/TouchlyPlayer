using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

using NatML;
using NatML.Vision;
using NatML.Features;
using System.Threading.Tasks;

public class Pipeline : MonoBehaviour
{
    //[SerializeField] Texture2D inputL, inputR;
    public RenderTexture inputVideo, outputVideo;
    RenderTexture modelInL, modelInR, inter;
    Texture2D warpedL, warpedR;
    //NatML
    public MLModelData modelData;
    MLImageFeature inputFeatureLeft, inputFeatureRight;
    MLImageFeature[] inputFeatures;
    MLModel model;
    DepthNetPredictor predictor;
    MLAsyncPredictor<DepthNetPredictor.Matte> asyncPredictor;

    RenderTexture depthMap, output;
    ComputeShader rectify, flow2depth, warp2ref, renderer;
    RenderTextureDescriptor descriptorEq, descriptorSwap;
    int modelW, modelH;

    async Task Infer(){

        //Rectify
        Rectify();

        //Write rectified image to warpedL and warpedR
        warpedL = new Texture2D(modelInL.width, modelInL.height);
        warpedR = new Texture2D(modelInR.width, modelInR.height);
        
        //Convert to Texture2D
        warpedL = toTexture2D(modelInL);
        warpedR = toTexture2D(modelInR);

        

        //Graphics.Blit(warpedR, outputVideo);
        //Normalization
        inputFeatureLeft = new MLImageFeature(warpedL);
        inputFeatureRight = new MLImageFeature(warpedR);

        inputFeatureLeft.std = Vector3.one * 1f / 255;
        inputFeatureRight.std =  Vector3.one * 1f / 255;

        //Image as model features
        inputFeatures = new MLImageFeature[] {inputFeatureLeft,inputFeatureRight};

        //Time it
        //var startTime = System.DateTime.UtcNow;
        // Prediction
        if (asyncPredictor.readyForPrediction){
            var matte = await asyncPredictor.Predict(inputFeatures);
            if (depthMap != null)
                matte.Render(depthMap);
            PostProcessing();
        }
        //return;

    }

    void OnDisable(){
        asyncPredictor.Dispose();
        model?.Dispose();
        modelInL.Release();
        modelInR.Release();
        depthMap.Release();
        inter.Release();
    }

    // Start is called before the first frame update
    void Start()
    {
        
        //Load model
        model = modelData.Deserialize();

        //Predictor
        predictor = new DepthNetPredictor(model);
        if (predictor == null)
            return;
        
        asyncPredictor = predictor.ToAsync();
        modelW = 400;
        modelH = 400;
        depthMap = new RenderTexture(modelW, modelH, 0);

        //Inputs for model
        modelInL = new RenderTexture(modelW, modelH, 0);
        modelInR = new RenderTexture(modelW, modelH, 0);
        inter = new RenderTexture(modelH, modelH, 0);
        inter.enableRandomWrite=true;
        //Output after processing
        output = new RenderTexture(modelH, modelH, 0);

        //Render Texture Descriptors
        descriptorEq = new RenderTextureDescriptor(modelW, modelH, RenderTextureFormat.ARGB32, 0);
        descriptorSwap = new RenderTextureDescriptor(modelH, modelW, RenderTextureFormat.ARGB32, 0);
        descriptorEq.enableRandomWrite = true;
        descriptorSwap.enableRandomWrite = true;

        //Infer();
        //Start Iennumerator
        //StartCoroutine(UpdateDepth());
    }

    void PostProcessing(){
        //Convert disparity to depth
        flow2depth = flow2depth ?? (ComputeShader)Resources.Load(@"ComputeShaders/Flow2Depth");

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
        //Graphics.Blit(tempBufferOut, output);

        tempBufferIn.Release();
        tempBufferOut.Release();

        //Warp to reference
        var descriptorSquare = new RenderTextureDescriptor(modelH, modelH, RenderTextureFormat.ARGB32, 0);
        descriptorSquare.enableRandomWrite = true;

        var tempBufferIn2 = RenderTexture.GetTemporary(descriptorSquare);
        var tempBufferOut2 = RenderTexture.GetTemporary(descriptorSquare);
        tempBufferIn2.Create();
        tempBufferOut2.Create();
        
        warp2ref = warp2ref ?? (ComputeShader)Resources.Load(@"ComputeShaders/DeRectify");
        //Input
        Graphics.Blit(inter, tempBufferIn2);
        

        warp2ref.SetTexture(0, @"In", tempBufferIn2);
        warp2ref.SetTexture(0, @"Result", tempBufferOut2);
        //Run
        warp2ref.GetKernelThreadGroupSizes(0, out gx, out gy, out var _);
        warp2ref.Dispatch(0, Mathf.CeilToInt((float)modelW / gy), Mathf.CeilToInt((float)modelH / gx), 1);
        
        //scale 2 
        Graphics.Blit(tempBufferOut2, outputVideo, new Vector2(0.5f, 1f), new Vector2(0.25f, 0f));
        //Dispose
        //RenderTexture.active = null;
        tempBufferIn2.Release();
        tempBufferOut2.Release();
    }

    void Rectify()
    {
        //Compute shader
        rectify = rectify ?? (ComputeShader)Resources.Load(@"ComputeShaders/Rectify180");

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
        //Graphics.Blit(tempBufferOut, outputVideo, new Vector2(1f, 0.5f), new Vector2(0f, 0.25f));

        //Now for the right image
        Graphics.Blit(inputVideo, tempBufferIn, new Vector2(0.5f, 1), new Vector2(0.5f, 0));
        //Input
        rectify.SetTexture(0, @"In", tempBufferIn);
        rectify.SetTexture(0, @"Result", tempBufferOut);
        //Run
        rectify.Dispatch(0, Mathf.CeilToInt((float)modelH / gy), Mathf.CeilToInt((float)modelW / gx), 1);
        
        //Write to modelInR
        Graphics.Blit(tempBufferOut, modelInR, new Vector2(1f, 0.5f), new Vector2(0f, 0.25f));
        //Graphics.Blit(tempBufferOut, outputVideo, new Vector2(1f, 0.5f), new Vector2(0f, 0.25f));
        //Dispose
        tempBufferIn.Release();
        tempBufferOut.Release();
    }

    Texture2D toTexture2D(RenderTexture rTex)
    {
        Texture2D tex = new Texture2D(modelInL.width, modelInL.height, TextureFormat.RGB24, false);
        // ReadPixels looks at the active RenderTexture.
        RenderTexture.active = rTex;
        tex.ReadPixels(new Rect(0, 0, rTex.width, rTex.height), 0, 0);
        tex.Apply();
        return tex;
    }

    IEnumerator UpdateDepth(){
        while(true){
            Infer();
            //yield return new WaitForSeconds(1f);
        }
    }

    async void Update(){
        await Infer();
    }
}
