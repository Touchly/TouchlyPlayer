using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Dest.Modeling;

public class SkyboxCreator : MonoBehaviour
{
    Mesh screenMesh;
    int widthResolution=256;
    
    // Start is called before the first frame update
    void Start()
    {
        screenMesh = MeshGenerator.CreateSphere(1f, widthResolution/2 - 1, widthResolution - 1, 180f, 360f, false, true, false);
        gameObject.GetComponent<MeshFilter>().sharedMesh = screenMesh;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
