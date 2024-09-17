using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using RenderHeads.Media.AVProVideo;
using UnityEngine.Events;
using UnityEngine.UI;

public class PlayerMenuAV6dof : MonoBehaviour
{
    public GameObject mesh, player;
    public UnityEvent TogglePlay, ReturnHome;
    public UnityEvent<float> skip;
    public UnityEvent<bool> touchScreen;
    private bool menuOpen=false;
    public CanvasGroup UI;
    public OVRInput.RawButton playPauseButton, backButton;
    public GameObject MeshDisplay;
    public const string Keyword_ForceEyeNone = "FORCEEYE_NONE";
    public const string Keyword_ForceEyeLeft = "FORCEEYE_LEFT";
    public const string Keyword_ForceEyeRight = "FORCEEYE_RIGHT";
    private float _jumpDeltaTime = 5f;

    // Start is called before the first frame update
    void Start()
    {
        toggleVisibility();
        MeshDisplay.GetComponent<Renderer>().material.DisableKeyword(Keyword_ForceEyeLeft);
        MeshDisplay.GetComponent<Renderer>().material.EnableKeyword(Keyword_ForceEyeRight);
        MeshDisplay.GetComponent<Renderer>().material.DisableKeyword(Keyword_ForceEyeNone);
    }

    // Update is called once per frame
    void Update()
    {
        //User inputs

        if (OVRInput.GetUp(OVRInput.Button.Start))
        {
            //Toggle menu open
            menuOpen = !menuOpen;
            toggleVisibility();

        }

        if (OVRInput.GetDown(playPauseButton))
        {
            //Toggle player play
            TogglePlay.Invoke();
        }

        if (OVRInput.GetDown(OVRInput.Button.PrimaryThumbstickRight))
        {
            Debug.Log("Right");
            skip.Invoke(_jumpDeltaTime);
        }


        if (OVRInput.GetDown(OVRInput.Button.PrimaryThumbstickLeft))
        {
            Debug.Log("Left");
            skip.Invoke(-_jumpDeltaTime);

        }

        if (OVRInput.GetDown(backButton))
        {
            //Toggle player play
            ReturnHome.Invoke();
        }


        //test
    }
    void OnDisable()
    {
        //Destroy(player);
    }
    private void toggleVisibility()
    {
        if (menuOpen)
        {
            UI.alpha = 1f;
            player.SetActive(true);
            mesh.SetActive(false);
        }
        else
        {
            UI.alpha = 0f;
            player.SetActive(false);
            mesh.SetActive(true);

        }
    }
}
