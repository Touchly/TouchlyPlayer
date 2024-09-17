using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using static CurrentVideo;

public class Selected : MonoBehaviour
{
    public CurrentVideo currentVideo;
    public GameObject selected;
    public packingStereo identifier;

    // Display current stereo packing
    void Start() {UpdateStatus();}

    public void UpdateStatus()
    {
        if (currentVideo.packing == identifier)
        {
            selected.SetActive(true);
        }
        else
        {
            selected.SetActive(false);
        }
    }
}
