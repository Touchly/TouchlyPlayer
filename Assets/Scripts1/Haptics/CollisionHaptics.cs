using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Bhaptics.SDK2;

public class CollisionHaptics : MonoBehaviour
{
    float multiplier = 0.6f;
    private int lastCallFrame = -1;
    int delayFrames = 1;
    private int method = 1;
    // Look up table, name of finger and its id
    Dictionary<string, int> fingerId = new Dictionary<string, int>(){
        {"thumb", 0},
        {"index", 1},
        {"middle", 2},
        {"ring", 3},
        {"pinky", 4}
    };

    
    private void OnCollisionEnter(Collision collision)
    {
        
        string name = collision.contacts[0].otherCollider.name;
        if (name.Contains("_right") || name.Contains("_left")){
            //Debug.Log(name);
            float velocity = collision.relativeVelocity.magnitude;
            float intensity = Mathf.Clamp(velocity*multiplier, 0f, 1f);

            if (Time.frameCount - lastCallFrame > delayFrames){
                if (method==1){
                    string finger = name.Split('_')[0];
                    int[] motorvalues = new int[]{0, 0, 0, 0, 0, 0};
                    motorvalues[fingerId[finger]] =  (int)(intensity*100);
                    Bhaptics.SDK2.PositionType positionType = name.Contains("_right") ? Bhaptics.SDK2.PositionType.GloveR : Bhaptics.SDK2.PositionType.GloveL;

                    Bhaptics.SDK2.GlovePlayTime[] playTimes = new Bhaptics.SDK2.GlovePlayTime[6];
                    Bhaptics.SDK2.GloveShapeValue[] shapeValues = new Bhaptics.SDK2.GloveShapeValue[6];

                    playTimes[fingerId[finger]] = Bhaptics.SDK2.GlovePlayTime.FortyMS;
                    shapeValues[fingerId[finger]] = Bhaptics.SDK2.GloveShapeValue.Constant;

                    BhapticsLibrary.PlayWaveform(positionType, motorvalues, playTimes, shapeValues);
                }
                else if (method ==2){
                    BhapticsLibrary.PlayParam(name, intensity, 2f, 20f, 0.3f);
                }
                lastCallFrame = Time.frameCount;
                
            }
        }
    }


    // Update is called once per frame
    void Update()
    {
        
    }
}
