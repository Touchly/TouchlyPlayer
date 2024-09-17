using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "Data", menuName = "ScriptableObjects/GeneralSettings", order = 2)]

public class GeneralSettings : ScriptableObject
{
    public bool premium;
    public int handModel;
}
