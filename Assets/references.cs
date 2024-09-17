using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class references : MonoBehaviour
{
    // Start is called before the first frame update
    public void Grab()
    {
        gameObject.GetComponent<Rigidbody>().useGravity = true;
    }
    public void Destroy()
    {
        Destroy(gameObject);
    }
}
