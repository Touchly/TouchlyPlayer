using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;
using AndroidLocalGalleryPlugin;

/// <summary>
/// Runtime permission.
/// </summary>
public class RuntimePermission : MonoBehaviour
{
	
	private readonly string WRITE_EXTERNAL_STORAGE = "android.permission.WRITE_EXTERNAL_STORAGE";
	private bool permissionRequested = false;

	/// <summary>
	/// The GameObject which has error message.
	/// </summary>
	public GameObject permissionRationale, notOnAndroidDevice;

	/// <summary>
	/// The GameObject which is attached controller script.
	/// </summary>
	public GameObject controller;

	void Start()
	{
		try {
		#if UNITY_ANDROID
		    if(RuntimePermissionHelper.HasPermission(WRITE_EXTERNAL_STORAGE)) {
		        controller.SendMessage("searchImageAndVideoFilesMaxCount");
		    }else{
				if (RuntimePermissionHelper.ShouldShowRequestPermissionRationale(WRITE_EXTERNAL_STORAGE))
				{
					// View a text which describes a reason why this app needs the permission
					permissionRationale.SetActive(true);
				}
				else
				{
					// Request the permission.
					RuntimePermissionHelper.RequestPermission(new string[] { WRITE_EXTERNAL_STORAGE });
					permissionRequested = true;
				}
		    }
		#endif
		}catch (Exception ex)
		{
		    notOnAndroidDevice.SetActive(true);
		    Debug.LogException(ex);
		}
	}

	// It's called when the app turn to foreground or background.
	void OnApplicationPause(bool pauseStatus)
	{
		try {
		#if UNITY_ANDROID
		    // pauseStatus=false is called when the app turn to foreground from background.
		    if (!pauseStatus)
		    {
				// Check the app is allowed to use permission.
				if (RuntimePermissionHelper.HasPermission(WRITE_EXTERNAL_STORAGE))
				{
					permissionRationale.SetActive(false);
					if(permissionRequested) {
					    controller.SendMessage("searchImageAndVideoFilesMaxCount");
					    permissionRequested = false;
					}
				}else {
					permissionRationale.SetActive(true);
				}
		    }
		#endif
		}catch (Exception ex)
		{
		    Debug.LogException(ex);
		}
	}

	/// <summary>
	/// Launche app info setting for the users who didn't allow the permission.
	/// </summary>
	public void launchAppInfoSetting() {
		try
		{
		#if UNITY_ANDROID
		    using (var unityClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer"))
		    using (AndroidJavaObject currentActivityObject = unityClass.GetStatic<AndroidJavaObject>("currentActivity"))
		    {
		        string packageName = currentActivityObject.Call<string>("getPackageName");
		        using (var uriClass = new AndroidJavaClass("android.net.Uri"))
		        using (AndroidJavaObject uriObject = uriClass.CallStatic<AndroidJavaObject>("fromParts", "package", packageName, null))
		        using (var intentObject = new AndroidJavaObject("android.content.Intent", "android.settings.APPLICATION_DETAILS_SETTINGS", uriObject))
		        {
		            intentObject.Call<AndroidJavaObject>("addCategory", "android.intent.category.DEFAULT");
		            intentObject.Call<AndroidJavaObject>("setFlags", 0x10000000);
		            currentActivityObject.Call("startActivity", intentObject);
		        }
		    }
		#endif
		}
		catch (Exception ex)
		{
		    Debug.LogException(ex);
		}
	}
}
