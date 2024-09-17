using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NatML;
using NatML.Vision;
using NatML.Features;
using System.Threading.Tasks;
using TMPro;

public class SBSPredictor : MonoBehaviour
{
    [SerializeField] GameObject DepthFromImage;
    public UnityEvent<RenderTexture> OnDepthSolved;
    public UnityEvent<float> OnImageResized, SetBufferFrames;
    public RenderTexture inputVideo, DepthTex, outputVideo;
    RenderTexture inputLeft, inputRight;

    [SerializeField] TextMeshProUGUI debugText;

    Texture2D inputLeftTex, inputRightTex;
    //NatML
    public MLModelData modelDataSmall, modelDataLarge;
    MLImageFeature inputFeatureLeft, inputFeatureRight;
    MLImageFeature[] inputFeatures;

    MLModel model;
    SBSNetPredictor predictor;
    MLAsyncPredictor<SBSNetPredictor.Matte> asyncPredictor;
    
    RenderTexture output;
    ComputeShader renderer;
    int modelW, modelH;
    bool convert = false;

    bool preprocessed = false;
    bool isProcessing = false;

    float inferTime = 0f;
    float debugTime = 0f;
    float debugInterval = 5f;

    public void SetSettings(bool _preprocessed, int format)
    {
        preprocessed = _preprocessed;
        if (format==1){
            convert = true;
            Begin();
        }
    }

    async Task Infer(){
        //Convert to Texture2D
        
        if (asyncPredictor==null){
            Begin();
        }

        Graphics.Blit(inputVideo, inputRight, new Vector2(0.5f,1f), new Vector2(0,0));
        Graphics.Blit(inputVideo, inputLeft, new Vector2(0.5f,1f), new Vector2(0.5f,0));

        toTexture2D(inputRight, inputRightTex);
        toTexture2D(inputLeft, inputLeftTex);

        //Normalization
        inputFeatureRight = new MLImageFeature(inputRightTex);
        inputFeatureLeft = new MLImageFeature(inputLeftTex);

        inputFeatureRight.std =  Vector3.one * 1f / 255;
        inputFeatureLeft.std = Vector3.one * 1f / 255;

        inputFeatures = new MLImageFeature[] {inputFeatureLeft,inputFeatureRight};

        if (asyncPredictor.readyForPrediction){
            var matte = await asyncPredictor.Predict(inputFeatures);
            if (outputVideo != null)
                matte.Render(outputVideo);
        }
        OnDepthSolved.Invoke(outputVideo);
    }

    void OnDisable(){
        asyncPredictor?.Dispose();
        model?.Dispose();
    }

    // Start is called before the first frame update
    void Begin()
    {
        int modelWidth = 576;
        int modelHeight = 320;

        inputLeft = new RenderTexture(modelWidth, modelHeight, 0);
        inputRight = new RenderTexture(modelWidth, modelHeight, 0);

        inputLeftTex = new Texture2D(modelWidth, modelHeight);
        inputRightTex = new Texture2D(modelWidth, modelHeight);

        if (!preprocessed){
            //Load model
            if(debugText){
                debugText.gameObject.SetActive(true);
            }

            int modelIndex = PlayerPrefs.GetInt("modelIndex", 0);
            Debug.Log("Using SBS model with index: " + modelIndex.ToString());
            MLModelData modelData = modelIndex == 0 ? modelDataSmall : modelDataLarge;
            
            if (modelData == null)
                return;
            model = modelData.Deserialize();

            //Predictor
            predictor = new SBSNetPredictor(model);
            if (predictor == null)
                return;
            
            asyncPredictor = predictor.ToAsync();
            
        } else {
            if(debugText){
            debugText.gameObject.SetActive(false);
            }
        }
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
}
