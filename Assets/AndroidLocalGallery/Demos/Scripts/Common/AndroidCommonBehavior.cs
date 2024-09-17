using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// AndroidCommonBehavior can support the common feature of android.
/// </summary>
public class AndroidCommonBehavior : MonoBehaviour {

    public bool ExitAppWhenPressBackKey = false; 

	// Update is called once per frame
	void Update () {
		if(ExitAppWhenPressBackKey) {
            #if UNITY_ANDROID
                if (Input.GetKeyDown(KeyCode.Escape))
                {
                    // Quit the applicaiton when user tap phone's back key.
                    Application.Quit();
                    return;
                }
            #endif
        }
	  
	}
}
