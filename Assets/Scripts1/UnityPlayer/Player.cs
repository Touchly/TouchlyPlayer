using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.UI;

public class Player : MonoBehaviour
{
    private bool playing;
    private Image _image;
    private Sprite playIcon, pauseIcon;
    public Sprite[] spriteArray;

    private VideoPlayer videoPlayer;

    void Start()
    {
        videoPlayer = GameObject.Find("MainPlayer").GetComponent<VideoPlayer>();
        playing = true;
        //The button's image
        _image = GetComponent<Image>();

        //Play/Pause sprites
        playIcon = spriteArray[0]; 
        pauseIcon = spriteArray[1];
        _image.sprite = pauseIcon;
    }
    public void TogglePlay()
    {
        //If it's playing: pauses, if it's paused: plays.
        if (playing)
        {
            _image.sprite = playIcon;
            playing = false;
            videoPlayer.Pause();
        }
        else
        {
            _image.sprite = pauseIcon;
            playing = true;
            videoPlayer.Play();
        }
    }
}
