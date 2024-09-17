using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;

public class Back : MonoBehaviour
{
    private VideoPlayer videoPlayer;

    void Start()
    {
        videoPlayer = GameObject.Find("MainPlayer").GetComponent<VideoPlayer>();
    }

    public void goBack()
    {
        videoPlayer.frame = 0;
    }
}
