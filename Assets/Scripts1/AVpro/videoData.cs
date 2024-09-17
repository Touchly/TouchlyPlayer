using System;
using System.Collections.Generic;
using static CurrentVideo;

[Serializable]
public class VideoData
{
    public packingStereo packing;
    public videoMapping mapping;
    public volumetricMode mode;
    public videoReference reference;
    public bool volumetricPlayback;
    public bool preprocessed;
    public float lastTime;
    public string path;
    public int format = 0;
    
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
    public int offsetHorizontal;
    public int offsetVertical;
    public int zoom;

    //3d
    public float depth;
    public float edgeSens;
    public int baseline;
    public bool swap;

    // Gaussians
    public int gaussianFrame;

    
}