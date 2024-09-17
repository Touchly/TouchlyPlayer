using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class LayoutButton : MonoBehaviour
{
    public GameObject layout;
    public CanvasGroup layoutGroup;

    void Start() {
        layoutGroup.alpha=0f;
    }
    public void ToggleOpen()
    {
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
