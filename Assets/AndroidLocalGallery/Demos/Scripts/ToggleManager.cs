using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ToggleManager : MonoBehaviour {

    public GameObject controller;
    public string callMethodName = "searchImageAndVideoFilesMaxCount";
    public Color normalTextColor = Color.black;
    public Color selectedTextColor = Color.blue;

    private Toggle toggle;
    private Text text;
	// Use this for initialization
	void Start () {
        toggle = gameObject.GetComponent<Toggle>();
		text = gameObject.GetComponentInChildren<Text>();
        text.color = toggle.isOn ? selectedTextColor : normalTextColor;
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    public void OnValueChange(bool enable) {
        text.color = enable ? selectedTextColor : normalTextColor;
		if(enable && !string.IsNullOrEmpty(callMethodName)) {
            controller.SendMessage(callMethodName);
        }
    }
}
