using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace AndroidLocalGalleryPlugin {
	
	/// <summary>
	/// Runtime permission helper.
	/// </summary>
	public class RuntimePermissionHelper
	{
		/// <summary>
		/// Initializes a new instance of the <see cref="RuntimePermissionHelper"/> class.
		/// </summary>
		private RuntimePermissionHelper() { }

		// Get currentActivity
		/// <summary>
		/// Get currentActivity
		/// </summary>
		/// <returns>currentActivity</returns>
		private static AndroidJavaObject GetActivity()
		{
			using (var UnityPlayer = new AndroidJavaClass("com.unity3d.player.UnityPlayer"))
			{
				return UnityPlayer.GetStatic<AndroidJavaObject>("currentActivity");
			}
		}

		/// <summary>
		/// Check the version whether os version is 6.0 or more. 
		/// </summary>
		/// <returns><c>true</c> if is android M or greater; otherwise, <c>false</c>.</returns>
		private static bool IsAndroidMOrGreater()
		{
			using (var VERSION = new AndroidJavaClass("android.os.Build$VERSION"))
			{
				return VERSION.GetStatic<int>("SDK_INT") >= 23;
			}
		}

		/// <summary>
		/// Check the permission whether this app is granted.
		/// </summary>
		/// <returns>Return true if it's allowed.</returns>
		/// <param name="permission">Permission.</param>
		public static bool HasPermission(string permission)
		{
		if (IsAndroidMOrGreater())
		{
		  using (var activity = GetActivity())
		  {
		    return activity.Call<int>("checkSelfPermission", permission) == 0;
		  }
		}

		return true;
		}

		/// <summary>
		/// Ask activity should show the permission rationale.
		/// </summary>
		/// <returns>Return true if it should show the permission rationale.</returns>
		/// <param name="permission">Permission.</param>
		public static bool ShouldShowRequestPermissionRationale(string permission)
		{
		if (IsAndroidMOrGreater())
		{
		  using (var activity = GetActivity())
		  {
		    return activity.Call<bool>("shouldShowRequestPermissionRationale", permission);
		  }
		}

		return false;
		}

		/// <summary>
		/// Request the currentActivity to show the permission request dialog.
		/// </summary>
		/// <param name="permissiions">Permissiions.</param>
		public static void RequestPermission(string[] permissiions)
		{
			if (IsAndroidMOrGreater())
			{
			  using (var activity = GetActivity())
			  {
			  	activity.Call("requestPermissions", permissiions, 0);
			  }
			}
		}
	}
}