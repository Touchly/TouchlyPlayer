using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using RenderHeads.Media.AVProVideo;

public class ColorPicker : MonoBehaviour
{
    public RenderTexture rt;
    public Transform reference, pointer;
    Texture2D tex;
    [SerializeField] GameObject colorPointer, screen;
    [SerializeField] SpriteRenderer pointerColor;
    [SerializeField] UnityEvent<Color> changeColor;
    [SerializeField] OVRInput.RawButton selectColorButton;
    Color c;

    public bool enable { get; set; }


    public void setPick(bool pick)
    {
        if (enable)
        {
            if (pick)
            {
                colorPointer.SetActive(true);
                StartCoroutine("updatePointer");
            }
            else
            {
                colorPointer.SetActive(false);
                StopCoroutine("updatePointer");
            }
        }
        
    }
    
    IEnumerator updatePointer()
    {
        while (true)
        {
            yield return new WaitForSeconds(0.1f);
            PickColor();
        }
    }

    public static Vector3 getRelativePosition(Transform origin, Vector3 position)
    {
        Vector3 distance = position - origin.position;
        Vector3 relativePosition = Vector3.zero;
        relativePosition.x = Vector3.Dot(distance, origin.right.normalized);
        relativePosition.y = Vector3.Dot(distance, origin.up.normalized);
        relativePosition.z = Vector3.Dot(distance, origin.forward.normalized);

        return relativePosition;
    }

    public void PickColor(){
        Vector3 relativePosition = getRelativePosition(reference, pointer.position)/1.1f;
        
        //Adjust to aspect ratio
        relativePosition.y *= -screen.transform.localScale.x / screen.transform.localScale.z;

        //Debug.Log(relativePosition);

        if (!tex || tex.width != rt.width || tex.height != rt.height){
            tex = new Texture2D(rt.width, rt.height, TextureFormat.RGBA32, false);
        }
        
        RenderTexture.active = rt;

        tex.ReadPixels(new Rect(0, 0, rt.width, rt.height), 0, 0);
        tex.Apply();

        c = tex.GetPixel((int)(relativePosition.x*tex.width), (int)(tex.height-relativePosition.y*tex.height));
        pointerColor.color = c;
        
    }

    // Update is called once per frame
    void Update()
    {
        if (OVRInput.GetDown(selectColorButton) && enable && colorPointer.activeSelf)
        {
            changeColor.Invoke(c);
            setPick(false);
            enable = false;
        }
    }
}
