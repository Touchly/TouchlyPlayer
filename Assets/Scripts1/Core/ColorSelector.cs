using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class ColorSelector : MonoBehaviour
{
    [SerializeField] UnityEvent<Color> setColorEvent;
    Color[] colorList;
    // Start is called before the first frame update
    void Start()
    {
        colorList = new Color[6];
        colorList[0] = new Color(0.73f, 0.73f, 0.73f, 1f);
        colorList[1] = new Color(0.98f, 0.87f, 0.76f, 1f);
        colorList[2] = new Color(0.89f, 0.76f, 0.62f, 1f);
        colorList[3] = new Color(0.77f, 0.58f, 0.42f, 1f);
        colorList[4] = new Color(0.63f, 0.40f, 0.24f, 1f);
        colorList[5] = new Color(0.35f, 0.27f, 0.24f, 1f);
    }

    public void SetColor(int index){
        setColorEvent.Invoke(colorList[index]);
    }
}
