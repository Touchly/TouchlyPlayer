
using UnityEngine;
#if STEAM_VR
using Valve.VR;
#endif

public class Recenter : MonoBehaviour
{
	public OVRInput.RawButton resetButton = OVRInput.RawButton.Y;

	void Update()
	{
        #if STEAM_VR
        if (SteamVR_Actions._default.Recenter.GetStateDown(SteamVR_Input_Sources.Any))
        {
            //Valve.VR.OpenVR.System.ResetSeatedZeroPose();
        }
        #else
		if (OVRInput.GetDown(resetButton))
		{
			OVRManager.display.RecenterPose();
		}
        #endif
	}
}
