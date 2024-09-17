using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SmoothFollower : MonoBehaviour
{
    public Transform target;
    public float smoothSpeed = 0.125f;
    // Start is called before the first frame update
    void LateUpdate()
    {
        if (target != null)
        {
            transform.position = Vector3.Lerp(transform.position, target.position, smoothSpeed);
            transform.rotation = Quaternion.Lerp(transform.rotation, target.rotation, smoothSpeed);
        }
    }

}
