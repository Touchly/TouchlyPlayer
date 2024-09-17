using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// <para>LogManager checks isDebubBuild to switch the visibility of Debug Log.</para>
/// <para>Debug Log only used if debug build is true.</para>
/// <para>Android Gallery Manager put debug log if Debug.unityLogger.logEnabled is true.</para>
/// </summary>
public class LogManager : MonoBehaviour {

	// Use this for initialization
	void Start () {
        // Debug Log only used if debug build is true.
		Debug.unityLogger.logEnabled = IsEnable();
	}
	
    static bool IsEnable()
	{
		return UnityEngine.Debug.isDebugBuild;
	}

	// Update is called once per frame
	void Update () {
		
	}
}
