using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.IO;
using System;
using static CurrentVideo;
using UnityEngine.SceneManagement;


public class BrowseLibrary : MonoBehaviour
{
    public CurrentVideo currentVideo;
    string currentFolder;
    public GameObject loading, returnButton;
    string homeDirectory;

    enum SortOptions { Name, Date, Size};
    SortOptions sortOption = SortOptions.Name;
    
    public void setSortOption(int i){
        sortOption = (SortOptions)i;
        StartCoroutine(ScanFolder(currentFolder));
    }

    public void CleanScreen(){
        foreach (Transform child in transform)
        {
            Destroy(child.gameObject);
        }
    }

        // Start point
    public void searchFiles()
    {
        CleanScreen();
        Debug.Log("Scanning...");
        loading.SetActive(true);

        homeDirectory = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);

        string lastDirectory = PlayerPrefs.GetString("lastDirectory", homeDirectory);
        
        if (!Directory.Exists(lastDirectory)){
            lastDirectory = homeDirectory;
        }

        returnButton.SetActive(true);

        StartCoroutine(ScanFolder(lastDirectory));
    }
    
    void OnDisable(){
        returnButton.SetActive(false);
        PlayerPrefs.SetString("lastDirectory", currentFolder);
        PlayerPrefs.Save();
    }

    GameObject instantiatePreview(string name, int i, Texture2D thumbnail=null, int type=0){

        GameObject go = null;

        if (type==0){
            go = Instantiate(Resources.Load("previewFile") as GameObject);
        } else if (type==1) {
            go = Instantiate(Resources.Load("previewFolder") as GameObject);
        } else if (type==2) {
            go = Instantiate(Resources.Load("previewMount") as GameObject);
        }
        else {
            return null;
        }
        
        go.transform.SetParent(gameObject.transform);
        go.transform.localPosition = Vector3.zero;
        go.transform.localScale = Vector3.one;
        go.name = name;
        go.GetComponentInChildren<Text>().text = name;
        

        // Video
        if (type==0){

            int format =0 ; 
            bool pre = false;
            
            if (name.Contains("Touchly0")){
                pre= true;
                format = 0;
            } else if (name.Contains("Touchly1")){
                pre= true;
                format = 1;
            } else if (name.Contains("Touchly2")){
                pre= true;
                format = 2;
            } else if (name.Contains("r3d")) {
                pre = true;
                format = 4;
            }

            else {
                pre = false;
            }

            if (pre){
                GameObject im = Instantiate(Resources.Load("flag") as GameObject);
                im.transform.SetParent(go.transform);
                im.transform.localPosition = new Vector3(30.1f, -29.97f, 0f);
                im.transform.localScale = Vector3.one * 0.3f;
            }
        }
        return go;
    }

    public void scanFolder(string path){
        StartCoroutine(ScanFolder(path));
    }

    private videoMapping DetectMapping(string name){
        //Check if '_180' or '_360' is in the name
        if (name.Contains("_180")){
            return videoMapping.HalfSphere;
        }
        else if (name.Contains("_360")){
            return videoMapping.Sphere;
        }
        else{
            return videoMapping.Flat;
        }
    }

    private packingStereo DetectPacking(string name){
        if (name.Contains("LR") || name.Contains("3DH")|| name.Contains("SBS")){
            return packingStereo.LeftRight;
        }
        else if (name.Contains("TB") || name.Contains("3DV") || name.Contains("OverUnder")){
            return packingStereo.TopBottom;
        }
        else {
            return packingStereo.None;
        }
    }


    void ShowDrives(){
        CleanScreen();

        DriveInfo[] allDrives = DriveInfo.GetDrives();
        List<DriveInfo> availableDrives = new List<DriveInfo>();

        Debug.Log("Drives: " + allDrives.Length);
        Debug.Log("Drives: " + allDrives[0].Name);

        returnButton.SetActive(false);

        foreach (DriveInfo d in allDrives){
            if (d.IsReady){
                availableDrives.Add(d);
                GameObject driveObj = instantiatePreview(d.Name, availableDrives.Count-1, type:2);

                int height = (int)driveObj.GetComponent<RectTransform>().rect.height;

                Button button = driveObj.GetComponent<Button>();
                button.name = d.Name + "_Button";
                string tempString = d.Name;
                
                button.onClick.AddListener(() => scanFolder(d.Name));
            }
        }
    }

    public void returnFolder(){
        int lastSlashIndex = currentFolder.LastIndexOf("\\");

        if (lastSlashIndex == -1){
            #if UNITY_EDITOR || UNITY_STANDALONE
            ShowDrives();
            #else
            returnButton.SetActive(false);
            #endif
            return;
        }

        string newSubFolder = currentFolder.Substring(0, lastSlashIndex);

        scanFolder(newSubFolder);
    }

    class SortByCreationTime : IComparer<FileInfo>
    {
        #region IComparer<FileInfo> Members

        public int Compare(FileInfo x, FileInfo y)
        {
            return x.CreationTime.CompareTo(y.CreationTime);
        }

        #endregion
    }

    class SortByName : IComparer<FileInfo>
    {
        #region IComparer<FileInfo> Members

        public int Compare(FileInfo x, FileInfo y)
        {
            return x.Name.CompareTo(y.Name);
        }

        #endregion
    }

    class SortBySize : IComparer<FileInfo>
    {
        #region IComparer<FileInfo> Members

        public int Compare(FileInfo x, FileInfo y)
        {
            return x.Length.CompareTo(y.Length);
        }

        #endregion
    }


    class SortByCreationTimeFolder : IComparer<DirectoryInfo>
    {
        #region IComparer<FileInfo> Members

        public int Compare(DirectoryInfo x, DirectoryInfo y)
        {
            return x.CreationTime.CompareTo(y.CreationTime);
        }

        #endregion
    }

    class SortByNameFolder : IComparer<DirectoryInfo>
    {
        #region IComparer<FileInfo> Members

        public int Compare(DirectoryInfo x, DirectoryInfo y)
        {
            return x.Name.CompareTo(y.Name);
        }

        #endregion
    }

    private IEnumerator ScanFolder(string folder){
        CleanScreen();

        Debug.Log("Scanning "+ folder);

        returnButton.SetActive(true);
        currentFolder = folder;
        string[] extensions = new string[] { ".asf", ".avi", ".dv", ".m4v", ".mov", ".mp4", ".mpg", ".mpeg", ".ogv", ".vp8", ".wmv", ".mkv" };
        var files = new FileInfo[0];
        var folders = new DirectoryInfo[0];
        List<FileInfo> files2 = new List<FileInfo>();
        List<DirectoryInfo> folders2 = new List<DirectoryInfo>();

        // Get files
        try {
            DirectoryInfo dir = new DirectoryInfo(folder);

            files = dir.GetFiles("*.*");
            folders = dir.GetDirectories();

        } catch (System.Exception e){
            Debug.Log(e);
        }

        loading.SetActive(false);
        
        // Add video files
        foreach (var file in files){
            foreach (var extension in extensions)
            {
                if (file.Extension.ToLower().Contains(extension))
                {
                    files2.Add(file);
                }
            }
        }

        // Sort
        if (sortOption == SortOptions.Name)
            files2.Sort(new SortByName());
        else if (sortOption == SortOptions.Size)
            files2.Sort(new SortBySize());
        else if (sortOption == SortOptions.Date)
            files2.Sort(new SortByCreationTime());

        int i = 0;
        
        foreach (var file in files2){
            GameObject fileObj = instantiatePreview(file.Name, i, type:0);
            Button button = fileObj.GetComponent<Button>();

            button.name = file.Name + "_Button";
            string filePath = file.FullName;
            string name = file.Name;
            int format =0; 
            bool pre = false;

            if (name.Contains("Touchly0")){
                pre= true;
                format = 0;
            } else if (name.Contains("Touchly1")){
                pre= true;
                format = 1;
            } else if (name.Contains("Touchly2")){
                pre= true;
                format =2 ;
            } else if (name.Contains("Touchly2")){
                pre= true;
                format = 2;
            } else if (name.Contains("r3d")) {
                pre = true;
                format = 4;
            }

            button.onClick.AddListener(() => SceneInfo(filePath, name, pre, format));

            i++;
        }
        
        
        foreach (var folder2 in folders){
            folders2.Add(folder2);
        }

        if (sortOption == SortOptions.Name)
            folders2.Sort(new SortByNameFolder());
        else if (sortOption == SortOptions.Date)
            folders2.Sort(new SortByCreationTimeFolder());

        foreach (var folder2 in folders2){
            i++;
            GameObject folderObj = instantiatePreview(folder2.Name, folders2.Count-1, type:1);
            Button button = folderObj.GetComponent<Button>();
            button.name = folder2.Name + "_Button";
            string tempString = folder2.FullName;
            button.onClick.AddListener(() => scanFolder(tempString));
        }

        gameObject.GetComponent<RectTransform>().sizeDelta = new Vector2(0, (i + 1) / 4 * 125);
        
        yield return null;
    }

    public void SceneInfo(string path, string name, bool _pre, int format)
    {
        bool canSearch = false;
        Dictionary<string, VideoData> videoDict = null;

        try
        {
            canSearch = ES3.KeyExists("videoDict");
            videoDict = ES3.Load<Dictionary<string, VideoData>>("videoDict");
            Debug.Log("Can read from Dictionary");

            canSearch = canSearch && videoDict.ContainsKey(path);
            Debug.Log("Path exists");
            
        } catch
        {
            canSearch = false;
            Debug.Log("Failed  to seach for Dictionary");
        }

        currentVideo.format = format;
        currentVideo.preprocessed = _pre;

        if (canSearch)
        {
            VideoData vd = videoDict[path];

            //Dirty solution
            //currentVideo.format = vd.format;
            currentVideo.packing = vd.packing;
            currentVideo.mapping = vd.mapping;
            currentVideo.mode = vd.mode;
            currentVideo.volumetricPlayback = vd.volumetricPlayback;
            currentVideo.reference = vd.reference;
            //currentVideo.preprocessed = vd.preprocessed;
            
            if (PlayerPrefs.GetInt("resume_playback",0)==1){
                currentVideo.lastTime = vd.lastTime;
            } else {
                currentVideo.lastTime = 0;
            }
            
            currentVideo.path = vd.path;
            //Passthrough
            currentVideo.opacity = vd.opacity;
            currentVideo.holoWidth = vd.holoWidth;
            currentVideo.holoFocus = vd.holoFocus;
            currentVideo.holoCenter = vd.holoCenter;
            currentVideo.holoSmoothing = vd.holoSmoothing;
            //Color
            currentVideo.Exposition = vd.Exposition;
            currentVideo.Contrast = vd.Contrast;
            currentVideo.Saturation = vd.Saturation;
            //Offset
            currentVideo.offsetHorizontal = vd.offsetHorizontal;
            currentVideo.offsetVertical = vd.offsetVertical;
            currentVideo.zoom = vd.zoom;
            //3D
            currentVideo.depth = vd.depth;
            currentVideo.edgeSens = vd.edgeSens;
            currentVideo.baseline = vd.baseline;
            currentVideo.swap = vd.swap;

            Debug.Log("Using saved video data");
        } else {
            Debug.Log("No saved video data");
            //Default values
            currentVideo.reference = videoReference.Absolute;
            //currentVideo.preprocessed = _pre;
            currentVideo.path = path;

            // Guess from title
            currentVideo.packing = packingStereo.None;
            
            if (_pre){
                currentVideo.volumetricPlayback = true;
                currentVideo.mode = volumetricMode._Dynamic;
            } else {
                currentVideo.volumetricPlayback = false;
                currentVideo.mapping = DetectMapping(name);
                currentVideo.packing = DetectPacking(name);
            }

            //Passthrough
            currentVideo.opacity = 7.92f;
            currentVideo.holoWidth = 0.35f;
            currentVideo.holoCenter = 0.74f;
            currentVideo.holoSmoothing = 0.03f;
            currentVideo.holoFocus = 0f;
            currentVideo.lastTime = 0f;
            //Color
            currentVideo.Exposition = 7;
            currentVideo.Contrast = 7;
            currentVideo.Saturation = 7;
            //Offset
            currentVideo.offsetHorizontal = 0;
            currentVideo.offsetVertical = 0;
            currentVideo.zoom = 0;
            //3D
            if (format==1){
                currentVideo.depth = 0.1f;
            } else {
                currentVideo.depth = 0.742f;
            }
            
            currentVideo.baseline = 7;
            currentVideo.swap = false;
        }
        
        //Load scene previously set.
        if (currentVideo.volumetricPlayback){
            switch (currentVideo.mode)
            {
                case volumetricMode._Static:
                    if (format != 1 && format!=4){
                        SceneManager.LoadScene("Static_Interaction", LoadSceneMode.Single);
                    } else {
                        SceneManager.LoadScene("Dynamic_Interaction", LoadSceneMode.Single);
                    }
                    break;
                case volumetricMode._Dynamic:
                    SceneManager.LoadScene("Dynamic_Interaction", LoadSceneMode.Single);
                    break;
                case volumetricMode._Passthrough:
                    SceneManager.LoadScene("Hologram_Interaction", LoadSceneMode.Single);
                    break;
                default:
                    SceneManager.LoadScene("Dynamic_Interaction", LoadSceneMode.Single);
                    break;
            }
        }
        else
        {
            SceneManager.LoadScene("Classic", LoadSceneMode.Single);
        }
    }
}
