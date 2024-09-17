using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class References : MonoBehaviour
{
    List<Transform> sources;
    List<Transform> targets;
    
    void OnEnable(){
        sources = new List<Transform>();
        #if STEAM_VR
        sources.Add(GameObject.Find("Controller (left)").transform);
        sources.Add(GameObject.Find("Controller (right)").transform);
        sources.Add(GameObject.Find("Camera (head)").transform);
        #else
        sources.Add(GameObject.Find("LeftControllerAnchor").transform);
        sources.Add(GameObject.Find("RightControllerAnchor").transform);
        sources.Add(GameObject.Find("CenterEyeAnchor").transform);
        #endif

        targets = new List<Transform>();
        targets.Add(GameObject.Find("Left Hand").transform);
        targets.Add(GameObject.Find("Right Hand").transform);
        targets.Add(GameObject.Find("Head").transform);
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


