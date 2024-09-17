using System.Collections;
using System.Collections.Generic;
using UnityEngine;

#if STEAM_VR
using Valve.VR;
#endif

public class ResetOrientationCamera : MonoBehaviour
{
    public OVRInput.RawButton resetButton = OVRInput.RawButton.Y;
    public Transform screen, reference, UI;

    void Start()
    {
        Recenter();
    }

    void Update()
    {
        #if !STEAM_VR
        if (OVRInput.GetDown(resetButton))
        #else
        if (SteamVR_Input.GetBooleanAction("Recenter").GetStateDown(SteamVR_Input_Sources.Any))
        #endif
        {
            Recenter();
        }
    }
    public void Recenter()
    {
        //Center the image on current view. Do inverse rotation on parent of current view.
        screen.localRotation = reference.localRotation;
        if (UI)
        {
            UI.rotation = reference.rotation;
        }
        
    }
}
