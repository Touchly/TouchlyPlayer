using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerMenu : MonoBehaviour
{
    public GameObject PlayerUI, handL, handR, controllerL, controllerR; //pointer;
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
            handL.SetActive(false);
            handR.SetActive(false);

            controllerL.SetActive(true);
            controllerR.SetActive(true);
        }
        else
        {
            PlayerUI.SetActive(false);
           //pointer.SetActive(false);

            handL.SetActive(true);
            handR.SetActive(true);
            
            controllerL.SetActive(false);
            controllerR.SetActive(false);
        }
        //test
    }
}
