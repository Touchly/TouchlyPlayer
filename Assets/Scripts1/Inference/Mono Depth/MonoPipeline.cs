using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

using NatML;
using NatML.Vision;
using NatML.Features;
using System.Threading.Tasks;

//using System.Diagnostics;
//using System;

public class MonoPipeline : MonoBehaviour
{
    public RenderTexture inputVideo, outputVideo;
    Texture2D inputTex;
    //NatML
    public MLModelData modelData;
    MLImageFeature inputFeature;
    MLModel model;
    MonoNetPredictor predictor;
    MLAsyncPredictor<MonoNetPredictor.Matte> asyncPredictor;

    RenderTexture output;
    ComputeShader renderer;
    int modelW, modelH;

    //System.Diagnostics.Stopwatch watch = new System.Diagnostics.Stopwatch();

    int counter = 0;

    async Task Infer(){
        //Convert to Texture2D
        inputTex = toTexture2D(inputVideo);

        //Normalization
        inputFeature = new MLImageFeature(inputTex);

        inputFeature.std = Vector3.one * 1f / 255;

        if (asyncPredictor.readyForPrediction){
            var matte = await asyncPredictor.Predict(inputFeature);
            if (outputVideo != null)
                matte.Render(outputVideo);
        }
        //return;

    }

    void OnDisable(){
        asyncPredictor.Dispose();
        model?.Dispose();
    }

    // Start is called before the first frame update
    void Start()
    {
        //Load model
        model = modelData.Deserialize();

        //Predictor
        predictor = new MonoNetPredictor(model);
        if (predictor == null)
            return;
        
        asyncPredictor = predictor.ToAsync();
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

    IEnumerator UpdateDepth(){
        while(true){
            //watch.Start();
            Infer();
            //watch.Stop();
            //UnityEngine.Debug.Log("Inference time: " + watch.ElapsedMilliseconds);
            //yield return new WaitForSeconds(1f);
        }
    }

    async void Update()
    {
        await Infer();
    }
}
