using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.Events;

public class playerMenu2 : MonoBehaviour
{
    public GameObject PlayerUI, mesh;
    public Material VRSkybox;
    public RenderTexture Stereo, Mono;
    public UnityEvent<bool> setMono;
    public UnityEvent TogglePlay, ReturnHome;
    public UnityEvent<float> skip;
    public float skipValue;
    private bool menuOpen;
    private CanvasGroup group;
    public OVRInput.RawButton playPauseButton, backButton;

    // Start is called before the first frame update
    void Start()
    {
        menuOpen = false;
        //group=PlayerUI.GetComponent<CanvasGroup>();
        //player = GameObject.Find("MainPlayer").GetComponent<VideoPlayer>();
    }

    // Update is called once per frame
    void Update()
    {
        //User inputs

        if (OVRInput.GetUp(OVRInput.Button.Start))
        {
            //Toggle menu open
            menuOpen = !menuOpen;
        }

        if (OVRInput.GetDown(playPauseButton))
        {
            //Toggle player play
            TogglePlay.Invoke();
        }

        if (OVRInput.GetDown(OVRInput.Button.PrimaryThumbstickRight))
        {
            Debug.Log("Right");
            //Toggle player play
            //skip.Invoke((float)(player.time + skipValue) * 1000f);
        }


        if (OVRInput.GetDown(OVRInput.Button.PrimaryThumbstickLeft))
        {
            Debug.Log("Left");
            //Toggle player play
            //skip.Invoke((float)(player.time - skipValue)*1000f);
        }

        if (OVRInput.GetDown(backButton))
        {
            //Toggle player play
            ReturnHome.Invoke();
        }

        if (menuOpen)
        {
            //Render mono texture
            setMono.Invoke(true);

            PlayerUI.SetActive(true);
            mesh.SetActive(false);

            //Skybox settings
            VRSkybox.SetFloat("_Layout", 0f);
            VRSkybox.SetFloat("_Exposure", 0.7f);
            VRSkybox.mainTexture = Mono;

        }
        else
        {
            setMono.Invoke(false);

            PlayerUI.SetActive(false);
            mesh.SetActive(true);

            //Skybox settings
            VRSkybox.SetFloat("_Layout", 1f);
            VRSkybox.SetFloat("_Exposure", 1f);
            VRSkybox.mainTexture = Stereo;
        }
        //test
    }
    void OnDisable()
    {
        //Destroy(player);
    }

}
