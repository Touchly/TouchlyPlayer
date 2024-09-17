using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using RenderHeads.Media.AVProVideo;
using UnityEngine.Events;
using System.IO;

//Manages and "distributes" all settings.
public class SetSettings : MonoBehaviour
{
    public UnityEvent<int ,int ,bool, int> setSettings;
    public UnityEvent<bool, int> setSettings2;
    public UnityEvent<bool> enableDepth;
    public UnityEvent<float> setAspect;
    bool alreadyStarted = false;
    public CurrentVideo currentVideo;
    public Material standard, record3d;

    bool watch_only;
    int handModel;

    [SerializeField] List<GameObject> HandRobot;
    [SerializeField] List<GameObject> HandHuman;
    [SerializeField] List<GameObject> Controller;
    [SerializeField] Transform monoScreen;
    [SerializeField] GameObject backgroundMesh, inpaintingScreen;
    [SerializeField] GameObject monoPredictor, stereoPredictor, sbsPredictor;
    [SerializeField] List<MonoBehaviour> oculusExclusiveScripts, steamExclusiveScripts;
    
   // [SerializeField] List<GameObject> UIPointers;
    
    [SerializeField] Material handMaterial, robotMaterial;
    
    [System.Serializable]
    public class VideoMetadataJson
    {
        public float[] intrinsicMatrix;
        public float[] rangeOfEncodedDepth;
    }

    Vector4 getIk(string videoFilePath)
    {
        byte[] fileContents = File.ReadAllBytes(videoFilePath);

        // Convert byte array to string to find metadata (adjust this part as needed)
        string fileContentsStr = System.Text.Encoding.Default.GetString(fileContents);
        string metaStr = fileContentsStr.Substring(fileContentsStr.LastIndexOf("{\"intrinsic"));

        // Assuming your meta information ends with "}"
        int endIndex = metaStr.IndexOf("}") + 1;
        metaStr = metaStr.Substring(0, endIndex);

        VideoMetadataJson metadata = JsonUtility.FromJson<VideoMetadataJson>(metaStr);

        float[] intrinsicMatrix = metadata.intrinsicMatrix;
        Vector4 outputIK = new Vector4(0, 0, 0, 0);

        try
        {
            outputIK = new Vector4(1.0f / intrinsicMatrix[0], 1.0f / intrinsicMatrix[4], -intrinsicMatrix[2] / intrinsicMatrix[0], -intrinsicMatrix[5] / intrinsicMatrix[4]);
        }
        catch
        {
            UnityEngine.Debug.Log("Could not get intrinsic matrix");
        }

        return outputIK;
    }

    void ActivateHands(List<GameObject> hand, bool activate)
    {
        foreach (GameObject obj in hand)
        {
            if (obj){obj.SetActive(activate);}
        }
    }

    public void SwitchHands(bool on){
        if (watch_only){
                if (HandRobot[0]) {HandRobot[0].SetActive(false); HandRobot[1].SetActive(false);}
                if (HandHuman[0]){HandHuman[0].SetActive(false); HandHuman[1].SetActive(false);}
                if (Controller[0]){Controller[0].SetActive(false); Controller[1].SetActive(false);}
            } else {
                if (handModel==0){
                    if (HandRobot[0]) {HandRobot[0].SetActive(on); HandRobot[1].SetActive(on);}
                    if (HandHuman[0]){HandHuman[0].SetActive(false); HandHuman[1].SetActive(false);}
                    if (Controller[0]){Controller[0].SetActive(false); Controller[1].SetActive(false);}

                //Set to real hand
                } else if (handModel==1) {
                    if (HandRobot[0]) {HandRobot[0].SetActive(false); HandRobot[1].SetActive(false);}
                    if (HandHuman[0]){HandHuman[0].SetActive(on); HandHuman[1].SetActive(on);}
                    if (Controller[0]){Controller[0].SetActive(false); Controller[1].SetActive(false);}
                }
            }
    }
    //Send settings to Depth Mesher.
    public void HandleEvent(MediaPlayer mp, MediaPlayerEvent.EventType eventType, ErrorCode code)
    {
        if(eventType== MediaPlayerEvent.EventType.FirstFrameReady && !alreadyStarted){
            alreadyStarted = true;
            #if !STEAM_VR
            foreach (MonoBehaviour script in steamExclusiveScripts)
            {
                if (script){
                    script.enabled = false;
                }
                
            }
            foreach (MonoBehaviour script in oculusExclusiveScripts)
            {
                if (script){
                    script.enabled = true;
                }
                
            }
            #else
            foreach (MonoBehaviour script in steamExclusiveScripts)
            {
                // If the script exists
                if (script){
                    script.enabled = true;
                }
                
            }
            foreach (MonoBehaviour script in oculusExclusiveScripts)
            {
                if (script){
                    script.enabled = false;
                }   
            }
            #endif

            // Preprocessed format
            int format = currentVideo.format;

            standard = standard ?? Resources.Load("DEPTH_COLOR", typeof(Material)) as Material;
            record3d = record3d ?? Resources.Load("Record3D 1", typeof(Material)) as Material;

            
            //Get all the PlayerPrefs
            int quality = PlayerPrefs.GetInt("quality", 0);
            int refreshPeriod= PlayerPrefs.GetInt("refreshPeriod", 500);
            bool pre = currentVideo.preprocessed;

            //Send the events
            Texture testTex = mp.TextureProducer.GetTexture();

            float aspect = 1f;
            if( backgroundMesh){
                backgroundMesh.SetActive(false);
            }

            if (inpaintingScreen){
                inpaintingScreen.SetActive(false);
            }
            
            
            if (format==1){
                if (currentVideo.packing== CurrentVideo.packingStereo.LeftRight){
                    if (monoPredictor){monoPredictor.SetActive(false);}
                    if(stereoPredictor) {stereoPredictor.SetActive(false);}
                    if (sbsPredictor) {sbsPredictor.SetActive(true);}

                    if (pre){
                        aspect = 0.5f*(float)testTex.width / (float)testTex.height;
                    } else {
                        aspect = (float)testTex.width / (float)testTex.height;
                    }
                    
                } else {
                    if (monoPredictor){monoPredictor.SetActive(true);}
                    if(stereoPredictor) {stereoPredictor.SetActive(false);}
                    if (sbsPredictor) {sbsPredictor.SetActive(false);}
                    if (pre){
                        aspect = 2f*(float)testTex.width / (float)testTex.height;
                    } else {
                        aspect = (float)testTex.width / (float)testTex.height;
                    }
                }
                if (monoScreen){
                    monoScreen.localScale = new Vector3(monoScreen.localScale.x, monoScreen.localScale.y, monoScreen.localScale.z/aspect);
                }
                
            } else if (format==2){
                if (monoPredictor){monoPredictor.SetActive(false);}
                if(stereoPredictor) {stereoPredictor.SetActive(true);}
                if (sbsPredictor) {sbsPredictor.SetActive(false);}
                if( backgroundMesh && pre){
                backgroundMesh.SetActive(true);
                }
                if (inpaintingScreen && !pre){
                    inpaintingScreen.SetActive(true);
                }
            } else if (format==0){
                if (monoPredictor){monoPredictor.SetActive(false);}
                if(stereoPredictor) {stereoPredictor.SetActive(true);}
                if (sbsPredictor) {sbsPredictor.SetActive(false);}
                if (inpaintingScreen){
                    inpaintingScreen.SetActive(true);
                }
            } else if (format==3){
                if (monoPredictor){monoPredictor.SetActive(false);}
                if(stereoPredictor) {stereoPredictor.SetActive(true);}
                if (sbsPredictor) {sbsPredictor.SetActive(false);}
                if (inpaintingScreen){inpaintingScreen.SetActive(false);}
                if (backgroundMesh) {backgroundMesh.SetActive(false);}
                
            } else if (format==4){
                if (monoPredictor){monoPredictor.SetActive(false);}
                if(stereoPredictor) {stereoPredictor.SetActive(false);}
                if (sbsPredictor) {sbsPredictor.SetActive(false);}
                aspect = 0.5f*(float)testTex.width / (float)testTex.height;
                
                if (monoScreen){
                    monoScreen.localScale = new Vector3(monoScreen.localScale.x, monoScreen.localScale.y, monoScreen.localScale.z/aspect);
                }

                Vector4 iK = getIk(currentVideo.path);
                UnityEngine.Debug.Log("Intrinsic matrix:");
                UnityEngine.Debug.Log(iK);
                
                Vector4 scale = new Vector4(iK[0]*testTex.width, iK[1]*testTex.height, iK[2], iK[3]);
                record3d.SetVector("_Scale", scale);
            }
            
            currentVideo.aspectRatio = aspect;

            setAspect.Invoke(aspect);

            setSettings.Invoke(quality, refreshPeriod, pre, format);
            Debug.Log(pre);
            setSettings2.Invoke(pre, format);

            //int handModel = PlayerPrefs.GetInt("hand_model", 0);
            handModel = 1;
            
            //Color
            string colorString = PlayerPrefs.GetString("hand_color", "CFCECCFF");
            Color color = Color.white;
            ColorUtility.TryParseHtmlString("#" + colorString , out color);
            handMaterial.color = color;
            robotMaterial.color = color;

            //Set to robot hand
            watch_only = PlayerPrefs.GetInt("watchonly_mode", 0)==1;
            enableDepth.Invoke(!watch_only);

            if (watch_only){
                ActivateHands(HandRobot, false);
                ActivateHands(HandHuman, false);
                ActivateHands(Controller, false);
            } else {
                if (handModel==0){
                    ActivateHands(HandRobot, true);
                    ActivateHands(HandHuman, false);
                    ActivateHands(Controller, false);
                //Set to real hand
                } else if (handModel==1) {
                    ActivateHands(HandRobot, false);
                    ActivateHands(HandHuman, true);
                    ActivateHands(Controller, false);
                }
            }
        }
    }
} 