using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;

public class sendSeconds : MonoBehaviour
{
    public GameObject textObject;
    private int value;

    public void sendSeconds_method()
    {
        //For each slider value change. Slider (1-10) times 50 to text and PlayerPref.
        value=(int)gameObject.GetComponent<Slider>().value*50;
        textObject.GetComponent<Text>().text = value.ToString();
    }
    void Start()
    {
        //Default value of slider
        gameObject.GetComponent<Slider>().value = (int)PlayerPrefs.GetInt("refreshPeriod", 1)/50;
        //What is stored in PlayerPref
        value = PlayerPrefs.GetInt("refreshPeriod", 500);
    }
    void OnDisable()
    {
        PlayerPrefs.SetInt("refreshPeriod", value);
    }
}
