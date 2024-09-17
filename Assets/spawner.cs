using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class spawner : MonoBehaviour
{
    public GameObject tomato;
    private GameObject newTomato;
    public Transform handPos;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (OVRInput.GetDown(OVRInput.RawButton.B))
        {
            newTomato = Instantiate(tomato, handPos.position, tomato.transform.rotation);
            newTomato.transform.position += new Vector3(0, 0.07f, 0.07f);
            newTomato.transform.SetParent(gameObject.transform);
        }
    }
}
