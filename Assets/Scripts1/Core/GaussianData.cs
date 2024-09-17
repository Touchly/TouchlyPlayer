using System;
using System.Collections.Generic;


[Serializable]
public class GaussianList
{
    public string name;
    public List<GaussianData> GaussianInfo;
}

[System.Serializable]
public class GaussianData
{
    // Gaussian data
    public int FormatVersion;
    public int SplatCount;
    public float FrameTime;
    public string PosFormat;
    public string ScaleFormat;
    public string SHFormat;
    public string ColorFormat;
    public int ColorWidth;
    public int ColorHeight;
    public string PosDataDynamic;
    public string ChunkDataDynamic;
    public string ColorData;
    public string OtherData;
    public string SHData;
    public string ChunkDataStatic;

    // Metadata
    public string name;
    public string author;
    public string thumbnailUrl;
    public string category;
    public string id;

    // Local data
    public string localPath;


}