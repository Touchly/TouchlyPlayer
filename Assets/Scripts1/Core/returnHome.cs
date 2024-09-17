using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class returnHome : MonoBehaviour
{
    public void ReturnHome()
    {
        SceneManager.LoadScene("MainMenu_AVPro", LoadSceneMode.Single);
    }
}
