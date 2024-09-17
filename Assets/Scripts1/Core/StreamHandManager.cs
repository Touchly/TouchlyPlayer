using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Autohand.Demo;

namespace Autohand {
    [DefaultExecutionOrder(10000)]
    public class StreamHandManager : MonoBehaviour
    {
        [Header("Hands")]
        public Hand[] leftHands;
        public Hand[] rightHands;

        [Header("Controller Tracking Follows")]
        public Transform[] rightControllerTrackingFollows;
        public Transform[] leftControllerTrackingFollows;

        [Header("Controller Tracking Enable")]
        public MonoBehaviour[] enableScriptControllerTracking;
        public GameObject[] enableObjectControllerTracking;

        public GameObject leftUIPointer, rightUIPointer;
        public MonoBehaviour hapticGloves;
        bool useHapticGloves = false;

        // Start is called before the first frame update
        void OnEnable()
        {
            useHapticGloves = PlayerPrefs.GetInt("use_bhaptics", 0) == 1;

            leftUIPointer.transform.parent.localPosition = new Vector3(leftControllerTrackingFollows[0].localPosition.x, leftControllerTrackingFollows[0].localPosition.y-0.1f, leftControllerTrackingFollows[0].localPosition.z);
            rightUIPointer.transform.parent.localPosition =  new Vector3(rightControllerTrackingFollows[0].localPosition.x, rightControllerTrackingFollows[0].localPosition.y-0.1f, rightControllerTrackingFollows[0].localPosition.z);
            rightUIPointer.transform.parent.localRotation = leftControllerTrackingFollows[0].localRotation;
            leftUIPointer.transform.parent.localRotation = rightControllerTrackingFollows[0].localRotation;

            rightUIPointer.GetComponent<LineRenderer>().enabled = true;

            if (hapticGloves){
                hapticGloves.enabled = false;
            }

            leftUIPointer.SetActive(true);
            rightUIPointer.SetActive(true);

            for(int i = 0; i < enableScriptControllerTracking.Length; i++)
                enableScriptControllerTracking[i].enabled = true;
            for(int i = 0; i < enableObjectControllerTracking.Length; i++)
                enableObjectControllerTracking[i].SetActive(true);

            for(var i = 0; i < leftControllerTrackingFollows.Length; i++){
                leftHands[i].follow = leftControllerTrackingFollows[i];
                rightHands[i].follow = rightControllerTrackingFollows[i];
            }
        }
    }
}
