using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class sendHapticStrength : MonoBehaviour
{
    // Start is called before the first frame update
    public GameObject hapticObject;
    private int value;
    // Start is called before the first frame update
    public void sendHapticStrength_method()
    {
        value = (int)gameObject.GetComponent<Slider>().value;
        hapticObject.GetComponent<Text>().text = value.ToString();
    }
    void OnDisable()
    {
        PlayerPrefs.SetInt("hapticAmp", value);
    }
    void Start()
    {
        value = 5;
    }
}
