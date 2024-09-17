using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Follower : MonoBehaviour
{
    public Transform target;
    // Start is called before the first frame update
    void LateUpdate()
    {
        if (target != null)
        {
            transform.position = target.position ;
            transform.rotation = target.rotation ;
        }
    }

}
