using UnityEngine;
using System.Collections.Generic;
using System.Collections;
using touchly;

[CreateAssetMenu(fileName = "Data", menuName = "ScriptableObjects/MediaList", order = 1)]

public class MediaList : ScriptableObject
{
    public List<VideoReference> VideoList;
    public VideoReference CurrentVideo;
}