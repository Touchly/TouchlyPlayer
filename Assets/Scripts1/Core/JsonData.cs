using System;
using System.Collections.Generic;

[Serializable]
public class JsonData
{
    public string name;
    public List<videoInfo> VideoInfo;
}

[Serializable]
public class videoInfo
{
    // Metadata
    public string name;
    public string author;
    public string videoUrl;
    public string thumbnailUrl;
    public string category;
    public int format;
    // Default settings
    public string playbackMode;
    //public float opacity;
    public float holoWidth;
    public float holoCenter;
    public float holoSmoothing;
}