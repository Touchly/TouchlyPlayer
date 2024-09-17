using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;
using TMPro;

public class PlatformOptions : MonoBehaviour
{
    public GameObject pathButton, battery, PhysicsOptionsAndroid, PhysicsOptionsPC;
    public TMP_Text time;
    // Start is called before the first frame update
    void OnEnable()
    {
        #if UNITY_ANDROID && !UNITY_EDITOR
            pathButton.SetActive(false);
            PhysicsOptionsAndroid.SetActive(true);
            PhysicsOptionsPC.SetActive(false);
            battery.SetActive(true);
            battery.GetComponent<Image>().fillAmount = SystemInfo.batteryLevel;
        #else
            pathButton.SetActive(true);
            PhysicsOptionsAndroid.SetActive(false);
            PhysicsOptionsPC.SetActive(true);
            battery.SetActive(false);
        #endif

        time.text = DateTime.Now.ToString("HH:mm");
    }
}
