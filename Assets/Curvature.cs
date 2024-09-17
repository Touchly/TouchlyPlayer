using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class Curvature : MonoBehaviour
{
    public UnityEvent<int> changeCurvature;

    public void ChangeCurvature(float value){
        changeCurvature.Invoke((int)value);
    }
}
