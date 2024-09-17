using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using RenderHeads.Media.AVProVideo;
using UnityEngine.SceneManagement;
using UnityEngine.Events;
using static CurrentVideo;
using ES3Internal;
using UnityEngine.UI;

public class VideoLoader : MonoBehaviour
{
    public CurrentVideo currentVideo;
    public MediaPlayer mediaPlayer;
    public GameObject SphereMat, flatScreen, HiderSphere, Mesh;
    public CanvasGroup passSettings;
    private Dictionary<string, VideoData> videoDict;
    private MediaHints hints;
    private string path;
    private Scene scene;
    public UnityEvent forceUpdate;
    public UnityEvent<bool> passthroughEvent, trackerEvent;
    public List<Slider> sliders;
    private bool enablePassthrough=true;

    public void passthrough(bool activate){
        enablePassthrough = activate;
        Refresh();
    }

    void Refresh() {
        if (enablePassthrough){
            passthroughEvent.Invoke(true);
        } else {
            passthroughEvent.Invoke(false);
        }
    }
    void OnEnable()
    {
        //Set sliders in correct position
        //Color
        sliders[4].value = currentVideo.Exposition;
        sliders[5].value = currentVideo.Saturation;
        sliders[6].value = currentVideo.Contrast;

        //Offset
        if(sliders[7]){
            sliders[7].value = currentVideo.offsetHorizontal;
            sliders[8].value = currentVideo.offsetVertical;
            sliders[9].value = currentVideo.zoom;
        }

        if (sliders[10]){
            sliders[10].value = currentVideo.depth;
        }

        // Baseline
        if (sliders[11]){
            sliders[11].value = currentVideo.baseline;
        }

        // Edge sens
        if (sliders[13]){
            sliders[13].value = currentVideo.edgeSens;
        }

        if (sliders[14]){
            Debug.Log("VOLUMEBUG setting volume to saved value: "+ currentVideo.volume.ToString());
            sliders[14].value = currentVideo.volume;
        }

        //Helper variables
        scene = SceneManager.GetActiveScene();
        path = currentVideo.path;
        hints = mediaPlayer.FallbackMediaHints;

        if (scene.name == "Classic")
        {
            //Load video
            if (currentVideo.preprocessed)
            {
                if (currentVideo.format == 0) {
                        //Show only color parts (first two panels)
                    hints.stereoPacking = StereoPacking.LeftRight;
                    currentVideo.mapping = videoMapping.HalfSphere;
                    //currentVideo.packing = packingStereo.LeftRight;
                    mediaPlayer.VideoLayoutMapping = VideoMapping.EquiRectangular360;

                    trackerEvent.Invoke(true);

                    SetMaterial(true);
                    if (HiderSphere)
                    {
                        HiderSphere.SetActive(true);
                    }
                    if(flatScreen){flatScreen.SetActive(false);}
                    if(SphereMat){SphereMat.SetActive(true);}
                } else if (currentVideo.format ==1 ){
                    hints.stereoPacking = StereoPacking.None;
                    currentVideo.mapping = videoMapping.Flat;
                    currentVideo.packing = packingStereo.None;

                    trackerEvent.Invoke(false);

                    mediaPlayer.VideoLayoutMapping = VideoMapping.Normal;
                    SetMaterial(false);
                    if (HiderSphere)
                    {
                        HiderSphere.SetActive(false);
                    }
                    if(flatScreen){flatScreen.SetActive(true);}
                    if(SphereMat){SphereMat.SetActive(false);}
                }
                

            } else
            { 

                //Load stereo packing previously set in object. **Make default: AutoDetect
                switch (currentVideo.packing)
                {
                    case packingStereo.AutoDetect:
                        hints.stereoPacking = StereoPacking.Unknown;
                        break;
                    case packingStereo.LeftRight:
                        hints.stereoPacking = StereoPacking.LeftRight;
                        break;
                    case packingStereo.TopBottom:
                        hints.stereoPacking = StereoPacking.TopBottom;
                        break;
                    case packingStereo.CustomUV:
                        hints.stereoPacking = StereoPacking.CustomUV;
                        break;
                    case packingStereo.None:
                        hints.stereoPacking = StereoPacking.None;
                        break;
                }
                
                //Load mapping previously set
                switch (currentVideo.mapping)
                {
                    case videoMapping.HalfSphere:
                        mediaPlayer.VideoLayoutMapping = VideoMapping.EquiRectangular180;
                        break;
                    case videoMapping.Sphere:
                        mediaPlayer.VideoLayoutMapping = VideoMapping.EquiRectangular360;
                        break;
                    case videoMapping.Flat:
                        mediaPlayer.VideoLayoutMapping = VideoMapping.Normal;
                        if (HiderSphere)
                        {
                            HiderSphere.SetActive(false);
                        }
                        break;
                    case videoMapping.AutoDetect:
                        mediaPlayer.VideoLayoutMapping = VideoMapping.Unknown;
                        break;
                }

                //Select correct "screen"
                if (mediaPlayer.VideoLayoutMapping == VideoMapping.Normal || currentVideo.mapping == videoMapping.Flat)
                {
                    trackerEvent.Invoke(false);

                    Debug.Log("Not Tracking");
                    if(flatScreen){flatScreen.SetActive(true);}
                    if(SphereMat){SphereMat.SetActive(false);}
                    Refresh();
                    if (passSettings)
                    {
                        passSettings.alpha = 1f;
                    }

                } else
                {
                    trackerEvent.Invoke(true);
                    
                    Debug.Log("Tracking");
                    passthroughEvent.Invoke(false);
                    if (passSettings)
                    {
                        passSettings.alpha = 0f;
                    }

                    if(flatScreen){flatScreen.SetActive(false);}
                    if(SphereMat){SphereMat.SetActive(true);}
                }

                SetMaterial(false);
            }
            if (Mesh) {
                Mesh.SetActive(false);
            if (HiderSphere)
                {
                    HiderSphere.SetActive(false);
                }
            }
            
        }

        else if (scene.name == "Dynamic_Interaction")
        {
            if (currentVideo.preprocessed)
            {
                interactionLayout();
            }
            else
            {
                hints.stereoPacking = StereoPacking.None;
                SetMaterial(false);
            }
        }

        else if (scene.name == "Static_Interaction")
        {
            interactionLayout();
            hints.stereoPacking = StereoPacking.LeftRight;
            SetMaterial(currentVideo.preprocessed);
        }

        else if (scene.name == "Hologram_Interaction")
        {
            hints.stereoPacking = StereoPacking.None;
            SetMaterial(false);
        }

        //Load media to AVPro
        mediaPlayer.FallbackMediaHints = hints;
        LoadVideo();
        //Seek to previous session time
        mediaPlayer.Control.Seek(currentVideo.lastTime);
    }

    //Hider sphere, Depth mesh, stereo packing. Everything for interaction.
    private void interactionLayout()
    {
        if (Mesh)
        {
            Mesh.SetActive(true);
        }
        if (HiderSphere)
        {
            HiderSphere.SetActive(true);
        }
        
        // Changing the media hints for content loaded via Path

        if (scene.name == "Dynamic_Interaction" || scene.name == "Hologram_Interaction")
        {
            hints.stereoPacking = StereoPacking.None;
        }
        else
        {
            hints.stereoPacking = StereoPacking.LeftRight;
        }

        //Display color part only
        forceUpdate.Invoke();
    }

    //Load layout (UI)
    public void loadLayout(int layout)
    {
        currentVideo.volumetricPlayback = false;
        hints = mediaPlayer.FallbackMediaHints;
        //Go to "classic" scene, no interaction.
        if (scene.name != "Classic")
        {
            SceneManager.LoadScene("Classic", LoadSceneMode.Single);
        }

        //Show color part **Duplicated function
        if (currentVideo.preprocessed)
        {
            hints.stereoPacking = StereoPacking.LeftRight;
            currentVideo.packing = packingStereo.LeftRight;
            currentVideo.mapping = videoMapping.HalfSphere;
            SetMaterial(true);
        }
        //Select user defined layout
        else
        {
            if (layout == 0)
            {
                hints.stereoPacking = StereoPacking.LeftRight;
                currentVideo.packing = packingStereo.LeftRight;
            }
            else if (layout == 1)
            {
                hints.stereoPacking = StereoPacking.TopBottom;
                currentVideo.packing = packingStereo.TopBottom;
            }
            else if (layout == 2)
            {
                hints.stereoPacking = StereoPacking.None;
                currentVideo.packing = packingStereo.None;
            }
            else
            {
                hints.stereoPacking = StereoPacking.Unknown;
                currentVideo.packing = packingStereo.AutoDetect;
            }
            SetMaterial(false);
        }

        
        //Apply hints
        mediaPlayer.FallbackMediaHints = hints;
        
        //Refresh player -- crash!
        currentVideo.lastTime = (float)mediaPlayer.Control.GetCurrentTime();
        mediaPlayer.Control.Pause();
        LoadVideo();
        mediaPlayer.Control.Seek(currentVideo.lastTime);
        //Refresh sphere if it was prev active(bug)
        if (SphereMat.activeSelf)
        {
            SphereMat.SetActive(false);
            SphereMat.SetActive(true);
        }
    }

    private void LoadVideo() {
        if (currentVideo.reference == videoReference.PersistentData)
        {
            bool isOpening = mediaPlayer.OpenMedia(new MediaPath(path, MediaPathType.RelativeToDataFolder), autoPlay: true);

        } else if (currentVideo.reference == videoReference.StreamingAssets)
        {
            bool isOpening = mediaPlayer.OpenMedia(new MediaPath(path, MediaPathType.RelativeToStreamingAssetsFolder), autoPlay: true);
        } 
        else if (currentVideo.reference == videoReference.Absolute)
        {
            bool isOpening = mediaPlayer.OpenMedia(new MediaPath(path, MediaPathType.AbsolutePathOrURL), autoPlay: true);   
        } else 
        {
            Debug.Log("Error: No reference");
        }
    }

    //Make material display color part only, no depth information.
    private void SetMaterial(bool pre)
    {
        if (!SphereMat)
            return;

        if (pre)
        {
            SphereMat.GetComponent<Renderer>().material.EnableKeyword("PREPROCESSED");
            SphereMat.GetComponent<Renderer>().material.SetFloat("_Preprocessed", 1f);
        } else
        {
            SphereMat.GetComponent<Renderer>().material.DisableKeyword("PREPROCESSED");
            SphereMat.GetComponent<Renderer>().material.SetFloat("_Preprocessed", 0f);
        }

        forceUpdate.Invoke();
    }

    //Load mapping (UI)
    public void loadMapping(int mapping)
    {
        currentVideo.volumetricPlayback = false;
        //forceUpdate.Invoke();
        if (scene.name != "Classic")
        {
            SceneManager.LoadScene("Classic", LoadSceneMode.Single);
        }

        if (Mesh)
        {
            Mesh.SetActive(false);
        }

        //Necessary??
        if (currentVideo.preprocessed)
        {
            //currentVideo.mapping = videoMapping.Flat;
            //mediaPlayer.VideoLayoutMapping = VideoMapping.Normal;
            //SetMaterial(true);
            Debug.Log("Wrong setting");
        }
        else
        {
            
            passthroughEvent.Invoke(false);

            if (passSettings){
                passSettings.alpha=0f;
            }
            
            //User defined mapping
            if (mapping == 0)
            {
                trackerEvent.Invoke(true);
                currentVideo.mapping = videoMapping.HalfSphere;
                mediaPlayer.VideoLayoutMapping = VideoMapping.EquiRectangular180;
                if (HiderSphere)
                {
                    HiderSphere.SetActive(true);
                }

            }
            else if (mapping == 1)
            {
                trackerEvent.Invoke(true);
                currentVideo.mapping = videoMapping.Sphere;
                mediaPlayer.VideoLayoutMapping = VideoMapping.EquiRectangular360;
                if (HiderSphere)
                {
                    HiderSphere.SetActive(false);
                }

            }
            else if (mapping == 2)
            {
                trackerEvent.Invoke(false);
                currentVideo.mapping = videoMapping.Flat;
                mediaPlayer.VideoLayoutMapping = VideoMapping.Normal;

                if (passSettings){
                    passSettings.alpha = 1f;
                }

                if (HiderSphere)
                {
                    HiderSphere.SetActive(false);
                }

                Refresh();
            }
            else
            {
                currentVideo.mapping = videoMapping.AutoDetect;
                mediaPlayer.VideoLayoutMapping = VideoMapping.Unknown;
            }

            SetMaterial(currentVideo.preprocessed);
        }

        //Select correct "screen"
        if (mediaPlayer.VideoLayoutMapping == VideoMapping.Normal)
        {
            flatScreen.SetActive(true);
            SphereMat.SetActive(false);
        }
        else
        {
            flatScreen.SetActive(false);
            SphereMat.SetActive(true);
        }

        //Refresh player
        //bool isOpening = mediaPlayer.OpenMedia(new MediaPath(path, MediaPathType.AbsolutePathOrURL), autoPlay: true);
    }

    //Mappings with interaction (UI).
    public void loadInteractiveMapping(int mapping)
    {   
        currentVideo.volumetricPlayback = true;
        if ((mapping == 0) && (scene.name != "Static_Interaction"))
        {
            currentVideo.mode = volumetricMode._Static;
            SceneManager.LoadScene("Static_Interaction", LoadSceneMode.Single);
        }
        else if ((mapping == 1)&&(scene.name != "Dynamic_interaction"))
        {
            currentVideo.mode = volumetricMode._Dynamic;
            SceneManager.LoadScene("Dynamic_interaction", LoadSceneMode.Single);
        }
        else if ((mapping == 2)&&(scene.name != "Hologram_interaction"))
        {
            currentVideo.mode = volumetricMode._Passthrough;
            SceneManager.LoadScene("Hologram_Interaction", LoadSceneMode.Single);
        }
    }

    void OnDisable() //Save settings in between modes
    {
        if (sliders[14]){
            currentVideo.volume = (int)sliders[14].value;
            Debug.Log("VOLUMEBUG saving volume as : "+ currentVideo.volume.ToString());
        }
        
        currentVideo.Exposition = (int)sliders[4].value;
        currentVideo.Saturation = (int)sliders[5].value;
        currentVideo.Contrast = (int)sliders[6].value;

        if (sliders[7])
        {
            currentVideo.offsetHorizontal = (int)sliders[7].value;
            currentVideo.offsetVertical = (int)sliders[8].value;
            currentVideo.zoom = (int)sliders[9].value;
        }

        // Depth
        if (sliders[10]){
            currentVideo.depth = (float)sliders[10].value;
        }
        
        // Baseline
        if (sliders[11]){
            currentVideo.baseline = (int)sliders[11].value;
        }

        if (sliders[13]){
            currentVideo.edgeSens = (int)sliders[13].value;
        }

        
    }

    //MediaPlayer mp, EventType eventType, ErrorCode error
    public void Closing() //Save settings when quiting to menu
    {
        VideoData vd = new VideoData();

        // Sliders to CurrentVideo
        //Color
        currentVideo.Exposition = (int)sliders[4].value;
        currentVideo.Saturation = (int)sliders[5].value;
        currentVideo.Contrast = (int)sliders[6].value;

        
        if (sliders[7])
        {
            currentVideo.offsetHorizontal = (int)sliders[7].value;
            currentVideo.offsetVertical = (int)sliders[8].value;
            currentVideo.zoom = (int)sliders[9].value;
        }

        // Depth
        if (sliders[10])
        {
            currentVideo.depth = (float)sliders[10].value;
        }
        // Baseline
        if (sliders[11])
        {
            currentVideo.baseline = (int)sliders[11].value;
        }

        // Load dictionary from storage or create one
        if (ES3.KeyExists("videoDict"))
        {
            videoDict = ES3.Load<Dictionary<string, VideoData>>("videoDict");

            if (videoDict.ContainsKey(path))
            {
                vd = videoDict[path];
            }

            if (videoDict == null)
            {
                videoDict = new Dictionary<string, VideoData>();
            }
        }
        else
        {
            videoDict = new Dictionary<string, VideoData>();
        }

        // Add current video info to dictionary, or replace existing

        //Copy data to vd
        vd.packing = currentVideo.packing;
        vd.mapping = currentVideo.mapping;
        vd.reference = currentVideo.reference;
        vd.preprocessed = currentVideo.preprocessed;
        vd.volumetricPlayback = currentVideo.volumetricPlayback;
        vd.lastTime = (float)mediaPlayer.Control.GetCurrentTime();
        vd.path = currentVideo.path;
        vd.mode = currentVideo.mode;

        //Holo settings
        if (sliders[0])
        {
            vd.opacity = sliders[0].value;
            vd.holoWidth = sliders[1].value;
            vd.holoCenter = sliders[2].value;
            vd.holoSmoothing = sliders[3].value;
            vd.holoFocus = sliders[12].value;
        }

        //Color
        if (sliders[4]){
            vd.Exposition = (int)sliders[4].value;
            vd.Saturation = (int)sliders[5].value;
            vd.Contrast = (int)sliders[6].value;
        }

        //Offset
        if (sliders[7]){
            vd.offsetHorizontal = (int)sliders[7].value;
            vd.offsetVertical = (int)sliders[8].value;
            vd.zoom = (int)sliders[9].value;
        }

        // Depth
        if (sliders[10]){
            vd.depth = (float)sliders[10].value;
        }

        if (sliders[13]){
            vd.edgeSens = (float)sliders[13].value;
        }

        // Baseline
        if (sliders[11]){
            vd.baseline = (int)sliders[11].value;
        }

        if (videoDict.ContainsKey(path))
        {
            videoDict[path] = vd;
        }
        else
        {
            videoDict.Add(path, vd);
        }

        //Save dictionary 
        ES3.Save("videoDict", videoDict);
    }
}
