using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "Data", menuName = "ScriptableObjects/ControlLayout", order = 1)]

public class ControlLayout : ScriptableObject
{
    public List<OVRInput.RawButton> inputMap;

    public void SaveList(){
        ES3.Save("inputMap", inputMap);
    }
    //

    public void LoadList(){
        inputMap = ES3.Load("inputMap", new List<OVRInput.RawButton>());
    }
}
