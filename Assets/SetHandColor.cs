using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class SetHandColor : MonoBehaviour
{
    [SerializeField] Material handMaterial, robotMaterial;
    [SerializeField] UnityEvent<Color> setColorEvent;
    Color colorSet;
    // Start is called before the first frame update
    void OnEnable()
    {
        string colorString = PlayerPrefs.GetString("hand_color", "CFCECCFF");
        Debug.Log(colorString);
        Color color = Color.white;
        Debug.Log(color);
        ColorUtility.TryParseHtmlString("#" + colorString , out color);
        Debug.Log(color);
        SetHandColorFunc(color);
        setColorEvent.Invoke(color);
    }

    public void SetHandColorFunc(Color colorIn)
    {
        handMaterial.color = colorIn;
        robotMaterial.color = colorIn;
        colorSet = colorIn;
    }

    void OnDisable() {
        Debug.Log("Saving color: " + ColorUtility.ToHtmlStringRGBA(colorSet));
        PlayerPrefs.SetString("hand_color", ColorUtility.ToHtmlStringRGBA(colorSet));
        PlayerPrefs.Save();
    }

}
