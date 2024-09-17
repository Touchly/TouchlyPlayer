using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.UI;
using System;
using System.IO;
using UnityEngine.SceneManagement;

public class Files_OVROverlay : MonoBehaviour
{
    public GameObject playerObject;
    private int preprocessed;
    public RenderTexture inputX2;
    public RenderTexture inputX3;
    private VideoPlayer mainPlayer;
    //private List<bool> pre;
    private bool pre;
    // Start is called before the first frame update
    void OnEnable()
    {
        searchFiles(0);
    }

    private IEnumerator GetFiles(string path)
    {
        //List to store files with the filter
        List<FileInfo> files2 = new List<FileInfo>();

        DirectoryInfo dir = new DirectoryInfo(path);
        //All video extensions supported by Unity
        string[] extensions = new string[] {".asf",".avi",".dv",".m4v",".mov",".mp4",".mpg",".mpeg",".ogv",".vp8",".wmv"};
        //Get all files
        var files = dir.GetFiles("*.*", SearchOption.AllDirectories);

        int n = 0;
        //Add to file array if extension is on the list
        foreach(var file in files)
        {
            foreach(var extension in extensions)
            {
                if (file.Extension.ToLower().Contains(extension))  //file.Extension.ToLower() in extensions
                {
                    files2.Add(file);
                }
            }
            n = n + 1;
        }
        //Files back at var "files"
        files = files2.ToArray();

        //files.Where(f => extensions.Contains(f.Extension.ToLower())).ToArray();

        int filesLenght = files.Length;
        //For each file make thumbnail
        for (int i = 0; i < filesLenght; i++)
        {
            if (File.Exists(files[i].FullName))
            {
                VideoPlayer controller = gameObject.AddComponent<VideoPlayer>();
                controller.renderMode = VideoRenderMode.RenderTexture;
                controller.url= files[i].FullName;
                controller.audioOutputMode = VideoAudioOutputMode.None;
                while (!controller.isPrepared)
                {
                    yield return null;
                }
                
                //Take dimensions of video frame
                int width = controller.texture.width;
                int height = controller.texture.height;

                controller.time = 0f;
                //Makes temporary RenderTexture
                RenderTexture renderTexture = new RenderTexture(width, height, 24, RenderTextureFormat.ARGB32);
                renderTexture.name = files[i].Name + "Render";
                //Assigns it to the temporary Video Player
                controller.waitForFirstFrame=true;
                controller.skipOnDrop = true;

                controller.SetDirectAudioMute(0,true);
                controller.targetTexture = renderTexture;
                
                controller.Play();

                

                yield return new WaitForSeconds(0.14f);

                //Copies it to another texture
                Texture2D texture = new Texture2D(width, height, TextureFormat.RGBA32, false);
                RenderTexture.active = controller.targetTexture;
                texture.ReadPixels(new Rect(0, 0, width, height), 0, 0);
                texture.Apply();
                controller.Stop();
                RenderTexture.active = null;
                //Get it ready
                texture = ResampleAndCrop(texture, 256, 256);

                //Create a GameObject based on prefab with the preview image.
                GameObject go = Instantiate(Resources.Load("preview") as GameObject);
                go.transform.SetParent(gameObject.transform);
                //go.transform.GetComponent<RectTransform>().position = new Vector3(50, -50,0);
                go.transform.localPosition = Vector3.zero;
                go.transform.localScale = Vector3.one;
                go.name = files[i].Name;
                
                go.GetComponentInChildren<Text>().text= files[i].Name;

                //Cube icon for videos that are preprocessed.
                
                //text.text= files[i].Name;
                var sprite= Sprite.Create(texture, new Rect(0, 0, texture.width, texture.height), new Vector2(0.5f, 0.5f));
                go.transform.GetComponent<Image>().sprite = sprite;
                gameObject.GetComponent<RectTransform>().sizeDelta = new Vector2(0, (i + 1)/4 * 300);
                

                if (width / height == 3)
                {
                    GameObject im = Instantiate(Resources.Load("flag") as GameObject);
                    im.transform.SetParent(go.transform);
                    im.transform.localPosition = new Vector3(30.1f, -29.97f, 0f);
                    im.transform.localScale = Vector3.one*0.3f;
                    pre=true;
                } 
                else
                {
                    pre=false;
                }

                //Destoy temp variables
                controller.targetTexture = null;

                //Add button event to open scene
                Button button = go.GetComponent<Button>();
                
                button.name = files[i].Name + "Button";

                var videoPath = files[i].FullName;
                if (pre)
                {
                    button.onClick.AddListener(() => _LoadScene(videoPath, true));
                }
                else
                {
                    button.onClick.AddListener(() => _LoadScene(videoPath, false));
                }
                

                Destroy(renderTexture);
                Destroy(controller);
                
            }
            yield return null;
        }
    }
    
    public static Texture2D ResampleAndCrop(Texture2D source, int targetWidth, int targetHeight)
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
        //Finds windows path "videos"
        string videosPath = System.Environment.GetFolderPath(System.Environment.SpecialFolder.MyVideos);
        string desktopPath = System.Environment.GetFolderPath(System.Environment.SpecialFolder.Desktop);

        //Destroy all children. (This doesn't sound too nice)
        foreach (Transform child in transform)
        {
            GameObject.Destroy(child.gameObject);
        }

        if ((path==0))
        {
            StartCoroutine(GetFiles(videosPath));
        } else
        {
            StartCoroutine(GetFiles(desktopPath));
        }
    }

    void _LoadScene(string path, bool _pre)
    {
        //Set settings in PlayerPrefs
        DontDestroyOnLoad(playerObject.transform);
        mainPlayer=playerObject.GetComponent<VideoPlayer>();
        mainPlayer.url = path;
        mainPlayer.renderMode = UnityEngine.Video.VideoRenderMode.RenderTexture;


        //StartCoroutine(PrepareVideo());
        if (_pre==true)
        {
            preprocessed = 1;
            mainPlayer.targetTexture = inputX3;
        }
        else
        {
            preprocessed = 0;
            mainPlayer.targetTexture = inputX2;
        }
        //Sets to the correct sized texture

        PlayerPrefs.SetInt("preprocessed", preprocessed);
        PlayerPrefs.Save();
        
        SceneManager.LoadScene("Interaction_OVROverlay", LoadSceneMode.Single);
        //Player settings
    }

    IEnumerator PrepareVideo()
    {
        mainPlayer.Prepare();
        while (!mainPlayer.isPrepared)
        {
            yield return null;
        }
        yield return new WaitForSeconds(1f);
        //mainPlayer.Play();
    }
}
