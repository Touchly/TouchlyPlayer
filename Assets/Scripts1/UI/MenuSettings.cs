using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Michsky.UI.ModernUIPack;
using UnityEditor;
using TMPro;
using UnityEngine.Events;

public class MenuSettings : MonoBehaviour
{
    int physics_level, watch_only, resume_playback, skip_time, hand_model, use_bhaptics, modelIndex;
    [SerializeField] private TextMeshProUGUI skipTimeText;
    [SerializeField] Material handMaterial, robotMaterial;
    [SerializeField] UnityEvent<Color> setColorEvent;
    [SerializeField] List<GameObject> HandRobot;
    [SerializeField] List<GameObject> HandHuman;
    [SerializeField] List<GameObject> Controller;
    [SerializeField] List<GameObject> UIPointers;
    [SerializeField] GameObject BHapticsMenuObj;
    [SerializeField] List<GameObject> pcExclusiveSettings;
    [SerializeField] List<MonoBehaviour> oculusExclusiveScripts, steamExclusiveScripts;
    Color colorSet;


    void OnEnable()
    {
        #if !STEAM_VR
            foreach (MonoBehaviour script in steamExclusiveScripts)
            {
                script.enabled = false;
            }
            foreach (MonoBehaviour script in oculusExclusiveScripts)
            {
                script.enabled = true;
            }
        #else
            foreach (MonoBehaviour script in steamExclusiveScripts)
            {
                script.enabled = true;
            }
            foreach (MonoBehaviour script in oculusExclusiveScripts)
            {
                script.enabled = false;
            }
        #endif
        
        hand_model = PlayerPrefs.GetInt("hand_model", 0);
        SetHandModel(hand_model);

        skip_time = PlayerPrefs.GetInt("skip_time", 5);
        SetSkip(0);

        string colorString = PlayerPrefs.GetString("hand_color", "CFCECCFF");
        
        watch_only = PlayerPrefs.GetInt("watchonly_mode", 0);
        physics_level = PlayerPrefs.GetInt("physics_level", 1);
        resume_playback = PlayerPrefs.GetInt("resume_playback", 0);
        use_bhaptics = PlayerPrefs.GetInt("use_bhaptics", 0);

        if (use_bhaptics==1){
            if (BHapticsMenuObj) {BHapticsMenuObj.SetActive(true);}
        }
        
        #if UNITY_STANDALONE
            foreach (GameObject obj in pcExclusiveSettings)
            {
                if (obj){ obj.SetActive(true);}
                
            }
        #endif

        Color color = Color.white;
        ColorUtility.TryParseHtmlString("#" + colorString , out color);

        SetHandColorFunc(color);
        setColorEvent.Invoke(color);
    }

    void ActivateHands(List<GameObject> hand, bool activate)
    {
        foreach (GameObject obj in hand)
        {
            if (obj) {obj.SetActive(activate);}
        }
    }
    
    public void SetHandModel(int handModel)
    {
        hand_model = handModel;
        //Set to robot hand
        if (handModel==0){
            ActivateHands(HandRobot, true);
            ActivateHands(HandHuman, false);
            ActivateHands(Controller, false);
        } else if (handModel==1) {
            ActivateHands(HandRobot, false);
            ActivateHands(HandHuman, true);
            ActivateHands(Controller, false);
        } else {
            ActivateHands(HandRobot, false);
            ActivateHands(HandHuman, false);
            ActivateHands(Controller, true);
        }
    }

    public void SetSkip(int num){
        if ((skip_time + num) < 1)
        {
            skip_time = 1;
        } 
        else if ((skip_time + num) > 30)
        {
            skip_time = 30;
        }
        else
        {
            skip_time += num;
        }
        skipTimeText.text = skip_time.ToString();
    }

    public void SetPhysics(int index)
    {
        physics_level = index;
    }

    public void SetModelIndex(int index)
    {
        modelIndex = index;
    }

    public void SetWatchOnly(int index)
    {

        watch_only = index;
        Debug.Log("watch_only set: " +  watch_only.ToString());
    }

    public void SetUseBhaptics(int index){
        use_bhaptics = index;
    }

    public void SetResumePlayback(int index)
    {
        resume_playback = index;
    }

    public static void SetPhysicsSettings(float quality)
    {

        if (quality == 0)
        {
            Time.fixedDeltaTime = 1 / 50f;
            Physics.defaultContactOffset = 0.01f;
            Physics.sleepThreshold = 0.0025f;
            Physics.defaultSolverIterations = 10;
            Physics.defaultSolverVelocityIterations = 10;
            Physics.defaultMaxAngularSpeed = 35f;

        }
        else if (quality == 1)
        {
            Time.fixedDeltaTime = 1 / 60f;
            Physics.defaultContactOffset = 0.0075f;
            Physics.sleepThreshold = 0.001f;
            Physics.defaultSolverIterations = 25;
            Physics.defaultSolverVelocityIterations = 25;
            Physics.defaultMaxAngularSpeed = 35f;
        }
        else if (quality == 2)
        {
            Time.fixedDeltaTime = 1 / 72f;
            Physics.defaultContactOffset = 0.005f;
            Physics.sleepThreshold = 0.00075f;
            Physics.defaultSolverIterations = 50;
            Physics.defaultSolverVelocityIterations = 50;
            Physics.defaultMaxAngularSpeed = 35f;
        }
        else if (quality == 3)
        {
            Time.fixedDeltaTime = 1 / 90f;
            Physics.defaultContactOffset = 0.0035f;
            Physics.sleepThreshold = 0.0001f;
            Physics.defaultSolverIterations = 100;
            Physics.defaultSolverVelocityIterations = 100;
            Physics.defaultMaxAngularSpeed = 35f;
        }
    }

    public void SetHandColorFunc(Color colorIn)
    {
        handMaterial.color = colorIn;
        robotMaterial.color = colorIn;
        colorSet = colorIn;
    }

    void SaveSettings()
    {
        Debug.Log("Saving everything to PlayerPrefs");
        Debug.Log("watch_only saved: " +  watch_only.ToString());

        PlayerPrefs.SetInt("physics_level", physics_level);

        PlayerPrefs.SetInt("skip_time", skip_time);

        PlayerPrefs.SetInt("use_bhaptics", use_bhaptics);

        PlayerPrefs.SetInt("modelIndex", modelIndex);

        SetPhysicsSettings((float)physics_level);

        PlayerPrefs.SetInt("watchonly_mode", watch_only);

        PlayerPrefs.SetInt("resume_playback", resume_playback);

        PlayerPrefs.SetInt("hand_model", hand_model);

        PlayerPrefs.SetString("hand_color", ColorUtility.ToHtmlStringRGBA(colorSet));
        
        PlayerPrefs.Save();
    }

    void OnApplicationQuit()
    {
        SaveSettings();
    }

    void OnDisable() {
        SaveSettings();
    }

    void OnApplicationPause() {
        SaveSettings();
    }

    void OnDestroy() {
        SaveSettings();
    }
}
