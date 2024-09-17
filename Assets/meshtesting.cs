using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Dest.Modeling;

public class meshtesting : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        int widthResolution = 128;
        Debug.Log((int)(1.6f*widthResolution)-1);
        Debug.Log((int)(0.9f*widthResolution)-1);

        Mesh screenMesh = MeshGenerator.CreatePlane(MeshGenerator.Directions.Forward, 1.6f, 0.9f, (int)(1.6f*widthResolution)-1, (int)(0.9f*widthResolution)-1, true, true);
        gameObject.GetComponent<MeshFilter>().sharedMesh = screenMesh;
    }
}
