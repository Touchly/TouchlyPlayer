using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class Flip : MonoBehaviour
{
    public GameObject Screen, MeshDisplay, flatScreen;
    private Vector3 currentScale;

    private bool flipAgain = false;

    public const string Keyword_FlipLeftRight = "FLIPLEFTRIGHT";

    // Start is called before the first frame update

    public void FlipEyeOnly(bool flip)
    {
        if (MeshDisplay)
        {

            if (flip)
            {
                MeshDisplay.GetComponent<Renderer>().material.EnableKeyword(Keyword_FlipLeftRight);
                flipAgain = true;
            }
            else
            {
                MeshDisplay.GetComponent<Renderer>().material.DisableKeyword(Keyword_FlipLeftRight);
                flipAgain = false;
            }
        }
    }

    public void FlipHorizontal(bool flip)
    {
        
        currentScale = Screen.transform.localScale;
        Screen.transform.localScale = new Vector3(flip ? -1:1, currentScale.y, currentScale.z);
        if (flatScreen){
            Vector3 current = flatScreen.transform.localScale;
            float x = Mathf.Abs(flatScreen.transform.localScale.x);
            flatScreen.transform.localScale = new Vector3(flip ? -x:x, (float)current.y, (float)current.z);
        }

        if (flipAgain) { flip = !flip; }

        if (MeshDisplay){

            if (flip){
                MeshDisplay.GetComponent<Renderer>().material.EnableKeyword(Keyword_FlipLeftRight);
            } else {
                MeshDisplay.GetComponent<Renderer>().material.DisableKeyword(Keyword_FlipLeftRight);
            }    
        }

    }

    public void FlipVertical(bool flip)
    {
        currentScale = Screen.transform.localScale;
        Screen.transform.localScale = new Vector3(currentScale.x, flip ? -1:1, currentScale.z);
        
        if (flatScreen){
            Vector3 current = flatScreen.transform.localScale;
            float y = Mathf.Abs(flatScreen.transform.localScale.y);
            flatScreen.transform.localScale = new Vector3((float)current.x, flip ? -y:y, (float)current.z);
        }
    }

    public void ChangeSize(float _size){
        float size = _size/500f;
        if (flatScreen){
            //flatScreen.transform.localScale = new Vector3(size, size, size)
            flatScreen.transform.DOScale(new Vector3(size, size, size), 0.4f);
        }
    }

    public void ChangeDistance(float _distance){
        float distance = _distance/10f;
        if (flatScreen){
            //flatScreen.transform.localScale = new Vector3(size, size, size)
            flatScreen.transform.DOLocalMove(new Vector3(0, 0, distance), 0.4f);
        }
    }
}
