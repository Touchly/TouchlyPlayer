using System.Collections;
using System.Collections.Generic;
using UnityEngine.Events;
using UnityEngine;

public class CorrectLayout : MonoBehaviour
{
    public CurrentVideo currentVideo;
    public UnityEvent<Vector2> materialSet;
    // Start is called before the first frame update
    void Start()
    {
        if (currentVideo.preprocessed){
            transform.localRotation = Quaternion.Euler(0, 270, 0);
            materialSet.Invoke(new Vector2(1, 1));
        } else {
            transform.localRotation = Quaternion.Euler(0, 90, 0);
            materialSet.Invoke(new Vector2(2, 1));
        }
    }
}
