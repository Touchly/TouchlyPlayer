using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class Indicator : MonoBehaviour
{
    public Sprite[] indicatorSprites;
    private Image icon;
    // Start is called before the first frame update
    void Start()
    {
        icon = GetComponent<Image>();
        icon.sprite = indicatorSprites[0];
    }

    public void SetIndicator(int index)
    {
        icon.sprite = indicatorSprites[index];
        Sequence showIcon = DOTween.Sequence();
        showIcon.Append(icon.DOFade(1, 0.1f));
        showIcon.AppendInterval(0.4f);
        showIcon.Append(icon.DOFade(0, 0.1f));
    }
}
