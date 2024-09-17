using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ResetOrientation : MonoBehaviour
{
    public OVRInput.RawButton resetButton = OVRInput.RawButton.Y;
    public GameObject sphere, camera;
    public GameObject overlay;
    // Start is called before the first frame update
    void Start()
    {
        overlay=GameObject.Find("MainPlayer");
    }
    // Update is called once per frame
    void Update()
    {
        if (OVRInput.GetDown(resetButton))
        {
            //Reset rotation
            sphere.transform.localRotation = camera.transform.localRotation;
            overlay.transform.localRotation = camera.transform.localRotation;

            sphere.transform.Rotate(0.0f, -180.0f, 0.0f, Space.Self);
        }
    }
}
