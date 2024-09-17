using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using RenderHeads.Media.AVProVideo;
using UnityEngine.UI;

public class LoadingTitle : MonoBehaviour
{
    public Text text;
    public GameObject Debugger;
    // Start is called before the first frame update
    public void HandleEvent(MediaPlayer mp, MediaPlayerEvent.EventType eventType, ErrorCode code)
    {
        text.text= "Loading video ...";
        if (eventType == MediaPlayerEvent.EventType.Error){
            Debugger.SetActive(true);
            text.text= "Unknown error";
        } else if (eventType == MediaPlayerEvent.EventType.ReadyToPlay || eventType == MediaPlayerEvent.EventType.FirstFrameReady){
            Debugger.SetActive(false);
        }
    } 
}
