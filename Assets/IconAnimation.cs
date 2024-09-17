using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class IconAnimation : MonoBehaviour
{
    private RectTransform thumbnailTransform;
    public Vector3 initialScale= new Vector3(1f, 1f, 1f);
    public Vector3 finalScale= new Vector3(1.05f, 1.05f, 1.05f);
    Tweener easeIn, easeOut;

    // Start is called before the first frame update
    void Start()
    {
        thumbnailTransform =  GetComponent<RectTransform>();
    }
    public void EaseIn()
    {
        //Wait for previous tween
        easeOut.Kill();
        easeIn = thumbnailTransform.DOScale(finalScale, 0.2f).SetEase(Ease.InOutQuad);
    }
    public void EaseOut()
    {
        easeIn.Kill();
        easeOut = thumbnailTransform.DOScale(initialScale, 0.1f).SetEase(Ease.InOutQuad);
    }
}
