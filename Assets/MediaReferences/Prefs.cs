using UnityEngine;
using System.Collections;
using System.Collections.Generic;

[CreateAssetMenu(fileName = "Data", menuName = "ScriptableObjects/Prefs", order = 1)]

public class Prefs : ScriptableObject
{
    //2
    public bool preprocessed, sixdof;
}