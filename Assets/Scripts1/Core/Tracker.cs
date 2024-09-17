using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tracker : MonoBehaviour
{
    public GameObject player; // Assign player in inspector
    public Vector3 posOffset; // Offset the canvas in relation of player.

    void LateUpdate()
    {
        gameObject.transform.position = player.transform.position + posOffset;
    }
}
