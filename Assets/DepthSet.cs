using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class DepthSet : MonoBehaviour
{
    public const string Keyword_ForceEyeNone = "FORCEEYE_NONE";
    public const string Keyword_ForceEyeLeft = "FORCEEYE_LEFT";
    public const string Keyword_ForceEyeRight = "FORCEEYE_RIGHT";
    public GameObject MeshDisplay;
    public Slider slider;

    // Start is called before the first frame update
    void Start() {
        //Scale correctly
        if (slider){
            //#if UNITY_ANDROID && !UNITY_EDITOR
           // slider.minValue = 0.3f;
          //  slider.maxValue = 0.5f;
          //  #else
            slider.minValue = 0.65f;
            slider.maxValue = 0.85f;
        //    #endif
        }

    }
    public void See3D(bool set)
    {
        if (MeshDisplay)
        {
            if (set)
            {
                MeshDisplay.GetComponent<Renderer>().material.DisableKeyword(Keyword_ForceEyeLeft);
                MeshDisplay.GetComponent<Renderer>().material.DisableKeyword(Keyword_ForceEyeRight);
                MeshDisplay.GetComponent<Renderer>().material.EnableKeyword(Keyword_ForceEyeNone);
            } else
            {
                MeshDisplay.GetComponent<Renderer>().material.DisableKeyword(Keyword_ForceEyeLeft);
                MeshDisplay.GetComponent<Renderer>().material.EnableKeyword(Keyword_ForceEyeRight);
                MeshDisplay.GetComponent<Renderer>().material.DisableKeyword(Keyword_ForceEyeNone);
            }
            
        }
    }
}
