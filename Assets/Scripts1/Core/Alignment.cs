using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Alignment : MonoBehaviour
{
    public Transform alignment, UI;

    // Start is called before the first frame update

    public void updateYaw(float value)
    {
        //Update y component of rotation
        Vector3 currentRotation = alignment.rotation.eulerAngles;

        alignment.rotation = Quaternion.Euler(-currentRotation[0],value*6f, currentRotation[2]);
        UI.rotation = alignment.rotation;
    }

    public void updatePitch(float value)
    {
        //Update x component of rotation
        Vector3 currentRotation = alignment.rotation.eulerAngles;
        
        alignment.rotation = Quaternion.Euler(value * 6f, currentRotation[1], currentRotation[2]);
        UI.rotation = alignment.rotation; 
    }

    public void updateRoll(float value)
    {
        //Update z component of rotation
        Vector3 currentRotation = alignment.rotation.eulerAngles;

        alignment.rotation = Quaternion.Euler(currentRotation[0], currentRotation[1], value * 6f);
        UI.rotation = alignment.rotation;
    }
}
