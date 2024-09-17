using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ResetOrientationMenu : MonoBehaviour
{
    public OVRInput.RawButton resetButton = OVRInput.RawButton.Y;
    public Transform reference, player;

    void Start()
    {
        Recenter();
    }

    void Update()
    {
        if (OVRInput.GetDown(resetButton))
        {
            Recenter();
        }
    }
    public void Recenter()
    {
        //Inverse rotation
        player.rotation = Quaternion.Inverse(reference.rotation);
    }
}
