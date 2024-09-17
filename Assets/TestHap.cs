using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Bhaptics.SDK2;

public class TestHap : MonoBehaviour
{
    private void PlayFeedback(){
            int[] motorvalues = new int[]{0, 100, 100, 0, 0, 0};
            Bhaptics.SDK2.PositionType positionType = Bhaptics.SDK2.PositionType.GloveR;
            
            Bhaptics.SDK2.GlovePlayTime[] playTimes = new Bhaptics.SDK2.GlovePlayTime[6];
            Bhaptics.SDK2.GloveShapeValue[] shapeValues = new Bhaptics.SDK2.GloveShapeValue[6];

            playTimes[1] = Bhaptics.SDK2.GlovePlayTime.ThirtyMS;
            playTimes[2] = Bhaptics.SDK2.GlovePlayTime.ThirtyMS;
            shapeValues[1] = Bhaptics.SDK2.GloveShapeValue.Decreasing;
            shapeValues[2] = Bhaptics.SDK2.GloveShapeValue.Decreasing;
            
            BhapticsLibrary.PlayWaveform(positionType, motorvalues, playTimes, shapeValues);

    }


    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(WaitAndPrint(1.0f));
    }

    IEnumerator WaitAndPrint(float waitTime)
    {
        while (true)
        {
            yield return new WaitForSeconds(waitTime);
            Debug.Log("WaitAndPrint " + Time.time);
            //BhapticsLibrary.Play("ring_right");
            PlayFeedback();
        }
    }
    // Update is called once per frame
    void Update()
    {
        
    }
}
