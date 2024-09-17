using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using RenderHeads.Media.AVProVideo;
using UnityEngine.Events;
using TMPro;
using ES3Internal;

public class Clipboard : MonoBehaviour
{
    // Start is called before the first frame update
    public MediaPlayer mediaPlayer;
    public UnityEvent<string, string, bool, int> loadVideo;
    public UnityEvent<string> addProviderEvent;
    string url;
    public GameObject clipboardVideo, clipboardJson;
    Dictionary<string, string> providers;
    List<string> providerValues;

    void Start(){
        Refresh();
        //Listeners
        OVRManager.InputFocusLost += Refresh;
        OVRManager.HMDUnmounted += Refresh;
        OVRManager.InputFocusAcquired += Refresh;
        OVRManager.HMDMounted += Refresh;
    }

    void OnEnable(){
        Refresh();
    }

    public void addProvider(){
        addProviderEvent.Invoke(url);
    }

    public void Refresh()
    {
        Debug.Log("Refreshing");
        clipboardVideo.SetActive(false);
        clipboardJson.SetActive(false);
        url = GUIUtility.systemCopyBuffer;
        Debug.Log(url);

        if (url.Contains(".json")){

            //Check if provider is already in list
            if (ES3.KeyExists("Providers") && providers == null)
            {
                Debug.Log("Providers found, loading from disk, checking if is already in list");

                providers = ES3.Load<Dictionary<string, string>>("Providers");

                
                if (providers != null)
                {
                    providerValues = new List<string>();
                    foreach (KeyValuePair<string, string> provider in providers)
                    {
                        providerValues.Add(provider.Value);
                    }
                } else {
                    providerValues = new List<string>();
                    providerValues.Add("");
                }
            }
            Debug.Log("JSON found");

            if (!providerValues.Contains(url)){
                clipboardJson.SetActive(true);
            }
            
        } else {
            //Show button only if video plays without error
            if (url != null && url != "")
            {
                mediaPlayer.OpenMedia(new MediaPath(url, MediaPathType.AbsolutePathOrURL), autoPlay: false);
            }
        }
        
    }
    

    public void PlayVideo(){
        if (clipboardVideo.activeSelf){
            string name = url.Substring(url.LastIndexOf('/') + 1);
            bool pre = false ;
            int format = 0;

            if (name.Contains("Touchly0")){
                pre= true;
                format = 0;
            } else if (name.Contains("Touchly1")){
                pre= true;
                format = 1;
            } else if (name.Contains("Touchly2")){
                pre= true;
                format = 2;
            }
            else {
                pre = false;
            }

            loadVideo.Invoke(url , name, pre, format);
        }   
    }

    void OnApplicationPause(bool pauseStatus)
    {
        Refresh();
    }

    public void HandleEvent(MediaPlayer mp, MediaPlayerEvent.EventType eventType, ErrorCode code)
    {
        if (eventType == MediaPlayerEvent.EventType.Error)
        {
            Debug.LogError("Error: " + code);
        } 
        else if (eventType == MediaPlayerEvent.EventType.ReadyToPlay) {
            clipboardVideo.SetActive(true);
        }
    }

}
