using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ReferenceSetter : MonoBehaviour
{
    public List<Transform> sources;
    public List<Transform> targets;

    void OnEnable(){
        sources = new List<Transform>();
        targets = new List<Transform>();

        foreach (Transform child in transform)
        {
            sources.Add(child);
        }

        # if STEAM_VR
        Transform leftHand = GameObject.Find("SteamVR Player Container").transform.Find("Tracked Objects").Find("Controller (left)");
        Transform rightHand = GameObject.Find("SteamVR Player Container").transform.Find("Tracked Objects").Find("Controller (right)");
        Transform head = GameObject.Find("SteamVR Player Container").transform.Find("Tracked Objects").Find("Camera (head)");
        # else
        Transform leftHand = GameObject.Find("OculusHandTrackingPlayer").transform.Find("TrackerOffsets").Find("OVRCameraRig").Find("TrackingSpace").Find("LeftHandAnchor").Find("LeftControllerAnchor");
        Transform rightHand = GameObject.Find("OculusHandTrackingPlayer").transform.Find("TrackerOffsets").Find("OVRCameraRig").Find("TrackingSpace").Find("RightHandAnchor").Find("RightControllerAnchor");
        Transform head = GameObject.Find("OculusHandTrackingPlayer").transform.Find("TrackerOffsets").Find("OVRCameraRig").Find("TrackingSpace").Find("CenterEyeAnchor");
        #endif

        targets.Add(leftHand);
        targets.Add(rightHand);
        targets.Add(head);
    }

    void Update()
    {
        for (int i = 0; i < sources.Count; i++)
        {
            targets[i].position = sources[i].position;
            targets[i].rotation = sources[i].rotation;
        }
    }
}


