using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Calibrator : MonoBehaviour
{
    public Transform controller, tracking;
    public GameObject marker;
    private GameObject markerIns;
    // Update is called once per frame
    void Update()
    {
        if (OVRInput.GetUp(OVRInput.RawButton.B)|| OVRInput.GetUp(OVRInput.RawButton.Y))
        {
            markerIns = Instantiate(marker, new Vector3(0, 0, 0), Quaternion.identity);
            markerIns.transform.position = controller.position;

            markerIns.GetComponentInChildren<TextMesh>().text = Vector3.Distance(markerIns.transform.position, tracking.position).ToString("F3");
            Transform textTransform = markerIns.transform.GetChild(0);
            textTransform.LookAt(tracking, Vector3.up);

            markerIns.transform.SetParent(gameObject.transform);
        }

        if (OVRInput.GetUp(OVRInput.RawButton.A) || OVRInput.GetUp(OVRInput.RawButton.X))
        {
            int numChildren = gameObject.transform.childCount;
            Destroy(gameObject.transform.GetChild(numChildren - 1).gameObject);
        }

        //Tracking
        gameObject.transform.position= tracking.position;
    }
}
