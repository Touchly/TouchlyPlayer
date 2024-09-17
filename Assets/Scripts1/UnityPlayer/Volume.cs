using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Video;

public class Volume : MonoBehaviour
{
    private VideoPlayer player;
    // Start is called before the first frame update
    void Start()
    {
        player = GameObject.Find("MainPlayer").GetComponent<VideoPlayer>(); 
    }

    // Update is called once per frame
    public void ChangeVolume()
    {
        float value = gameObject.GetComponent<Slider>().value;
        player.SetDirectAudioVolume(0, (float)(value/10));
    }
}
