using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UISwitch : MonoBehaviour
{
    public GameObject PlayerUI, handL, handR; //pointer;
    private bool menuOpen;
    // Start is called before the first frame update
    void Start()
    {
        menuOpen = false;
    }

    // Update is called once per frame
    void Update()
    {
        if (OVRInput.GetUp(OVRInput.Button.Start))
        {
            menuOpen = !menuOpen;
        }

        if (menuOpen)
        {
            PlayerUI.SetActive(true);
            //pointer.SetActive(true);
            
        }
        else
        {
            PlayerUI.SetActive(false);
            //pointer.SetActive(false);
        }
        //test
    }
}
