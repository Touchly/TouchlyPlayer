using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class ColliderRegister : MonoBehaviour
{
    public UnityEvent<string> messageEvent;
    public string messageIn, messageOut;

    void OnTriggerEnter(Collider other)
    {
        Debug.Log("Collision entered");
        messageEvent.Invoke(messageIn);
    }
    void OnTriggerExit(Collider other)
    {
        Debug.Log("Collision exit");
        messageEvent.Invoke(messageOut);
    }
}
