using UnityEngine;
 
public class LogCollection : MonoBehaviour
{
    string filename = "";

    void OnEnable() { 
        Application.logMessageReceived += Log;
        //Don't destroy this object between scenes
        DontDestroyOnLoad(this.gameObject);
    }

    void OnDisable() { Application.logMessageReceived -= Log; }
    
    public void Log(string logString, string stackTrace, LogType type)
    {
        if (filename == "")
        {
            string d = Application.persistentDataPath + "/Logs";
            System.IO.Directory.CreateDirectory(d);
            filename = d + "/logs.txt";
        }

        try {
            // Add timestamp
            if (logString != "\"\" mesh must have at least three distinct vertices to be a valid collision mesh." && logString !="ArgumentException: RenderTextureDesc graphicsFormat and depthStencilFormat cannot both be None."){
                logString = System.DateTime.Now.ToString("HH:mm:ss") + " " + logString;
                System.IO.File.AppendAllText(filename, logString + "\n");
            }  
        }
        catch { }
    }
}
 