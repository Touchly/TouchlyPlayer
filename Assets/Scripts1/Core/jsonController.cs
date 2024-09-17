using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;

public class jsonController : MonoBehaviour
{
    public string jsonURL;
    

    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(getData());
    }

    IEnumerator getData()
    {
        UnityWebRequest _www = UnityWebRequest.Get(jsonURL);

        yield return _www.Send();

        if(!_www.isNetworkError)
        {
            Debug.Log(_www.downloadHandler.text);
            processJsonData(_www.downloadHandler.text);
        } else
        {
            Debug.Log("Failed to fetch json");
        }
    }

    private void processJsonData(string _url)
    {
        JsonData jsonData = JsonUtility.FromJson<JsonData>(_url);
        Debug.Log(jsonData);
    }
}
