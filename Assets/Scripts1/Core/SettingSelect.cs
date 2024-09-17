using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;


public class SettingSelect : MonoBehaviour
{
    public int SlideOffset = 800;
    public RectTransform thumbnailTransform;
    private Tweener move;

    // Start is called before the first frame update
    public void Slide(int pos)
    {
        move = thumbnailTransform.DOAnchorPosX(pos, 0.4f).SetEase(Ease.InOutQuad);    
    }
}
