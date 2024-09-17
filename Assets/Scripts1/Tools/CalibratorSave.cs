using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CalibratorSave : MonoBehaviour
{
    public Transform controller, tracking;
    public GameObject marker;
    private GameObject markerIns;
    public string path;
    private Vector2 angles, polar;
    private ES3Spreadsheet sheet;
    private int i;
    public int mode = 0;

    //public Dictionary<Vector2, float> points;
    void Start()
    {
        sheet = new ES3Spreadsheet();
        i = 1;
    }
    // Update is called once per frame
    void Update()
    {
        if (OVRInput.GetUp(OVRInput.RawButton.B) || OVRInput.GetUp(OVRInput.RawButton.Y))
        {
            markerIns = Instantiate(marker, new Vector3(0, 0, 0), Quaternion.identity);
            markerIns.transform.position = controller.position;

            float distance = Vector3.Distance(markerIns.transform.position, tracking.position);
            markerIns.GetComponentInChildren<TextMesh>().text = distance.ToString("F3");
            Transform textTransform = markerIns.transform.GetChild(0);
            textTransform.LookAt(tracking, Vector3.up);

            markerIns.transform.SetParent(gameObject.transform);

            //CartesianToSpherical(markerIns.transform.position);

            //points.Add(angles, distance);
            if (mode == 0)
            {
                //Title
                sheet.SetCell(0, 0, "Long");
                sheet.SetCell(1, 0, "Lat");
                sheet.SetCell(2, 0, "Distance");

                //Values
                angles = polar;
                CartesianToPolar(markerIns.transform.position);
                sheet.SetCell(0, i, angles.x);
                sheet.SetCell(1, i, angles.y);
                sheet.SetCell(2, i, distance.ToString("F3"));
            }
            else if (mode==1)
            {
                //Title
                sheet.SetCell(0, 0, "X");
                sheet.SetCell(1, 0, "Y");
                sheet.SetCell(2, 0, "Distance");

                //Values
                Vector3 normalizedVec = markerIns.transform.position.normalized;
                sheet.SetCell(0, i, normalizedVec.x);
                sheet.SetCell(1, i, normalizedVec.y);
                sheet.SetCell(2, i, distance.ToString("F3"));
            }
            

            i += 1;
        }

        if (OVRInput.GetUp(OVRInput.RawButton.A) || OVRInput.GetUp(OVRInput.RawButton.X))
        {
            int numChildren = gameObject.transform.childCount;
            Destroy(gameObject.transform.GetChild(numChildren - 1).gameObject);
        }

        //Tracking
        gameObject.transform.position = tracking.position;
    }

     private void CartesianToPolar(Vector3 point)
     {
        //calc longitude
        polar.y = Mathf.Atan2(point.x, point.z);

        //this is easier to write and read than sqrt(pow(x,2), pow(y,2))!
        var aux = new Vector2(point.x, point.z);
        var xzLen = aux.magnitude;
        //atan2 does the magic
        polar.x = Mathf.Atan2(-point.y,xzLen);
 
        //convert to deg
        polar *= Mathf.Rad2Deg;
     }

    void OnDisable()
    {
        //ES3.Save("points", points, path);
        string filepath = path + "\\points.csv";

        sheet.Save(filepath);
    }
}
