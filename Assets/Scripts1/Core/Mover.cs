using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;
using static CurrentVideo;
public class Mover : MonoBehaviour
{
    public float multiplier;
    public CurrentVideo currentVideo;

    // Start is called before the first frame update
    void Start(){
        MoveX(currentVideo.offsetHorizontal);
        MoveY(currentVideo.offsetVertical);
    }
    public void MoveX(float distance)
    {
        float x = distance * multiplier;
        transform.DOLocalMoveX(x, 0.4f);
    }

    public void MoveY(float distance)
    {
        float y = distance * multiplier;
        transform.DOLocalMoveY(y, 0.4f);
    }

    public void MoveZ(float distance)
    {
        float z = distance * multiplier;
        transform.DOLocalMoveZ(z, 0.4f);
    }
}
