using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.UI;
using System;
using System.IO;
using UnityEngine.SceneManagement;
using RenderHeads.Media.AVProVideo;
using static CurrentVideo;
using UnityEngine.Android;
using UnityEngine.Networking;
using ES3Internal;
using System.Threading.Tasks;


using AndroidLocalGalleryPlugin;


public class FilesAVPro : MonoBehaviour
{
    private Dictionary<string, VideoData> videoDict;
    private int preprocessed;
    public CurrentVideo currentVideo;
    private bool pre, frameReady;
    private Texture2D texture;
    private int width, height;
    public GameObject errorMessage, loading;
    
    private static AndroidJavaClass m_ajc = null;
    private static AndroidJavaClass AJC
	{
		get
		{
			if( m_ajc == null )
				m_ajc = new AndroidJavaClass( "com.yasirkula.unity.NativeGallery" );

			return m_ajc;
		}
	}
    
	private static AndroidJavaObject m_context = null;
	private static AndroidJavaObject Context
	{
		get
		{
			if( m_context == null )
			{
				using( AndroidJavaObject unityClass = new AndroidJavaClass( "com.unity3d.player.UnityPlayer" ) )
				{
					m_context = unityClass.GetStatic<AndroidJavaObject>( "currentActivity" );
				}
			}

			return m_context;
		}
	}
    
    IEnumerator WaitForFrame()
    {
        yield return new WaitUntil(() => frameReady);
        frameReady = false;
    }

    void ThumbnailReady(VideoPlayer source, long frameIdx)
    {
        frameReady = true;
    }

    void ErrorReceived(VideoPlayer source, string message)
    {
        Debug.LogError("Error: " + message);
        Destroy(source);
    }

    private static async Task<T> TryCallNativeAndroidFunctionOnSeparateThread<T>( Func<T> function )
	{
		T result = default( T );
		bool hasResult = false;

		await Task.Run( () =>
		{
			if( AndroidJNI.AttachCurrentThread() != 0 )
				Debug.LogWarning( "Couldn't attach JNI thread, calling native function on the main thread" );
			else
			{
				try
				{
					result = function();
					hasResult = true;
				}
				finally
				{
					AndroidJNI.DetachCurrentThread();
				}
			}
		} );

		return hasResult ? result : function();
	}

    public static async Task<string> GetVideoThumbnailAsync( string videoPath, string imagePath, int maxSize = -1, double captureTimeInSeconds = -1.0, bool markTextureNonReadable = true, bool generateMipmaps = true, bool linearColorSpace = false)
	{
		if( maxSize <= 0 )
			maxSize = SystemInfo.maxTextureSize;

		string thumbnailPath = await TryCallNativeAndroidFunctionOnSeparateThread( () => AJC.CallStatic<string>( "GetVideoThumbnail", Context, videoPath, imagePath, false, maxSize, captureTimeInSeconds ) );
        return thumbnailPath;
	}

    private IEnumerator GetFiles(List<string> paths)
    {
        
        //List to store files with the filter
        //Videos
        List<FileInfo> files2 = new List<FileInfo>();
        //Thumbnails
        List<FileInfo> texturesList = new List<FileInfo>();
        
        //Thumbnails path

        #if UNITY_EDITOR || UNITY_ANDROID
        string persistentDataPath = Application.persistentDataPath;
        #else
        
        string persistentDataPath = System.IO.Directory.GetCurrentDirectory();
        //Create folder if it doesn't exist
        if (!Directory.Exists(persistentDataPath + "/Thumbnails"))
        {
            Directory.CreateDirectory(persistentDataPath + "/Thumbnails");
            persistentDataPath = persistentDataPath + "/Thumbnails";
        } else {
            persistentDataPath = persistentDataPath + "/Thumbnails";
        }
        #endif

        DirectoryInfo dirThumbnail = new DirectoryInfo(persistentDataPath);
        //All video extensions supported by Unity
        string[] extensions = new string[] { ".asf", ".avi", ".dv", ".m4v", ".mov", ".mp4", ".mpg", ".mpeg", ".ogv", ".vp8", ".wmv", ".mkv" };

        var files = new FileInfo[0];
        var textures = new FileInfo[0];

        textures = dirThumbnail.GetFiles("*.*", SearchOption.AllDirectories);

        foreach (var pic in textures) {
            
            if (pic.Extension.ToLower().Contains(".png"))
            {
                //Debug.Log("(SCANBUG)  Adding texture: " + pic.Name);
                texturesList.Add(pic);
            }
        }

/*
            string path = "/storage/emulated/0/";

            Debug.Log("(SCANBUG) Trying to look in root path: " + path);
            //Videos path
            
            DirectoryInfo dir = new DirectoryInfo(path);
            //Get all files
            files = dir.GetFiles("*.*", SearchOption.AllDirectories);
            //textures = dirThumbnail.GetFiles("*.*", SearchOption.AllDirectories);

            //Add to file array if extension is on the list
            foreach (var file in files)
            {
                Debug.Log("(SCANBUG)  Scanned file: " + file.Name);
                foreach (var extension in extensions)
                {
                    if (file.Extension.ToLower().Contains(extension))  //file.Extension.ToLower() in extensions
                    {
                        files2.Add(file);
                    }
                }
            }

            */ 

            foreach(string path in paths){
            //Videos path
            DirectoryInfo dir = new DirectoryInfo(path);

            if (!dir.Exists)
                Debug.Log("This path does not exist: "+ path);

            //Get all files
            //files = dir.GetFiles("*.*", SearchOption.AllDirectories);
            files = dir.GetFiles();
            
            //Debug.Log("(SCANBUG) Directories: " + dir.GetDirectories());

            //Add to file array if extension is on the list
            foreach (var file in files)
            {
                foreach (var extension in extensions)
                {
                    //Debug.Log("(SCANBUG) File: " + file.Name);
                    if (file.Extension.ToLower().Contains(extension))  //file.Extension.ToLower() in extensions
                    {
                        //Debug.Log("(SCANBUG) Scanned file in the sub-directories: " + file.Name);
                        files2.Add(file);
                    }
                }
            }
            }
       
        
                    //Add to texture array if extension is on the list
        //Files back at var "files"
        files = files2.ToArray();
        textures = texturesList.ToArray();

        int filesLenght = files.Length;
        Debug.Log("Found " + filesLenght.ToString() + " video files");
        Debug.Log("Found " + textures.Length.ToString() + " thumbnail files");

        VideoPlayer controller = gameObject.AddComponent<VideoPlayer>();
        controller.errorReceived += ErrorReceived;
        controller.renderMode = VideoRenderMode.RenderTexture;
        //For each file make thumbnail or load it from the cache
        for (int i = 0; i < filesLenght; i++)
        {
            if (File.Exists(files[i].FullName))
            {
                //Name of file
                string fileName = files[i].Name;
                
                //Search for texture with the file name
                string filePath = Path.Combine(persistentDataPath, fileName+".png");

                if (File.Exists(filePath)){
                    //Load thumbnail texture
                    byte[] fileData = File.ReadAllBytes(filePath);
                    texture = new Texture2D(256, 256, TextureFormat.RGBA32, false);
                    texture.LoadImage(fileData);
                } else {
                    //Create thumbnail texture
                    System.Diagnostics.Stopwatch sw = new System.Diagnostics.Stopwatch();
                    sw.Start();

                    bool _continue = true;
                    
                    try
                    {
                        controller.url = files[i].FullName;
                    }
                    catch
                    {
                        Debug.Log("Video could not be played by Unity Video Player");
                    }

                    try{
                        if (controller.url == ""){
                            _continue = false;
                        }
                    } catch {
                        _continue = false;
                    }
                    

                    if (_continue){
                        controller.audioOutputMode = VideoAudioOutputMode.None;
                        //volume 0
                        controller.SetDirectAudioVolume(0, 0);
                        bool continue2 = true;

                        while (!controller.isPrepared)
                        {
                            yield return null;
                            if (controller == null) { 
                                continue2=false;
                                texture = new Texture2D(128, 128, TextureFormat.RGBA32, false);
                                width = 128;
                                height = 128;
                                break;
                            }
                        }
                        if (continue2) {
                            //Take dimensions of video frame
                            width = controller.texture.width;
                            height = controller.texture.height;

                            controller.time = 0f;
                            //Makes temporary RenderTexture
                            RenderTexture renderTexture = new RenderTexture(width, height, 24, RenderTextureFormat.ARGB32);
                            renderTexture.name = files[i].Name + "Render";
                            //Assigns it to the temporary Video Player
                            controller.waitForFirstFrame = true;
                            controller.skipOnDrop = true;

                            controller.SetDirectAudioMute(0, true);
                            controller.targetTexture = renderTexture;
                            controller.sendFrameReadyEvents = true;
                            controller.Play();

                            //Wait until frame is ready
                            controller.frameReady += ThumbnailReady;
                            yield return StartCoroutine(WaitForFrame());

                            //Copies it to another texture
                            texture = new Texture2D(width, height, TextureFormat.RGBA32, false);
                            RenderTexture.active = controller.targetTexture;
                            texture.ReadPixels(new Rect(0, 0, width, height), 0, 0);
                            texture.Apply();
                            controller.Stop();
                            RenderTexture.active = null;

                            Debug.Log("Creating thumbnail");
                            //Get it ready
                            int formatNum = 0;

                            if (files[i].Name.Contains("Touchly1")){
                                formatNum =1;
                            } else if (files[i].Name.Contains("Touchly2")){
                                formatNum =2;
                            }
                            sw.Stop();
                            Debug.Log("Extracting from VideoPlayer took: " + sw.ElapsedMilliseconds + "ms");
                            
                            sw = new System.Diagnostics.Stopwatch();
                            sw.Start();
                            texture = ResampleAndCrop(texture, 128, 128, formatNum);
                            sw.Stop();
                            Debug.Log("ResampleAndCrop took: " + sw.ElapsedMilliseconds + "ms");

                            //texture = ResampleAndCrop(tex, 256, 256, formatNum);
                            //Save texture as png
                            byte[] bytes = texture.EncodeToPNG();
                            //Delete file if it exists
                            if (File.Exists(filePath))
                            {
                                File.Delete(filePath);
                            }
                            File.WriteAllBytes(filePath, bytes);

                            controller.targetTexture = null;
                            //Destroy(controller);
                            Destroy(renderTexture);
                            }
                            } else {
                               texture = new Texture2D(128, 128, TextureFormat.RGBA32, false);
                                width = 128;
                                height = 128;
                            }
                }
                
                //Debug.Log("(SCANBUG)  Creating gameobject for: " + files[i].Name);
                //Create a GameObject based on prefab with the preview image.
                GameObject go = Instantiate(Resources.Load("preview") as GameObject);
                go.transform.SetParent(gameObject.transform);
                //go.transform.GetComponent<RectTransform>().position = new Vector3(50, -50,0);
                go.transform.localPosition = Vector3.zero;
                go.transform.localScale = Vector3.one;
                go.name = files[i].Name;
                
                go.GetComponentInChildren<Text>().text = files[i].Name;

                //text.text= files[i].Name;
                var sprite = Sprite.Create(texture, new Rect(0, 0, texture.width, texture.height), new Vector2(0.5f, 0.5f));
                go.transform.GetComponent<Image>().sprite = sprite;
                gameObject.GetComponent<RectTransform>().sizeDelta = new Vector2(0, (i + 1) / 4 * 125);

                int format =0 ; 

                if (files[i].Name.Contains("Touchly0")){
                    pre= true;
                    format = 0;
                } else if (files[i].Name.Contains("Touchly1")){
                    pre= true;
                    format = 1;
                } else if (files[i].Name.Contains("Touchly2")){
                    pre= true;
                    format = 2;
                }
                else {
                    pre = false;
                }

                if (pre){
                    GameObject im = Instantiate(Resources.Load("flag") as GameObject);
                    im.transform.SetParent(go.transform);
                    im.transform.localPosition = new Vector3(30.1f, -29.97f, 0f);
                    im.transform.localScale = Vector3.one * 0.3f;
                }

                //Add button event to open scene
                Button button = go.GetComponent<Button>();

                button.name = files[i].Name + "Button";

                var videoPath = files[i].FullName;
                var videoName = files[i].Name;

                if (pre)
                {
                    button.onClick.AddListener(() => SceneInfo(videoPath, videoName, true, format));
                }
                else
                {
                    button.onClick.AddListener(() => SceneInfo(videoPath, videoName, false, format));
                }

            }
            yield return null;
        }
    }

    private static string GetAndroidExternalFilesDir()
    {
     using (AndroidJavaClass unityPlayer = 
            new AndroidJavaClass("com.unity3d.player.UnityPlayer"))
     {
          using (AndroidJavaObject context = 
                 unityPlayer.GetStatic<AndroidJavaObject>("currentActivity"))
          {
               // Get all available external file directories (emulated and sdCards)
               AndroidJavaObject[] externalFilesDirectories = 
                                   context.Call<AndroidJavaObject[]>
                                   ("getExternalFilesDirs", (object)null);
               AndroidJavaObject emulated = null;
               AndroidJavaObject sdCard = null;
               for (int i = 0; i < externalFilesDirectories.Length; i++)
               {
                    AndroidJavaObject directory = externalFilesDirectories[i];
                    using (AndroidJavaClass environment = 
                           new AndroidJavaClass("android.os.Environment"))
                    {
                        // Check which one is the emulated and which the sdCard.
                        bool isRemovable = environment.CallStatic<bool>
                                          ("isExternalStorageRemovable", directory);
                        bool isEmulated = environment.CallStatic<bool>
                                          ("isExternalStorageEmulated", directory);
                        if (isEmulated)
                            emulated = directory;
                        else if (isRemovable && isEmulated == false)
                            sdCard = directory;
                    }
               }
               // Return the sdCard if available
               string path = "";
               if (sdCard != null)
                    path =  sdCard.Call<string>("getAbsolutePath");
               else
                    path =  emulated.Call<string>("getAbsolutePath");
                
                // Return path before /Android/
                return path.Substring(0, path.IndexOf("/Android/"));
            }
      }
    }
    
    public static Texture2D ResampleAndCrop(Texture2D source, int targetWidth, int targetHeight, int format)
    {
        int sourceWidth = source.width;
        int sourceHeight = source.height;

        float sourceAspect = (float)sourceWidth / sourceHeight;
        float targetAspect = (float)targetWidth / targetHeight;
        int xOffset = 0;
        int yOffset = 0;
        float factor = 1;
        
        if (sourceAspect > targetAspect)
        { // crop width
            factor = (float)targetHeight / sourceHeight;
            //xOffset = (int)((sourceWidth - sourceHeight * targetAspect) * 0.5f);
        }
        else
        { // crop height
            factor = (float)targetWidth / sourceWidth;
            //yOffset = (int)((sourceHeight - sourceWidth / targetAspect) * 0.5f);
        }

        if ((format==1 || format==2)){
            factor *= 2f;
            yOffset = sourceHeight /2;
        }
        Color32[] data = source.GetPixels32();
        Color32[] data2 = new Color32[targetWidth * targetHeight];
        for (int y = 0; y < targetHeight; y++)
        {
            for (int x = 0; x < targetWidth; x++)
            {
                var p = new Vector2(Mathf.Clamp(xOffset + x / factor, 0, sourceWidth - 1), Mathf.Clamp(yOffset + y / factor, 0, sourceHeight - 1));
                // bilinear filtering
                var c11 = data[Mathf.FloorToInt(p.x) + sourceWidth * (Mathf.FloorToInt(p.y))];
                var c12 = data[Mathf.FloorToInt(p.x) + sourceWidth * (Mathf.CeilToInt(p.y))];
                var c21 = data[Mathf.CeilToInt(p.x) + sourceWidth * (Mathf.FloorToInt(p.y))];
                var c22 = data[Mathf.CeilToInt(p.x) + sourceWidth * (Mathf.CeilToInt(p.y))];
                var f = new Vector2(Mathf.Repeat(p.x, 1f), Mathf.Repeat(p.y, 1f));
                data2[x + y * targetWidth] = Color.Lerp(Color.Lerp(c11, c12, p.y), Color.Lerp(c21, c22, p.y), p.x);
            }
        }

        var tex = new Texture2D(targetWidth, targetHeight);
        tex.SetPixels32(data2);
        tex.Apply(true);
        return tex;
    }

    
    public void searchFiles(int path)
    {
        errorMessage.SetActive(false);
        loading.SetActive(false);
        foreach (Transform child in transform)
        {
            GameObject.Destroy(child.gameObject);
        }
        //Finds windows path "videos" GetExternalFilesDir

#if UNITY_ANDROID && !UNITY_EDITOR
        // get read permission for external storage
    
        if (!Permission.HasUserAuthorizedPermission(Permission.ExternalStorageRead))
        {
          Permission.RequestUserPermission(Permission.ExternalStorageRead);
        }

        //android sd card path
        //string videosPath =  "/storage/emulated/0/";
        string videosPath = GetAndroidExternalFilesDir();
        List<string> videoPaths = new List<string>();

        string root = "/storage/emulated/0/";
        string[] dirs = Directory.GetDirectories(root);

        foreach (string dir in dirs)
        {
            videoPaths.Add(dir);
        }
        Debug.Log("Going to search " + dirs.Length + " directories");

        List<string> desktopPaths = new List<string>();
        //string videosPath = Application.dataPath;
        string desktopPath = "/storage/emulated/0/Download/";
        desktopPaths.Add(desktopPath);

#else
        List<string> videoPaths = new List<string>();

        string videosPath = System.Environment.GetFolderPath(System.Environment.SpecialFolder.MyVideos);
        videoPaths.Add(videosPath);

        List<string> desktopPaths = new List<string>();

        string desktopPath = System.Environment.GetFolderPath(System.Environment.SpecialFolder.Desktop);
        desktopPaths.Add(desktopPath);
        
#endif

        //Destroy all children. (This doesn't sound too nice)
        foreach (Transform child in transform)
        {
            GameObject.Destroy(child.gameObject);
        }

        if ((path == 0))
        {
            StartCoroutine(GetFiles(videoPaths));
        }
        else
        {
            StartCoroutine(GetFiles(desktopPaths));
        }
    }
    
    private videoMapping DetectMapping(string name){
        //Check if '_180' or '_360' is in the name
        if (name.Contains("_180")){
            return videoMapping.HalfSphere;
        }
        else if (name.Contains("_360")){
            return videoMapping.Sphere;
        }
        else{
            return videoMapping.Flat;
        }
    }

    private packingStereo DetectPacking(string name){
        if (name.Contains("LR") || name.Contains("3DH")|| name.Contains("SBS")){
            return packingStereo.LeftRight;
        }
        else if (name.Contains("TB") || name.Contains("3DV") || name.Contains("OverUnder")){
            return packingStereo.TopBottom;
        }
        else {
            return packingStereo.None;
        }
    }

    public void SceneInfo(string path, string name, bool _pre, int format)
    {
        bool canSearch = false;
        Dictionary<string, VideoData> videoDict = null;

        try
        {
            canSearch = ES3.KeyExists("videoDict");
            videoDict = ES3.Load<Dictionary<string, VideoData>>("videoDict");
            Debug.Log("Can read from Dictionary");

            canSearch = canSearch && videoDict.ContainsKey(path);
            Debug.Log("Path exists");
            
        } catch
        {
            canSearch = false;
            Debug.Log("Failed  to seach for Dictionary");
        }

        currentVideo.format = format;
        currentVideo.preprocessed = _pre;

        if (canSearch)
        {
            VideoData vd = videoDict[path];

            //Dirty solution
            //currentVideo.format = vd.format;
            currentVideo.packing = vd.packing;
            currentVideo.mapping = vd.mapping;
            currentVideo.mode = vd.mode;
            currentVideo.volumetricPlayback = vd.volumetricPlayback;
            currentVideo.reference = vd.reference;
            //currentVideo.preprocessed = vd.preprocessed;
            
            if (PlayerPrefs.GetInt("resume_playback",0)==1){
                currentVideo.lastTime = vd.lastTime;
            } else {
                currentVideo.lastTime = 0;
            }
            
            currentVideo.path = vd.path;
            //Passthrough
            currentVideo.opacity = vd.opacity;
            currentVideo.holoWidth = vd.holoWidth;
            currentVideo.holoFocus = vd.holoFocus;
            currentVideo.holoCenter = vd.holoCenter;
            currentVideo.holoSmoothing = vd.holoSmoothing;
            //Color
            currentVideo.Exposition = vd.Exposition;
            currentVideo.Contrast = vd.Contrast;
            currentVideo.Saturation = vd.Saturation;
            //Offset
            currentVideo.offsetHorizontal = vd.offsetHorizontal;
            currentVideo.offsetVertical = vd.offsetVertical;
            currentVideo.zoom = vd.zoom;
            //3D
            currentVideo.depth = vd.depth;
            currentVideo.edgeSens = vd.edgeSens;
            currentVideo.baseline = vd.baseline;
            currentVideo.swap = vd.swap;

            Debug.Log("Using saved video data");
        } else {
            Debug.Log("No saved video data");
            //Default values
            currentVideo.reference = videoReference.Absolute;
            //currentVideo.preprocessed = _pre;
            currentVideo.path = path;

            // Guess from title
            currentVideo.packing = packingStereo.None;
            
            if (_pre){
                currentVideo.volumetricPlayback = true;
                currentVideo.mode = volumetricMode._Dynamic;
            } else {
                currentVideo.volumetricPlayback = false;
                currentVideo.mapping = DetectMapping(name);
                currentVideo.packing = DetectPacking(name);
            }

            //Passthrough
            currentVideo.opacity = 7.92f;
            currentVideo.holoWidth = 0.35f;
            currentVideo.holoCenter = 0.74f;
            currentVideo.holoSmoothing = 0.03f;
            currentVideo.holoFocus = 0f;
            currentVideo.lastTime = 0f;
            //Color
            currentVideo.Exposition = 7;
            currentVideo.Contrast = 7;
            currentVideo.Saturation = 7;
            //Offset
            currentVideo.offsetHorizontal = 0;
            currentVideo.offsetVertical = 0;
            currentVideo.zoom = 0;
            //3D
            currentVideo.depth = 0.742f;
            currentVideo.baseline = 7;
            currentVideo.swap = false;
        }
    
        //Load scene previously set.
        if (currentVideo.volumetricPlayback){
            switch (currentVideo.mode)
            {
                case volumetricMode._Static:
                    if (format != 1){
                        SceneManager.LoadScene("Static_Interaction", LoadSceneMode.Single);
                    } else {
                        SceneManager.LoadScene("Dynamic_Interaction", LoadSceneMode.Single);
                    }
                    break;
                case volumetricMode._Dynamic:
                    SceneManager.LoadScene("Dynamic_Interaction", LoadSceneMode.Single);
                    break;
                case volumetricMode._Passthrough:
                    SceneManager.LoadScene("Hologram_Interaction", LoadSceneMode.Single);
                    break;
                default:
                    SceneManager.LoadScene("Dynamic_Interaction", LoadSceneMode.Single);
                    break;
            }
        }
        else
        {
            SceneManager.LoadScene("Classic", LoadSceneMode.Single);
        }
    }
}
