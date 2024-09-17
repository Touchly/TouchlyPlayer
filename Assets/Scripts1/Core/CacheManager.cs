using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using System.IO;

public class CacheManager : MonoBehaviour
{
    public TextMeshProUGUI cacheText, appVersion;
    string path;
    DirectoryInfo di;

    public static long DirSize(DirectoryInfo d)
    {
        long size = 0;
        // Add file sizes.
        FileInfo[] fis = d.GetFiles();
        foreach (FileInfo fi in fis)
        {
            size += fi.Length;
        }
        // Add subdirectory sizes.
        DirectoryInfo[] dis = d.GetDirectories();
        foreach (DirectoryInfo di in dis)
        {
            size += DirSize(di);
        }
        return size;
    }

    // Start is called before the first frame update
    void OnEnable()
    {
        appVersion.SetText("Touchly v" + (string)Application.version);

        path = Application.persistentDataPath;
        di = new DirectoryInfo(path);

        //long directorySize = DirSize(di)/1000000;
        long size = 0;
        foreach (FileInfo fi in di.GetFiles("*.*", SearchOption.AllDirectories))
        {
            size += fi.Length;
        }
        size = size / 1000000;
        cacheText.SetText("Cache size: " + size.ToString() + " MB");
    }

    public void deleteCache()
    {
        Debug.Log("Deleting cache");

        foreach (FileInfo file in di.GetFiles())
        {
            file.Delete();
        }
        foreach (DirectoryInfo dir in di.GetDirectories())
        {
            dir.Delete(true);
        }
        cacheText.SetText("Cache size: 0 MB");
    }
}
