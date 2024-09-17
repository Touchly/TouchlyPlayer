using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestSettings : MonoBehaviour
{
    public CurrentVideo currentVideo;
    public bool preprocessed;
    public string path;
    // Start is called before the first frame update
    void Awake()
    {
        currentVideo.preprocessed = preprocessed;
        currentVideo.path = path;
    }
}
