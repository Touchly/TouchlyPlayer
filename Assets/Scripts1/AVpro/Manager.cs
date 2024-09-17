using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Manager : MonoBehaviour
{
    public GameObject tapador;
    public CurrentVideo currentVideo;
    // Start is called before the first frame update
    void Start()
    {
        //monoScreen.SetActive(currentVideo.preprocessed);
        tapador.SetActive(currentVideo.preprocessed);
    }
}
