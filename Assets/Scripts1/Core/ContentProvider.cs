using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Networking;
using ES3Internal;
using Michsky.UI.ModernUIPack;

public class ContentProvider : MonoBehaviour
{
    CustomDropdown dropdown;
    Dictionary<string, string> providers;
    public UnityEvent<string> onProviderChange;
    public Sprite emptySprite;
    JsonData jsonData;


    public void processJsonData(string _url, string url)
    {
        jsonData = JsonUtility.FromJson<JsonData>(_url);

        string name = jsonData.name;

        if (providers.ContainsKey(name))
        {
            Debug.Log("Provider already exists");
            return;
        }
        providers.Add(name, url);
        Refresh();
    }

    IEnumerator getData(string url)
    {
        UnityWebRequest _www = UnityWebRequest.Get(url);

        yield return _www.Send();

        if(!_www.isNetworkError)
        {
            processJsonData(_www.downloadHandler.text, url);
        } else
        {
            Debug.Log("Failed to fetch json");
        }
    }

    // Start is called before the first frame update
    public void Refresh(){
        // Clear dropdown
        dropdown.dropdownItems.Clear();
        foreach (KeyValuePair<string, string> provider in providers)
        {
            dropdown.CreateNewItem(provider.Key, emptySprite);
        }
    }

    void OnEnable()
    {
        dropdown = GetComponent<CustomDropdown>();

        //Create or load providers dictionary
        if (ES3.KeyExists("Providers"))
        {
            if (providers == null)
            {
                Debug.Log("Providers found, loading from disk");
                providers = ES3.Load<Dictionary<string, string>>("Providers");
            }
        }
        else
        {
            Debug.Log("No providers found, creating new dictionary");
            providers = new Dictionary<string, string>();
            providers.Add("Touchly", "https://touchlydata.s3.amazonaws.com/videoData.json");
            ES3.Save<Dictionary<string, string>>("Providers", providers);
        }
        Refresh();
        
    }

    public void AddProvider(string url)
    {
        StartCoroutine(getData(url));
    }

    public void LoadProvider(int index){
        string providerName = dropdown.dropdownItems[index].itemName;
        string providerUrl = providers[providerName];
        Debug.Log("Loading content from provider: " + providerName + " from url: " + providerUrl);
        onProviderChange.Invoke(providerUrl);
    }

    void OnDisable()
    {
        ES3.Save<Dictionary<string, string>>("Providers", providers);
    }
}
