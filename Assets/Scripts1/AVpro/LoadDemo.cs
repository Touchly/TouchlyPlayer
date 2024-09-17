using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using static CurrentVideo;


public class LoadDemo : MonoBehaviour
{
    public CurrentVideo currentVideo;

    // Start is called before the first frame update
    public void LoadScene(int scene)
    {
        currentVideo.reference = videoReference.StreamingAssets;
        switch (scene) {
            case 0:
                //Dog
                SceneManager.LoadScene("Static_Interaction", LoadSceneMode.Single);
                currentVideo.path = "doggo.mp4";
                break;

            case 1:
                //Snake
                SceneManager.LoadScene("Dynamic_Interaction", LoadSceneMode.Single);
                currentVideo.path = "birds.mp4";
                break;

            case 2:
                //Yoga
                SceneManager.LoadScene("Hologram_Interaction", LoadSceneMode.Single);
                currentVideo.path = "yoga.mp4";
                break;
        }
    }
}
