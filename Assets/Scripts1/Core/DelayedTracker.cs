using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;


public class DelayedTracker : MonoBehaviour
{
    public GameObject player; // Assign player in inspector
    public float threshold = 0.5f;
    Vector3 previousPos;
    
    //void LateUpdate()
    //{
    //    gameObject.transform.position = player.transform.position;
    //}
    void OnEnable()
    {
        previousPos = player.transform.position;
        StartCoroutine("DelayedUpdate");
    }

    void OnDisable(){
        StopCoroutine("DelayedUpdate");
    }

    IEnumerator DelayedUpdate()
    {
        while (true){
            if (Vector3.Distance(player.transform.position, gameObject.transform.position) > threshold)
            {
                gameObject.transform.DOMove(player.transform.position, 0.5f);
                Debug.Log("Recentered screen");
            }
            yield return new WaitForSeconds(1f);
        }
    }
}
