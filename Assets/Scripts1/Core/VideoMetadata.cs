using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using System.Diagnostics;

//using Newtonsoft.Json.Linq;

public class VideoMetadata : MonoBehaviour
{
    public string videoFilePath;
    //public Matrix4x4 intrMat;

    [System.Serializable]
    public class VideoMetadataJson
    {
        public float[] intrinsicMatrix;
        public float[] rangeOfEncodedDepth;
    }

    void Start()
    {
        byte[] fileContents = File.ReadAllBytes(videoFilePath);
        
        // Convert byte array to string to find metadata (adjust this part as needed)
        string fileContentsStr = System.Text.Encoding.Default.GetString(fileContents);
        string metaStr = fileContentsStr.Substring(fileContentsStr.LastIndexOf("{\"intrinsic"));
        
        // Assuming your meta information ends with "}"
        int endIndex = metaStr.IndexOf("}") + 1;
        metaStr = metaStr.Substring(0, endIndex);

        VideoMetadataJson metadata = JsonUtility.FromJson<VideoMetadataJson>(metaStr);
        
        UnityEngine.Debug.Log("pene");

        // Parse metadata JSON
        /*
        JObject metadata = JObject.Parse(metaStr);
        
        // Populate intrMat from metadata
        float[] intrinsicMatrix = metadata["intrinsicMatrix"].ToObject<float[]>();
        intrMat.SetRow(0, new Vector4(intrinsicMatrix[0], intrinsicMatrix[1], intrinsicMatrix[2], intrinsicMatrix[3]));
        intrMat.SetRow(1, new Vector4(intrinsicMatrix[4], intrinsicMatrix[5], intrinsicMatrix[6], intrinsicMatrix[7]));
        intrMat.SetRow(2, new Vector4(intrinsicMatrix[8], intrinsicMatrix[9], intrinsicMatrix[10], intrinsicMatrix[11]));
        intrMat.SetRow(3, new Vector4(intrinsicMatrix[12], intrinsicMatrix[13], intrinsicMatrix[14], intrinsicMatrix[15]));
        
        // Transpose the matrix if needed
        intrMat = intrMat.transpose;
        */
    }

}
