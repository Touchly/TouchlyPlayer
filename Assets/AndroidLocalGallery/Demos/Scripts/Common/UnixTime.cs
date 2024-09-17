using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class UnixTime : MonoBehaviour {

    private static DateTime UnixEpoch = new DateTime(1970, 1, 1, 0, 0, 0, 0);
    public static DateTime GetDateTime(long unixTime){
		DateTime dateTime = UnixEpoch.AddSeconds(unixTime).ToLocalTime();
		return dateTime;
	}
}
