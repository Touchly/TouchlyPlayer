using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.SceneManagement;

public class chooseSize : MonoBehaviour
{
    public RenderTexture inputX2;
    public RenderTexture inputX3;
    private VideoPlayer Player2;
    

    void OnEnable()
    {
        SceneManager.sceneLoaded += OnLevelFinishedLoading;
        inputX2.vrUsage = VRTextureUsage.TwoEyes;
    }

    void OnDisable()
    {
        SceneManager.sceneLoaded -= OnLevelFinishedLoading;
    }
    // Start is called before the first frame update
    void OnLevelFinishedLoading(Scene scene, LoadSceneMode mode)
    {
        if (scene.name == "Interaction")
        {
            int preprocessed = PlayerPrefs.GetInt("preprocessed");
            
            Player2 = gameObject.GetComponent<VideoPlayer>();
            //Sets to the correct sized texture
            if (preprocessed == 1)
            {
                Player2.targetTexture = inputX3;
            }
            else
            {
                Player2.targetTexture = inputX2;
            }
           

            Player2.Play();
        }
    }

}
