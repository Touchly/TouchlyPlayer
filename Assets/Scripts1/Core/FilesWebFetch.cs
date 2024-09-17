using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Networking;
using UnityEngine.SceneManagement;
using static CurrentVideo;
using ES3Internal;

public class FilesWebFetch : MonoBehaviour
{
    public GameObject Internet;
    private Dictionary<string, VideoData> videoDict;
    public string jsonURL;
    public CurrentVideo currentVideo;
    JsonData jsonData;

    public Sprite[] sprites;

    private void processJsonData (string _url)
    {
        jsonData = JsonUtility.FromJson<JsonData>(_url);
        createVideoLinks(jsonData);
    }

    public void CreateVideos(string _url)
    {
        StartCoroutine(getData(_url));
    }

    IEnumerator getData(string url)
    {
        UnityWebRequest _www = UnityWebRequest.Get(url);

        yield return _www.Send();

        if(!_www.isNetworkError)
        {
            Internet.SetActive(false);
            processJsonData(_www.downloadHandler.text);
        } else
        {
            Debug.Log("Failed to fetch json");
            Internet.SetActive(true);
        }
    }

    void Start()
    {
        //Destroy elements already in object
        foreach (Transform child in transform)
        {
            GameObject.Destroy(child.gameObject);
        }
        StartCoroutine(getData(jsonURL));
    }

    IEnumerator downloadThumbnail(string _url, GameObject go)
    {
        using (UnityWebRequest uwr = UnityWebRequestTexture.GetTexture(_url))
        {
            yield return uwr.SendWebRequest();

            if (uwr.result != UnityWebRequest.Result.Success)
            {
                Debug.Log(uwr.error);
            }
            else
            {
                // Get downloaded asset bundle
                var thumbnail = DownloadHandlerTexture.GetContent(uwr);
                var sprite = Sprite.Create(thumbnail, new Rect(0, 0, thumbnail.width, thumbnail.height), new Vector2(0.5f, 0.5f));
                go.transform.GetComponent<Image>().sprite = sprite;
            }
        }
    }

    public void createVideoLinks(JsonData jsonData){
        //Delete all children of gameobject
        foreach (Transform child in transform)
        {
            GameObject.Destroy(child.gameObject);
        }
        foreach(var video in jsonData.VideoInfo){
            
            GameObject go = new GameObject();

            if (video.format==10){
                go = Instantiate(Resources.Load("previewGaussian") as GameObject);
            } else {
                go = Instantiate(Resources.Load("previewOnline") as GameObject);
            }
            
            go.transform.SetParent(gameObject.transform);
            go.transform.localPosition = Vector3.zero;
            go.transform.localScale = Vector3.one;
            go.name = video.name;

            //Get all children of the gameobject
            Text[] info = go.GetComponentsInChildren<Text>();

            info[0].text = video.author;
            info[1].text = video.name;
            

            //Download thumbnail from server
            if (video.thumbnailUrl != "")
            {
                StartCoroutine(downloadThumbnail(video.thumbnailUrl, go));
            }

            

            //Add button
            Button button = go.GetComponent<Button>();
            button.name = video.name + "Button";
            
            if (video.format==10) {
                info[2].gameObject.SetActive(false);
                string scenePath = Application.persistentDataPath + "/Gaussians/" + video.name + ".bytes";
                if (System.IO.File.Exists(scenePath))
                {
                    //go.GetComponent<Button>().interactable = true;
                    button.GetComponentsInChildren<Image>()[3].sprite = sprites[1];
                } else {
                    //go.GetComponent<Button>().interactable = false;
                    button.GetComponentsInChildren<Image>()[3].sprite = sprites[2];
                }
            }

            button.onClick.AddListener(() => SceneInfo(video, button));
        }
    }

    private IEnumerator DownloadSceneCoroutine(string scenePath, videoInfo videoData, Button button) {

        using (UnityWebRequest www = UnityWebRequest.Get(videoData.videoUrl)) {
            www.downloadHandler = new DownloadHandlerFile(scenePath);

            yield return www.SendWebRequest();

            GameObject go = button.gameObject;
            go.GetComponentsInChildren<Text>()[1].gameObject.SetActive(true);
            button.GetComponentsInChildren<Image>()[3].sprite = sprites[3];

            while (!www.isDone) {
                go.GetComponentsInChildren<Text>()[1].text = string.Format("{0:P0}", www.downloadProgress);
                button.GetComponentsInChildren<Image>()[1].fillAmount = www.downloadProgress;
                Debug.Log(www.downloadProgress);
                Debug.Log("Downloading scene");
                yield return null;
            }

            if (www.result != UnityWebRequest.Result.Success) {
                go.GetComponentsInChildren<Text>()[2].gameObject.SetActive(true);
                go.GetComponentsInChildren<Text>()[1].text= (string)www.error;
                button.GetComponentsInChildren<Image>()[3].sprite = sprites[0];
                button.GetComponentsInChildren<Image>()[1].fillAmount = 0f;
            } else {
                //go.GetComponentsInChildren<Text>()[1].gameObject.SetActive(false);
                //button.interactable = true;
                button.GetComponentsInChildren<Image>()[3].sprite = sprites[1]; //Sprites: Error, Downloaded, Download, Downloading
            }
        }
    }

    private void DownloadScene(videoInfo videoData, Button button) {
        string scenePath = Application.persistentDataPath + "/Gaussians/" + videoData.name + ".bytes";

        if (System.IO.File.Exists(scenePath))
        {
            Debug.Log("Scene already downloaded");
            button.interactable = true;
        } else {
            Debug.Log("Downloading scene");
            button.interactable = false;
            StartCoroutine(DownloadSceneCoroutine(scenePath, videoData, button));
        }
    }

    private void SceneInfo(videoInfo videoData, Button button)
    {
        if (videoData.format == 10){
            DownloadScene(videoData, button);
        }

        //Default
        currentVideo.mode = volumetricMode._Dynamic;
        currentVideo.mapping = videoMapping.HalfSphere;
        currentVideo.packing = packingStereo.LeftRight;
        currentVideo.lastTime = 0f;
        currentVideo.preprocessed = true;
        currentVideo.format = videoData.format;
        currentVideo.volumetricPlayback = true;
        currentVideo.gaussianFrame = 0;
        
        // Saved video data
        if (ES3.KeyExists("videoDict"))
        {
            videoDict = ES3.Load<Dictionary<string, VideoData>>("videoDict");
            currentVideo.preprocessed = true;
            if (videoDict.ContainsKey(videoData.videoUrl))
            {
                VideoData vd = videoDict[videoData.videoUrl];

                //Dirty solution
                currentVideo.packing = vd.packing;
                currentVideo.mapping = vd.mapping;
                currentVideo.reference = vd.reference;
                currentVideo.lastTime = vd.lastTime;
                currentVideo.path = vd.path;
                currentVideo.holoWidth = vd.holoWidth;
                currentVideo.holoCenter = vd.holoCenter;
                currentVideo.holoSmoothing = vd.holoSmoothing;
                currentVideo.mode = vd.mode;
                currentVideo.volumetricPlayback = vd.volumetricPlayback;
                currentVideo.gaussianFrame = vd.gaussianFrame;
                
                Debug.Log("Using saved video data");
            } else {
                Debug.Log("No saved video data");
                //From JSON
                currentVideo.reference = videoReference.Absolute;
                currentVideo.opacity = 7f;
                currentVideo.path = videoData.videoUrl;
                currentVideo.holoWidth = videoData.holoWidth;
                currentVideo.holoCenter = videoData.holoCenter;
                currentVideo.holoSmoothing = videoData.holoSmoothing;

                switch (videoData.playbackMode) {
                    case "Static":
                        currentVideo.mode = volumetricMode._Static;
                        break;
                    case "Dynamic":
                        currentVideo.mode = volumetricMode._Dynamic;
                        break;
                    case "Passthrough":
                        currentVideo.mode = volumetricMode._Passthrough;
                        break;
                    default:
                        currentVideo.mode = volumetricMode._Dynamic;
                        break;
                }
            }
        } else
        {
            currentVideo.reference = videoReference.Absolute;
            currentVideo.opacity = 7f;
            currentVideo.path = videoData.videoUrl;
            currentVideo.holoWidth = videoData.holoWidth;
            currentVideo.holoCenter = videoData.holoCenter;
            currentVideo.holoSmoothing = videoData.holoSmoothing;
            
        }
        //Load scene previously set. Or gaussian if it is one.

        if (videoData.format==10) {
            currentVideo.path = Application.persistentDataPath + "/Gaussians/" + videoData.name + ".bytes";
            SceneManager.LoadScene("Gaussian", LoadSceneMode.Single);
            return;
        }

        if (currentVideo.volumetricPlayback){
            switch (currentVideo.mode)
            {
                case volumetricMode._Static: 
                    SceneManager.LoadScene("Static_Interaction", LoadSceneMode.Single);
                    break;
                case volumetricMode._Dynamic:
                    SceneManager.LoadScene("Dynamic_Interaction", LoadSceneMode.Single);
                    break;
                case volumetricMode._Passthrough:
                    SceneManager.LoadScene("Hologram_Interaction", LoadSceneMode.Single);
                    break;
                default:
                    SceneManager.LoadScene("Static_Interaction", LoadSceneMode.Single);
                    break;
            }
        } else {
            SceneManager.LoadScene("Classic", LoadSceneMode.Single);
        }
    }
        
}
