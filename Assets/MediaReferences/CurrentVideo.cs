using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "Data", menuName = "ScriptableObjects/CurrentVideo", order = 1)]

public class CurrentVideo : ScriptableObject
{
    public enum packingStereo
    {
        Unset,
        TopBottom,
        LeftRight,
        CustomUV,
        AutoDetect,
        None
    }

    public enum videoMapping
    {
        Unset,
        HalfSphere,
        Sphere,
        Flat,
        AutoDetect
    }

    public enum volumetricMode
    {
        _Static,
        _Dynamic,
        _Passthrough
    }
    
    public enum videoReference
    {
        Absolute,
        StreamingAssets,
        PersistentData,
    }

    public float aspectRatio =1f ;
    public packingStereo packing;
    public videoMapping mapping;
    public volumetricMode mode;
    public videoReference reference;
    public bool volumetricPlayback;
    public bool preprocessed;
    public float lastTime;
    public string path;

    public int format; // Where the depth map is located + format
    
    //Passthrough
    public float opacity;
    public float holoWidth;
    public float holoCenter;
    public float holoSmoothing;
    public float holoFocus;

    //Color settings
    public int Exposition;
    public int Contrast;
    public int Saturation;

    //Flip
    public bool flipHorizontal;
    public bool flipVertical;

    //Offset
    public float offsetHorizontal;
    public float offsetVertical;
    public float zoom;

    //3d
    public float depth;
    public float edgeSens;
    public int baseline;
    public bool swap;
    
    public int volume = 10;

    // Gaussians

    public int gaussianFrame=0;

}