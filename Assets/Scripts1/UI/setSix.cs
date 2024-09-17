using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Michsky.UI.ModernUIPack;

public class setSix : MonoBehaviour
{
    private bool sixdof;
    public SwitchManager switcher;
    public Prefs prefs;

    void OnEnable()
    {
        sixdof = prefs.sixdof;

        if (sixdof)
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
        prefs.sixdof = true;
    }
    public void setOff()
    {
        prefs.sixdof = false;
    }

}
