using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class Animations : MonoBehaviour
{
    public Image filesRect, exploreRect, settingsRect;
    Tweener easeIn, easeOut;

    // Start is called before the first frame update
    public void highlightMenu(int selection)
    {
        switch (selection) {
            case 0:
                //Opacity of filesRect
                filesRect.DOFade(1, 1f).SetEase(Ease.InOutQuad);
                exploreRect.DOFade(1, 0.1f).SetEase(Ease.InOutQuad);
                settingsRect.DOFade(1, 0.1f).SetEase(Ease.InOutQuad);
                break;
            case 1:
                //Opacity of exploreRect
                filesRect.DOFade(1, 0.1f).SetEase(Ease.InOutQuad);
                exploreRect.DOFade(1, 1f).SetEase(Ease.InOutQuad);
                settingsRect.DOFade(1, 0.1f).SetEase(Ease.InOutQuad);
                break;
            case 2:
                //Opacity of settingsRect
                filesRect.DOFade(1, 0.5f).SetEase(Ease.InOutQuad);
                exploreRect.DOFade(1, 0.5f).SetEase(Ease.InOutQuad);
                settingsRect.DOFade(1, 1f).SetEase(Ease.InOutQuad);
                break;
        }
    }

    void Start(){
        highlightMenu(0);
    }

}
