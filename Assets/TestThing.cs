using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using RenderHeads.Media.AVProVideo;

public class TestThing : MonoBehaviour
{
    public CurrentVideo currentVideo;
    
    public MediaPlayer mediaPlayer;

    // Start is called before the first frame update
    void Start()
    {
        string path = currentVideo.path;
        bool isOpening = mediaPlayer.OpenMedia(new MediaPath(path, MediaPathType.AbsolutePathOrURL), autoPlay: true);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}