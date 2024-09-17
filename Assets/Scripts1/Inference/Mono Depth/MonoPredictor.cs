using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using NatML;
using NatML.Vision;
using NatML.Features;
using System.Threading.Tasks;
using TMPro;

public class MonoPredictor : MonoBehaviour
{
    [SerializeField] GameObject DepthFromImage;
    public UnityEvent<RenderTexture> OnDepthSolved;
    public UnityEvent<float> OnImageResized, SetBufferFrames;
    public RenderTexture inputVideo, DepthTex, outputVideo;

    [SerializeField] TextMeshProUGUI debugText;

    Texture2D inputTex;
    //NatML
    public MLModelData modelDataSmall, modelDataLarge;
    MLImageFeature inputFeature;
    MLModel model;
    MonoNetPredictor predictor;
    MLAsyncPredictor<MonoNetPredictor.Matte> asyncPredictor;

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

        inputTex = toTexture2D(inputVideo);

        //Normalization
        inputFeature = new MLImageFeature(inputTex);

        inputFeature.std = Vector3.one * 1f / 255;

        if (asyncPredictor.readyForPrediction){
            var matte = await asyncPredictor.Predict(inputFeature);
            if (outputVideo != null)
                matte.Render(outputVideo);
        }
        OnDepthSolved.Invoke(outputVideo);
        //return;

    }

    void OnDisable(){
        asyncPredictor?.Dispose();
        model?.Dispose();
    }

    // Start is called before the first frame update
    void Begin()
    {
        if (!preprocessed){
            //Load model
            if(debugText){
                debugText.gameObject.SetActive(true);
            }
            
            int modelIndex = PlayerPrefs.GetInt("modelIndex", 0);
            Debug.Log("Using mono model with index: " + modelIndex.ToString());
            MLModelData modelData = modelIndex == 0 ? modelDataSmall : modelDataLarge;

            if (modelData == null)
                return;
            model = modelData.Deserialize();

            //Predictor
            predictor = new MonoNetPredictor(model);
            if (predictor == null)
                return;
            
            asyncPredictor = predictor.ToAsync();
            
        } else {
            if(debugText){
            debugText.gameObject.SetActive(false);
            }
        }
    }

    Texture2D toTexture2D(RenderTexture rTex)
    {
        Texture2D tex = new Texture2D(inputVideo.width, inputVideo.height, TextureFormat.RGB24, false);
        // ReadPixels looks at the active RenderTexture.
        RenderTexture.active = rTex;
        tex.ReadPixels(new Rect(0, 0, rTex.width, rTex.height), 0, 0);
        tex.Apply();
        return tex;
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
