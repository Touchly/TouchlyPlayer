using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using System.Linq;
using static CurrentVideo;
using TMPro;


public class Layoutbutton2 : MonoBehaviour
{
    public GameObject layout;
    public CanvasGroup layoutGroup;
    public CurrentVideo currentVideo;
    public List<Button> layoutButtons;
    public GameObject disclaimer;
    public GeneralSettings settings;
    int[] available;
    public enum scene
    {
        Classic,
        Static,
        Dynamic
    }

    public scene Scene;

    void OnEnable() {
        UpdateAvailable();
    }

    public void UpdateAvailable(){
        if (currentVideo.preprocessed)
        {
            if (currentVideo.format == 0 ){
                available = new int[] { 2, 5, 6, 7 };
            } else if (currentVideo.format == 1){
                available = new int[] { 1, 6, 7 };
            } else if (currentVideo.format ==2){
                available = new int[] {  6, 7 };
            } else if (currentVideo.format==3){
                available = new int[] { 5, 6, 7 };
            }
            disclaimer.SetActive(false);
            
        } else
        {
            #if UNITY_EDITOR || UNITY_STANDALONE 
            disclaimer.SetActive(true);
            if ((currentVideo.packing == packingStereo.LeftRight) && (currentVideo.mapping == videoMapping.HalfSphere))
            {
                available = new int[] { 8, 0, 1, 2, 3, 4 , 5, 6 , 7};
                currentVideo.format = 2;
                disclaimer.GetComponent<TextMeshProUGUI>().text = "Video is not in the Touchly format.\nDepth will be calculated in Real-time (experimental, results vary)";
            } else if ((currentVideo.packing == packingStereo.None || currentVideo.packing== packingStereo.LeftRight) && (currentVideo.mapping == videoMapping.Flat)){
                available = new int[] {8, 0, 1, 2, 3, 4 , 6, 7};
                currentVideo.format = 1;
            }
            else
            {
                available = new int[] { 8, 0, 1, 2, 3, 4 };
                disclaimer.GetComponent<TextMeshProUGUI>().text = "Current layout/mapping combination is not supported for real-time processing. \n";
            }
            #else
            disclaimer.SetActive(false);
            available = new int[] { 0, 1, 2, 3, 4, 8};
            
            #endif
        }
    
        //Turn on available buttons only
        var i = 0;
        while (i < 9)
        {
            if (available.Contains(i))
            {
                layoutButtons[i].interactable = true;
            }
            else
            {
                layoutButtons[i].interactable = false;
            }
            i++;
        }
    }

    public void ToggleOpen()
    {
        UpdateAvailable();
        if (layout.activeSelf)
        {
            layoutGroup.DOFade(0f, 0.22f).OnComplete(() =>
            {
                layout.SetActive(false);
            });
        } else
        {
            layout.SetActive(true);
            layoutGroup.DOFade(1f, 0.22f);
        }
    }
}