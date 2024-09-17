using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Video;
using TMPro;

public class VideoSlider : MonoBehaviour
{
    //public UnityEvent<float> setTime;
    private VideoPlayer videoPlayer;
    public GameObject textObject;

    private double minutes;
    private double seconds;
    private int interval;
    public Slider slider;
    private bool _didSeek = false;
    private long Duration, PlaybackPosition, _seekPreviousPosition;

    private string display, time_now, time_total, _minutes, _seconds;
    
    private float _value;
    // Start is called before the first frame update

    //Total time of the video (MM:SS)
    void TotalTimeOfVideo()
    {
        try
        {
            Duration = videoPlayer.frameRate > 0 ? (long)(videoPlayer.frameCount / videoPlayer.frameRate * 1000L) : 0L;
            double time = (double)videoPlayer.frameCount / (double)videoPlayer.frameRate;
            System.TimeSpan VideoUrlLength = System.TimeSpan.FromSeconds(time);
            display = (VideoUrlLength.Minutes).ToString("00") + ":" + (VideoUrlLength.Seconds).ToString("00");
        } catch
        {
            Debug.Log("Invalid frame numbers.");
        }

    }
    //Curent time of the video (MM:SS)
    void CurrentTime()
    {
        double time = videoPlayer.frameRate > 0 ? (videoPlayer.frame / videoPlayer.frameRate) : 0;
        //double time = videoPlayer.frame / videoPlayer.frameRate;
        System.TimeSpan VideoUrlLength = System.TimeSpan.FromSeconds(time);
        display = (VideoUrlLength.Minutes).ToString("00") + ":" + (VideoUrlLength.Seconds).ToString("00");
    }

    void OnEnable()
    {
        
        //Get Video Player and slider component
        videoPlayer = GameObject.Find("MainPlayer").GetComponent<VideoPlayer>();

        //Current value of slider.
        TotalTimeOfVideo();
        time_total = display;
        CurrentTime();
        time_now = display;
        //Set the timer on the canvas
        textObject.GetComponent<TMPro.TextMeshProUGUI>().text = time_now + " / " + time_total;
    }

    //Events aparently dont support long. This one receives float.
    public void SeekToExt(float pos)
    {
        long position = (long)pos;
        _seekPreviousPosition = PlaybackPosition;
        long seekPos = Math.Max(0, Math.Min(Duration, position));
        videoPlayer.time = seekPos / 1000.0;
    }

    //Set value of slider
    private void setSlider()
    {
        if (videoPlayer.frameCount > 0)
        {
            slider.value = ((float)videoPlayer.frame / (float)videoPlayer.frameCount);
        }
    }

    public void setVideoFrame(float _value)
    {
        
        //_value = (float)slider.value;
        long newPos = (long)(_value * Duration);
        
        //Skip only if frame difference makes for longer than 200ms.

        if (Mathf.Abs(newPos - PlaybackPosition) > 200)
        {
            _didSeek = true;
            SeekTo(newPos);
        }
    }

    public void SeekTo(long position)
    {
        _seekPreviousPosition = PlaybackPosition;
        long seekPos = Math.Max(0, Math.Min(Duration, position));
        videoPlayer.time = seekPos / 1000.0;

    }



    void Update()
    {
        if (!_didSeek || Mathf.Abs(_seekPreviousPosition - PlaybackPosition) > 50)
        {
            _didSeek = false;
            if (Duration > 0)
            {
                // update our progress bar
                setSlider();
            }
            else
            {
                slider.value = 0;
            }
        }
        
        //Every Second update the display and slider

        PlaybackPosition = (long)(videoPlayer.time * 1000);
        //Set the Display with Current/Total time
        CurrentTime();
        time_now = display;

        //Set time total only when it is not set. It takes a few frames sometimes.
        if (time_total == null || Duration==0)
        {
            TotalTimeOfVideo();
            time_total = display;
        }
        //Set time to canvas 
        textObject.GetComponent<TMPro.TextMeshProUGUI>().text = time_now + " / " + time_total;
    }
}