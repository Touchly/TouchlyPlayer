using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Michsky.UI.ModernUIPack;

public class setDebugMesh : MonoBehaviour
{
    private int debugMesh;
    public SwitchManager switcher;

    void OnEnable()
    {
        debugMesh = PlayerPrefs.GetInt("debugMesh", 0);
        if (debugMesh == 1)
        {
            switcher.isOn = true;
        } else if (debugMesh==0)
        {
            switcher.isOn = false;
        }
        switcher.UpdateUI();

    }
    public void setOn()
    {
        debugMesh = 1;
    }
    public void setOff()
    {
        debugMesh = 0;
    }
    void OnDisable()
    {
        PlayerPrefs.SetInt("debugMesh", debugMesh);
    }

}