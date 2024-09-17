using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class WelcomeMenu : MonoBehaviour
{
    public GameObject WelcomeMenuPanel;
    public CanvasGroup panelGroup, settingsGroup;
    public bool forceOpen=false;
    // Start is called before the first frame update
    void Start()
    {
        //If "IsFirstTime" was not set before, set it to true.
        if ((PlayerPrefs.GetInt("open7", 1) == 1 )|| forceOpen) {
            PlayerPrefs.SetInt("open7", 0);
            panelGroup.alpha=1.0f;
            settingsGroup.alpha=0.1f;
            WelcomeMenuPanel.SetActive(true);
        } else {
            panelGroup.alpha=0f;
            settingsGroup.alpha=1f;
            WelcomeMenuPanel.SetActive(false);
        }
    }

    // Update is called once per frame
    public void FadeOut()
    {
        panelGroup.DOFade(0f, 0.5f).OnComplete(() =>
        {
            WelcomeMenuPanel.SetActive(false);
        });
        settingsGroup.DOFade(1f, 0.5f).OnComplete(() =>
        {
            WelcomeMenuPanel.SetActive(false);
        });
    }

    public void FadeIn()
    {
        WelcomeMenuPanel.SetActive(true);
        panelGroup.DOFade(1f, 0.22f);
        settingsGroup.DOFade(0.1f, 0.5f);
    }
}
