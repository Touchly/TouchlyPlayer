using System.Collections;
using System.Collections.Generic;
using UnityEngine;

#if STEAM_VR
using Valve.VR;
#endif

public class ResetOrientationCamera6dof : MonoBehaviour
{
    #if !STEAM_VR
    OVRInput.RawButton resetButton = OVRInput.RawButton.LThumbstick | OVRInput.RawButton.RThumbstick;
    #endif
    public Transform reference , UI, screen;
    private int max = 4;
    private int centers=0;

    
    void Update()
    {
        // Temporary solution. CenterEyeAnchor position is accurate after 4 frames.
        if (centers<max)
        {
            Recenter();
            centers += 1;
        }

        #if !STEAM_VR
        if (OVRInput.GetDown(resetButton))
        #else
        if (SteamVR_Input.GetBooleanAction("Recenter").GetStateDown(SteamVR_Input_Sources.Any))
        #endif
        {
            Debug.Log("Recenter");
            Recenter();
        }
    }
    public void Recenter()
    {
        //Center the image on current view. Do inverse rotation on parent of current view.
        screen.localRotation = reference.localRotation;
        screen.position = reference.position;
        UI.rotation = reference.localRotation;
    }
}
