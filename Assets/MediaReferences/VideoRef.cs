using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace touchly
{
    public class VideoReference
    {
        public enum stereoPacking
        {
            TopBottom,
            LeftRight,
            CustomUV
        }
        public stereoPacking packing;
        public bool preprocessed;
        public float lastTime;
        public string path;
    }
}
