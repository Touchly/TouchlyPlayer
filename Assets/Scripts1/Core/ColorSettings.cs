using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;

public class ColorSettings : MonoBehaviour
{
    public GameObject screen;
    private Material mat;
    public CurrentVideo currentVideo;
    public UnityEvent<int, float> setColor;

    private static readonly int Saturation = Shader.PropertyToID("_Saturation");
    private static readonly int Exposition = Shader.PropertyToID("_Exposition");
    private static readonly int Contrast = Shader.PropertyToID("_Contrast");
    private static readonly int Separation = Shader.PropertyToID("_SeparationOffset");

    void OnEnable()
    {
        if (screen){
            mat = screen.GetComponent<Renderer>().material; 
        }
            
        
        //Previous values
        ChangeSaturation(currentVideo.Saturation);
        ChangeExposition(currentVideo.Exposition);
        ChangeContrast(currentVideo.Contrast);
    }

    public void ChangeSeparation(float sep)
    {
        float value = Mathf.Lerp(-0.002f, 0.002f, sep / 14);
        if (mat) {mat.SetFloat(Separation, value);}
    }

    public void ChangeSaturation(float sat)
    {
        float value = Mathf.Lerp(0.5f, 1.5f, sat / 14);
        if (mat) {mat.SetFloat(Saturation, value);}
        setColor.Invoke(Saturation, value);
    }

    public void ChangeExposition(float exp)
    {
        float value = Mathf.Lerp(0.2f,1.8f, exp/14);
        if (mat) {mat.SetFloat(Exposition, value);}
        setColor.Invoke(Exposition, value);
    }

    public void ChangeContrast(float con)
    {
        float value = Mathf.Lerp(0.5f, 1.5f, con / 14);
        if (mat) {mat.SetFloat(Contrast, value);}
        setColor.Invoke(Contrast, value);
    }

}
