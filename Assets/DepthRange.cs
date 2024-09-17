using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Michsky.UI.ModernUIPack;

public class DepthRange : MonoBehaviour
{
    [SerializeField] SliderManager depthSlider;
    public CurrentVideo currentVideo;
    // Start is called before the first frame update
    void Start()
    {
        if (currentVideo.format ==0 || currentVideo.format==2){
            depthSlider.mainSlider.minValue = 0.45f;
            depthSlider.mainSlider.maxValue = 1.05f;
            //depthSlider.mainSlider.value = 0.7498f;
        } else if (currentVideo.format==1){
            depthSlider.mainSlider.minValue = 0.1f;
            depthSlider.mainSlider.maxValue = 1f;
            //depthSlider.mainSlider.value = 0.3f;
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
