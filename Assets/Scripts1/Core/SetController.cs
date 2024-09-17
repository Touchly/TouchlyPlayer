using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

//Manages and "distributes" all settings.
public class SetController : MonoBehaviour
{
    [SerializeField] List<GameObject> HandRobot;
    [SerializeField] List<GameObject> HandHuman;
    [SerializeField] List<GameObject> Controller;
    [SerializeField] List<GameObject> UIPointers;
    
    [SerializeField] int defaultHandModel;

    void Start() {
        int handModel = PlayerPrefs.GetInt("HandType", defaultHandModel);
        SetHandModel(handModel);
    }

    public void SetHandModel(int handModel)
    {
        //Set to robot hand
        if (handModel==0){
            HandRobot[0].SetActive(true);
            HandRobot[1].SetActive(true);
            HandHuman[0].SetActive(false);
            HandHuman[1].SetActive(false);
            Controller[0].SetActive(false);
            Controller[1].SetActive(false);

           // UIPointers[0].transform.SetParent(HandRobot[0].transform);
           // UIPointers[1].transform.SetParent(HandRobot[1].transform);

        //Set to real hand
        } else if (handModel==1) {
            HandRobot[0].SetActive(false);
            HandRobot[1].SetActive(false);
            HandHuman[0].SetActive(true);
            HandHuman[1].SetActive(true);
            Controller[0].SetActive(false);
            Controller[1].SetActive(false);

            //UIPointers[0].transform.SetParent(HandHuman[0].transform);
           // UIPointers[1].transform.SetParent(HandHuman[1].transform);

        //Set to controller
        } else {
            HandRobot[0].SetActive(false);
            HandRobot[1].SetActive(false);
            HandHuman[0].SetActive(false);
            HandHuman[1].SetActive(false);
            Controller[0].SetActive(true);
            Controller[1].SetActive(true);

          //  UIPointers[0].transform.SetParent(Controller[0].transform);
           // UIPointers[1].transform.SetParent(Controller[1].transform);
        }
    }
} 