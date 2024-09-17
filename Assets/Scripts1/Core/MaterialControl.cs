using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;
using static CurrentVideo;

public class MaterialControl : MonoBehaviour
{
    private Material mat;
    public GameObject Screen;
    public CurrentVideo currentVideo;
    public List<Slider> sliders;
    public UnityEvent<Color> setColor;

    //Material settings
    [Range(0.05f, 1f)]
    public float alphaLimit=0.9f;

    // Shader Properties
    private static readonly int Width           = Shader.PropertyToID("_Width");
    private static readonly int Limit           = Shader.PropertyToID("_Limit");
    private static readonly int Center          = Shader.PropertyToID("_Center");
    private static readonly int Opacity         = Shader.PropertyToID("_Opacity");
    private static readonly int Smoothing       = Shader.PropertyToID("_Smoothing");
    private static readonly int Saturation      = Shader.PropertyToID("_Saturation");
    private static readonly int DepthIsColor = Shader.PropertyToID("_DepthIsColor");
    private static readonly int Exposition      = Shader.PropertyToID("_Exposition");
    private static readonly int Contrast        = Shader.PropertyToID("_Contrast");
    private static readonly int MattingType        = Shader.PropertyToID("_MattingType");
    private static readonly int ChromaKeyColor        = Shader.PropertyToID("_ChromaKeyColor");
    private static readonly int Focus        = Shader.PropertyToID("_RadialLimit");


    public void setColorAsDepth(bool set)
    {
        if (mat)
        {
            if (set)
            {
                Debug.Log("depthtex init");
                mat.SetInt(DepthIsColor, 1);
            }
            else
            {
                Debug.Log("depthtex out");
                mat.SetInt(DepthIsColor, 0);
            }
        }
    }

    public void setMattingType(bool set)
    {
        if (mat)
        {
            int type = set ? 1 : 0;
            mat.SetInt(MattingType, type);
        }
    }

    public void setMattingColorCustom(Color color)
    {
        if (mat)
        {
            mat.SetColor(ChromaKeyColor, color);
            Debug.Log(color);
        }
    }

    public void setMattingColor(int index){
        if (mat)
        {
            if (index==0){
                //Chroma Key Green
                mat.SetColor(ChromaKeyColor, new Color(0f , 0.6941f, 0.2509f, 1.0f));
                setColor.Invoke(new Color(0f, 0.6941f, 0.2509f, 1.0f));
            } else if (index==1){
                //Chroma Key Blue
                mat.SetColor(ChromaKeyColor, new Color(0f , 0.2784f, 0.7333f, 1.0f));
                setColor.Invoke(new Color(0f, 0.2784f, 0.7333f, 1.0f));
            } else {
                //Black
                mat.SetColor(ChromaKeyColor, new Color(0f , 0f, 0f, 1.0f));
                setColor.Invoke(new Color(0f, 0f, 0f, 1.0f));
            }
        }
    }

    //Get data from currentVideo
    void OnEnable()
    {
        mat=Screen.GetComponent<Renderer>().material;

        setMattingType(true); //true

        mat.SetFloat(Limit, alphaLimit);

        mat.SetFloat(Opacity, currentVideo.opacity);
        sliders[0].value = currentVideo.opacity;

        if (currentVideo.holoWidth <= 0)
            currentVideo.holoWidth = 0.01f;
        mat.SetFloat(Width, currentVideo.holoWidth);
        sliders[1].value = currentVideo.holoWidth;

        mat.SetFloat(Center, currentVideo.holoCenter);
        sliders[2].value = currentVideo.holoCenter;

        mat.SetFloat(Smoothing, currentVideo.holoSmoothing);
        sliders[3].value = currentVideo.holoSmoothing;

        mat.SetFloat(Focus, 1f-currentVideo.holoFocus);
        sliders[4].value = currentVideo.holoFocus;
    }
    
    //Setters
    public void ChangeOpacity(float op)
    {
        mat.SetFloat(Opacity, op);
    }

    public void ChangeFocus(float foc)
    {
        mat.SetFloat(Focus, 1f-foc);
    }


    public void ChangeSmoothing(float smooth)
    {
        mat.SetFloat(Smoothing, smooth);
    }

    public void ChangeWidth(float width)
    {
        mat.SetFloat(Width, width);
    }

    public void ChangeCenter(float center)
    {
        mat.SetFloat(Center, center);
    }

    public void ChangeSaturation(float sat)
    {
        float value = Mathf.Lerp(0f, 2f, sat / 14);
        mat.SetFloat(Saturation, value);
    }

    public void ChangeExposition(float exp)
    {
        float value = Mathf.Lerp(0.18f,2f, exp/14);
        mat.SetFloat(Exposition, value);

    }

    public void ChangeContrast(float con)
    {
        float value = Mathf.Lerp(0.38f, 2f, con / 14);
        mat.SetFloat(Contrast, value);
    }

}
