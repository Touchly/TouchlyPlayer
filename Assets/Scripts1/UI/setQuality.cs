using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Michsky.UI.ModernUIPack;


public class setQuality : MonoBehaviour
{
    private int quality;
    private HorizontalSelector selector;

    // Start is called before the first frame update
    void onEnable()
    {
        selector= gameObject.GetComponent<HorizontalSelector>();
        selector.defaultIndex = PlayerPrefs.GetInt("quality",0); 
    }

    public void SetQuality(int index)
    {
        quality = index;
    }

    void OnDisable()
    {
        PlayerPrefs.SetInt("quality", quality);
    }
}
