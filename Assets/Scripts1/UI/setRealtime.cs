using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Michsky.UI.ModernUIPack;

public class setRealtime : MonoBehaviour
{
    private int realTime;
    public SwitchManager switcher;

    void OnEnable()
    {
        realTime = PlayerPrefs.GetInt("realTime", 0);
        if (realTime == 1)
        {
            switcher.isOn = true;
        }
        else
        {
            switcher.isOn = false;
        }
        switcher.UpdateUI();
    }
    public void setOn()
    {
        realTime = 1;
    }
    public void setOff()
    {
        realTime = 0;
    }
    void OnDisable()
    {
        PlayerPrefs.SetInt("realTime", realTime);
    }

}
