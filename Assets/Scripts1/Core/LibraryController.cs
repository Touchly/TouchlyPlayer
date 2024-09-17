using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using TMPro;

public class LibraryController : MonoBehaviour
{
    private enum Source
    {
        Files,
        Link,
        Browse
    }
    
    private Source source= Source.Files;
    [SerializeField] UnityEvent onFiles, onLink, onBrowse;
    [SerializeField] TextMeshProUGUI sourceText;
    public int defaultTgu = 0;
    int lastSelected;

    void OnEnable()
    {
        lastSelected = PlayerPrefs.GetInt("lastFileSource", defaultTgu);
        selectSource(1); // lastSelected
        #if !UNITY_EDITOR && UNITY_ANDROID
        sourceText.text = "Link";
        #else
        sourceText.text = "Browse";
        #endif
    }

    // Start is called before the first frame update
    public void selectSource(int sourceIndex)
    {
        if (sourceIndex==0){
            onFiles.Invoke();
            source= Source.Files;
        }
        else if (sourceIndex==1){
#if !UNITY_EDITOR && UNITY_ANDROID
            onLink.Invoke();
            source= Source.Link;
#else 
            onBrowse.Invoke();
            source= Source.Browse;
#endif
        }
        lastSelected = sourceIndex;
    }

    void OnDisable()
    {
        PlayerPrefs.SetInt("lastFileSource", lastSelected);
        PlayerPrefs.Save();
    }
}
