using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.Events;

public class playerMenu6dof : MonoBehaviour
{
    public GameObject PlayerUI;
    private bool menuOpen;
    private VideoPlayer player;
    public UnityEvent TogglePlay, ReturnHome;
    public UnityEvent<float> skip;
    private CanvasGroup group;
    public float skipValue;
    public OVRInput.RawButton playPauseButton, backButton;
    public GameObject depth;
    public Material skybox;
    public RenderTexture Mono;
    // Start is called before the first frame update
    void Start()
    {
        //Reset Skybox Settings
        skybox.SetFloat("_Exposure", 1f);
        skybox.SetFloat("_Layout", 0f);
        skybox.mainTexture = Mono;

        menuOpen = false;
        //group=PlayerUI.GetComponent<CanvasGroup>();
        player = GameObject.Find("MainPlayer").GetComponent<VideoPlayer>();
    }

    // Update is called once per frame
    void Update()
    {
        //User inputs

        if (OVRInput.GetUp(OVRInput.Button.Start))
        {
            //Toggle menu open
            menuOpen = !menuOpen;
            if (menuOpen){
                depth.SetActive(false);
            }
            else
            {
                depth.SetActive(true);
            }    
        }

        if (OVRInput.GetDown(playPauseButton))
        {
            //Toggle player play
            TogglePlay.Invoke();
        }

        if (OVRInput.GetDown(OVRInput.Button.PrimaryThumbstickRight))
        {
            //Toggle player play
            skip.Invoke((float)(player.time + skipValue) * 1000f);
        }


        if (OVRInput.GetDown(OVRInput.Button.PrimaryThumbstickLeft))
        {
            //Toggle player play
            skip.Invoke((float)(player.time - skipValue) * 1000f);
        }

        if (OVRInput.GetDown(backButton))
        {
            //Toggle player play
            ReturnHome.Invoke();
        }
        if (menuOpen)
        {
            //Render mono texture
            PlayerUI.SetActive(true);
            //Make mesh flat
            
        }
        else
        {
            PlayerUI.SetActive(false);
            //Reset mesh again
            
            //Material settings

        }
        //test
    }
    void OnDisable()
    {
        Destroy(player);
    }

}
