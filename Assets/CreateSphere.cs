using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Dest.Modeling;

public class CreateSphere : MonoBehaviour
{
    int widthResolution;
    public CurrentVideo currentVideo;
    public Material standard, record3d;

    Mesh screenMesh;
    [SerializeField] bool createAtStart = false;

    void Start()
    {   
        standard = standard ?? Resources.Load("DEPTH_COLOR", typeof(Material)) as Material;
        record3d = record3d ?? Resources.Load("Record3D 1", typeof(Material)) as Material;
        
        #if UNITY_STANDALONE
            widthResolution = 768;
        #elif UNITY_ANDROID
            widthResolution = 512;
        #endif

        if (createAtStart)
        {
            Create(1f);
        }
    }
    // Start is called before the first frame update
    public void Create(float aspectRatio)
    {
        gameObject.GetComponent<MeshRenderer>().material = standard;
        
        if (currentVideo.format ==0 || currentVideo.format == 2){
            screenMesh = MeshGenerator.CreateSphere(1f, widthResolution - 1, widthResolution - 1, 180f, 180f, true, true, true);
        } else if (currentVideo.format == 1 || currentVideo.format==4){
            screenMesh = MeshGenerator.CreatePlane(MeshGenerator.Directions.Forward, aspectRatio, 1f, (int)(widthResolution)-1, (int)(widthResolution/aspectRatio)-1, true, true);
        } else if (currentVideo.format==3){
            screenMesh = MeshGenerator.CreateSphere(1f, widthResolution/2 - 1, widthResolution - 1, 360f, 180f, true, true, true);
        }

        if (currentVideo.format==4) {
            gameObject.GetComponent<MeshRenderer>().material = record3d;
        }

        gameObject.GetComponent<MeshFilter>().sharedMesh = screenMesh;
    }
}
