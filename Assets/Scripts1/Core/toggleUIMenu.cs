using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class toggleUIMenu : MonoBehaviour
{
    // Start is called before the first frame update
    public bool StartActive;
    public GameObject menuObject;
    public CanvasGroup menuGroup;
    void Start()
    {
        menuObject.SetActive(StartActive);
    }
    public void toggleMenu()
    {
        if (menuObject.activeSelf)
        {
            menuGroup.DOFade(0f, 0.22f).OnComplete(() =>
            {
                menuObject.SetActive(false);
            });
        } else
        {
            menuObject.SetActive(true);
            menuGroup.DOFade(1f, 0.22f);
        }
    }
}
