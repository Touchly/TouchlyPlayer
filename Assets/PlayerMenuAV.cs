using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using RenderHeads.Media.AVProVideo;
using UnityEngine.Events;
using UnityEngine.UI;
using DG.Tweening;

#if STEAM_VR
using Valve.VR;
#endif

public class PlayerMenuAV : MonoBehaviour
{
    public GameObject mesh, player, ray, ray2, monoScreen;
    //public GameObject[] leftControllers, rightControllers;
    public UnityEvent TogglePlay, ReturnHome, ToggleMenuEvent;
    public UnityEvent<float> skip;
    public UnityEvent resetColor;
    public UnityEvent<bool> handsSwitch;

    private bool menuOpen=false;
    public CanvasGroup UI;

    OVRInput.RawButton playPauseButton = OVRInput.RawButton.A;
    OVRInput.RawButton backButton = OVRInput.RawButton.B;
    OVRInput.RawButton triggerButton = OVRInput.RawButton.RIndexTrigger;
    OVRInput.RawButton showMenuButton = OVRInput.RawButton.Start | OVRInput.RawButton.X;

    OVRInput.Button skipBackwardButton = OVRInput.Button.PrimaryThumbstickLeft | OVRInput.Button.SecondaryThumbstickLeft;
    OVRInput.Button skipForwardButton = OVRInput.Button.PrimaryThumbstickRight | OVRInput.Button.SecondaryThumbstickRight;
    
    public GameObject MeshDisplay;
    public const string Keyword_ForceEyeNone = "FORCEEYE_NONE";
    public const string Keyword_ForceEyeLeft = "FORCEEYE_LEFT";
    public const string Keyword_ForceEyeRight = "FORCEEYE_RIGHT";
    float jumpDeltaTime = 5f;
    public GameObject SkipDisplay, playerOnly, PhysicsMesh;
    public CurrentVideo currentVideo;
    private float timer;
    public bool useTriggerOpen=false;
    public bool useTriggerClose=false;
    bool canHide = true;

    // Start is called before the first frame update
    public void canHideSet(bool value)
    {
        canHide = value;
    }

    void Start()
    {
        useTriggerOpen = useTriggerOpen || (PlayerPrefs.GetInt("watchonly_mode", 0) == 1);
        jumpDeltaTime = (float)PlayerPrefs.GetInt("skip_time",5);
        if (jumpDeltaTime ==0){
            jumpDeltaTime = 5f;
        }
        
        toggleVisibility();
        ResetTimer();
        if (MeshDisplay){
            if (currentVideo.preprocessed)
            {
                MeshDisplay.transform.localRotation = Quaternion.Euler(0.0f, -90f, 0.0f);
            } else
            {
                MeshDisplay.transform.localRotation = Quaternion.Euler(0.0f, 180f, 0.0f);
            }
        }

        //Sequence mySequence = DOTween.Sequence();
    }

    public void ResetTimer()
    {
        timer = 5f;
    }

    public void ToggleMenu()
    {
        menuOpen = !menuOpen;
        toggleVisibility();
    }

    
    // Update is called once per frame
    void Update()
    {
        if (timer>0){
            timer -= Time.deltaTime;
        } else {
            ResetTimer();
            if (menuOpen)
            {
                ToggleMenu();
            }
        }

        //User inputs  
        #if STEAM_VR
        if (SteamVR_Input.GetBooleanAction("ShowHideUI").GetStateUp(SteamVR_Input_Sources.Any))
        #else
        if (OVRInput.GetUp(showMenuButton))
        #endif
        {
            //Toggle menu open
            ToggleMenuEvent.Invoke();
            ResetTimer();
            menuOpen = !menuOpen;
            toggleVisibility();
        }

        #if STEAM_VR
        if (SteamVR_Input.GetBooleanAction("PlayPause").GetStateDown(SteamVR_Input_Sources.Any))
        #else
        if (OVRInput.GetDown(playPauseButton) && !OVRInput.IsControllerConnected(OVRInput.Controller.Hands))
        #endif
        {
            TogglePlay.Invoke();
            ResetTimer();
        }
        
        #if STEAM_VR
        if (SteamVR_Input.GetBooleanAction("InteractUI").GetStateDown(SteamVR_Input_Sources.Any))
        #else
        if (OVRInput.GetDown(triggerButton))
        #endif        
        {
            //Open menu
            ResetTimer();
            if (!menuOpen){
                if (useTriggerOpen){
                    menuOpen = !menuOpen;
                    toggleVisibility();
                }
            } else {
                if (canHide){
                    if (useTriggerClose){
                        menuOpen = !menuOpen;
                        toggleVisibility();
                    }
                }
            }
        }

        
        #if STEAM_VR
        if (SteamVR_Input.GetBooleanAction("SkipForward").GetStateDown(SteamVR_Input_Sources.Any))
        #else
        if (OVRInput.GetDown(skipForwardButton))
        #endif    
        {
            skip.Invoke(jumpDeltaTime);
            ResetTimer();
        }

        #if STEAM_VR
        if (SteamVR_Input.GetBooleanAction("SkipBackward").GetStateDown(SteamVR_Input_Sources.Any))
        #else
        if (OVRInput.GetDown(skipBackwardButton))
        #endif    
        {
            skip.Invoke(-jumpDeltaTime);
            ResetTimer();
        }
        
        #if STEAM_VR
        if (SteamVR_Input.GetBooleanAction("ExitToMenu").GetStateDown(SteamVR_Input_Sources.Any))
        #else
        if (OVRInput.GetDown(backButton))
        #endif   
        {
            ReturnHome.Invoke();
        }

    }

    private void toggleVisibility()
    {
        if (menuOpen)
        {
            if (monoScreen && (currentVideo.format==0 || currentVideo.format==2))
            {
                monoScreen.SetActive(true);
            }
            
            handsSwitch.Invoke(true);

            if (ray){
                ray.SetActive(true);
            }
            if (ray2){
                ray2.SetActive(true);
            }

            UI.DOFade(1f, 0.22f);

            UI.interactable = true;
            player.SetActive(true);

            if (mesh)
            {
                mesh.SetActive(false);
            }
            
            if (MeshDisplay)
            {
                MeshDisplay.GetComponent<Renderer>().material.DisableKeyword(Keyword_ForceEyeLeft);
                MeshDisplay.GetComponent<Renderer>().material.EnableKeyword(Keyword_ForceEyeRight);
                MeshDisplay.GetComponent<Renderer>().material.DisableKeyword(Keyword_ForceEyeNone);
            }

            if (SkipDisplay)
            {
                SkipDisplay.SetActive(true);
            }
        }
        else
        {
            resetColor.Invoke();
            if (monoScreen )
            {
                monoScreen.SetActive(false);
            }
            
            handsSwitch.Invoke(false);

            if (ray){
                ray.SetActive(false);
            }
            if (ray2){
                ray2.SetActive(false);
            }

            UI.DOFade(0f, 0.22f).OnComplete(PlayerHide);

            UI.interactable = false;
            

            if (mesh) {
                mesh.SetActive(true);
            }

            
            if (MeshDisplay)
            {
                MeshDisplay.GetComponent<Renderer>().material.DisableKeyword(Keyword_ForceEyeLeft);
                MeshDisplay.GetComponent<Renderer>().material.DisableKeyword(Keyword_ForceEyeRight);
                MeshDisplay.GetComponent<Renderer>().material.EnableKeyword(Keyword_ForceEyeNone);
            }

            if (SkipDisplay)
            {
                SkipDisplay.SetActive(false);
            }
        }
    }

    private void PlayerHide()
    {
        player.SetActive(false);
    }

    public void focusSettings(bool active)
    {
        if (active)
        {
            playerOnly.SetActive(false);
            player.SetActive(false);
            mesh.SetActive(true);
            PhysicsMesh.SetActive(false);
            SkipDisplay.SetActive(false);
        } else
        {
            playerOnly.SetActive(true);
            player.SetActive(true);
            mesh.SetActive(false);
            PhysicsMesh.SetActive(true);
            SkipDisplay.SetActive(true);
        }
    }
}
