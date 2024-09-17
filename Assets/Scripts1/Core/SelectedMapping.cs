using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using static CurrentVideo;

public class SelectedMapping : MonoBehaviour
{
    public CurrentVideo currentVideo;
    public GameObject selected;
    public videoMapping identifier;

    // Display current stereo packing
    void OnEnable() {UpdateStatus();}

    public void UpdateStatus()
    {
        if (currentVideo.mapping == identifier)
        {
            selected.SetActive(true);
        }
        else
        {
            selected.SetActive(false);
        }
    }
}
