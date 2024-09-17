using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;
using System.Text.RegularExpressions;
using HtmlAgilityPack;
using System;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using static CurrentVideo;
using System.Net;
using System.Net.Sockets;
using System.Net.NetworkInformation;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
// TextMeshProUGUI
using TMPro;
//using System.Diagnostics;

public class WebDavLibrary : MonoBehaviour
{
    private List<string> mounts = new List<string>();
    private string[] AllowedVideoFormats = new string[] {"MKV-File", "MP4-File","WEBM-File"};
    public CurrentVideo currentVideo;
    public TextMeshProUGUI ipShowText;
    string root;
    string curIP ="";
    string subnet;

    private Dictionary<string, string> ipToHostname = new Dictionary<string, string>();
    static object lockObj = new object();

    string currentSubFolder = "";
    string prevIp = "";

    public GameObject serverErrorText, loading;
    

    bool choosingMount = true;
    [SerializeField] GameObject returnButton;
    // Start is called before the first frame update

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
        // Get subnet
        subnet = GetLocalSubNet();
        Debug.Log("Using subnet: "+subnet);
        // Scan all IPs in Subnet
        //PingSubnet();
        if (prevIp == "")
        {
            prevIp = PlayerPrefs.GetString("serverIP", "none");
        }

        if (prevIp == "none" || prevIp == ""){
            Debug.Log("No saved IP, scanning subnet");
            PingSubnetUnity();
        } else {
            Debug.Log("Trying with saved IP");

            if (PingHost(prevIp, 8080)){
                choosingMount = true;
                root = "http://"+ prevIp + ":8080";
                StartCoroutine(GetMounts());
                loading.SetActive(false);
            } else {
                Debug.Log("Saved IP not working, scanning subnet");
                prevIp = "";
                PingSubnetUnity();
            }
        }
    }
        
    public async void PingSubnetSingle(){

        System.Net.NetworkInformation.Ping ping = new System.Net.NetworkInformation.Ping();

        for (int i = 2; i < 255; i++)
        {    
            string ip = $"{subnet}.{i}";
            Debug.Log("Checking: "+ip);
            try {
                PingReply reply = ping.Send(ip, 100);
                if (reply.Status == IPStatus.Success)
                {
                try
                {
                    IPHostEntry host = Dns.GetHostEntry(IPAddress.Parse(ip));
                    UnityEngine.Debug.Log($"{ip}, {host.HostName}, Up\n");
                    lock(lockObj){
                        ipToHostname.Add(ip, host.HostName);
                    }
                    
                }
                catch
                {
                    UnityEngine.Debug.LogError($"Couldn't retrieve hostname from {ip}");
                    lock(lockObj){
                        ipToHostname.Add(ip, "Unknown");
                    }
                }
            }
            }
            catch(Exception e) {
                Debug.Log(e);
                Debug.Log("Could not get reply");
            }
            
            
            
        }

        ScannedFinishedCallback();

    }

    public async void PingSubnet(){
        var taskCompletionSource = new TaskCompletionSource<bool>();
        var tasks = new List<Task>();

        System.Net.NetworkInformation.Ping ping = new System.Net.NetworkInformation.Ping();

        for (int i = 2; i < 255; i++)
        {    
            string ip = $"{subnet}.{i}";
            var task = PingSubnetAsync(ping, ip);
        }

        await Task.WhenAll(tasks).ContinueWith(t => {
            taskCompletionSource.SetResult(true);
        });

        int timeout=10000;

        await Task.WhenAny(taskCompletionSource.Task, Task.Delay(timeout));

        ScannedFinishedCallback();

    }

    private async Task TryPortDirectly(string ip)
    {
        string check = "http://" + ip + ":8080";
        UnityWebRequest www = UnityWebRequest.Get(check);
        www.SendWebRequest();

        if (www.result == UnityWebRequest.Result.Success)
        {
            Debug.Log(check);
        }
    }

    private async Task PingSubnetAsyncUnity(string ip){
        
        Debug.Log("Checking "+ip);
        try
        {
            UnityEngine.Ping ping = new UnityEngine.Ping(ip);
            
            while(!ping.isDone){
                await Task.Yield();
            }
        
            if (ping.time>=0){
                try
                {
                    //IPHostEntry host = Dns.GetHostEntry(IPAddress.Parse(ping.ip));
                    //UnityEngine.Debug.Log($"{ping.ip}, {host.HostName}, Up\n");
                    //if (PingHost(ping.ip, 8080)){
                    lock(lockObj){
                        ipToHostname.Add(ping.ip, "NONAME");
                        UnityEngine.Debug.Log($"{ping.ip} Up\n");
                    }
                   // }
                }
                catch
                {
                    UnityEngine.Debug.LogError($"Couldn't retrieve hostname from {ping.ip}");
                    //lock(lockObj){
                    //    ipToHostname.Add(ping.ip, "Unknown");
                    //}
                }
            }
        } catch
        {
            Debug.Log("Could not ping ip: " + ip);
        }
    }

    private async Task HostConnectOnly(string ip)
    {
        try
        {
            IPHostEntry host = Dns.GetHostEntry(IPAddress.Parse(ip));
            ipToHostname.Add(ip, host.HostName);
            Debug.Log("The host is up: "+ host.HostName);
        } catch {
            Debug.Log("Could not connect to "+ ip);
        }
    }


    public async void PingSubnetUnity(){
        var taskCompletionSource = new TaskCompletionSource<bool>();
        List<Task> tasks = new List<Task>();

        for (int i = 2; i < 255; i++)
        {    
            string ip = $"{subnet}.{i}";

            tasks.Add(PingSubnetAsyncUnity(ip));
        }
        
        await Task.WhenAll(tasks).ContinueWith(t => {
            taskCompletionSource.SetResult(true);
        });

        int timeout=20000;

        await Task.WhenAny(taskCompletionSource.Task, Task.Delay(timeout));

        ScannedFinishedCallback();
    }

    public static bool PingHost(string hostUri, int portNumber)
    {
        try
        {
            using (var client = new TcpClient(hostUri, portNumber))
                return true;
        }
        catch
        {
            Debug.Log("Error pinging host:'" + hostUri + ":" + portNumber.ToString() + "'");
            return false;
        }
    }

    private void ScannedFinishedCallback(){

        foreach (KeyValuePair<string, string> entry in ipToHostname)
        {
            curIP = entry.Key;
            Debug.Log("Found: "+entry.Key);
            root = "http://"+ entry.Key + ":8080";
            Debug.Log("Will check: "+ root);
            choosingMount = true;
            StartCoroutine(GetMounts());
            //loading.SetActive(false);
            return;
        }
        serverErrorText.SetActive(true);
        loading.SetActive(false);
    }

    public static string GetLocalSubNet()
    {
        var host = Dns.GetHostEntry(Dns.GetHostName());
        foreach (var ip in host.AddressList)
        {
            if (ip.AddressFamily == AddressFamily.InterNetwork)
            {
                string localIP= ip.ToString();
                string[] ipParts = localIP.Split('.');
                return ipParts[0]+"."+ipParts[1]+"."+ipParts[2]; //Subnet only
            }
        }
        throw new Exception("No network adapters with an IPv4 address in the system!");
    }

    

    private async Task PingSubnetAsync(System.Net.NetworkInformation.Ping ping, string ip)
    {
        await Task.Run(() =>
        {
            try
            {
                PingReply reply = ping.Send(ip);
            

                if (reply.Status == IPStatus.Success)
                {
                    try
                    {
                        IPHostEntry host = Dns.GetHostEntry(IPAddress.Parse(ip));
                        UnityEngine.Debug.Log($"{ip}, {host.HostName}, Up\n");
                        lock(lockObj){
                            ipToHostname.Add(ip, host.HostName);
                        }
                    
                    }
                    catch
                    {
                        UnityEngine.Debug.LogError($"Couldn't retrieve hostname from {ip}");
                        lock(lockObj){
                            ipToHostname.Add(ip, "Unknown");
                        }
                    }
                }
                else
                {
                    UnityEngine.Debug.Log($"{ip}, {reply.Status}");
                }
            } catch
            {
                Debug.Log("Could not send ping");
            }

        });
    }

    
    public void scanFolder(string mount, Button buttonTrigger=null){
        StartCoroutine(GetVideoInfo(mount));
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
        
        gameObject.GetComponent<RectTransform>().sizeDelta = new Vector2(0, (i + 1) / 4 * 300);

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
            } else if (name.Contains("Touchly3")){
                pre = true;
                format = 3;
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

    public void returnFolder(){
        if (!choosingMount){
            int lastSlashIndex = currentSubFolder.LastIndexOf("/");

            if (lastSlashIndex == -1)
            {
                searchFiles();
            } else
            {
                string newSubFolder = currentSubFolder.Substring(0, lastSlashIndex);
                scanFolder(newSubFolder);
            }
        }
    }
    
    void displayMounts()
    {
        returnButton.SetActive(false);
        
        CleanScreen();
        
        Debug.Log("Mount count:" + mounts.Count.ToString());

        for (int i = 0; i < mounts.Count; i++)
        {
            GameObject mount = instantiatePreview(mounts[i], i, type: 2);
            Button button = mount.GetComponent<Button>();
            button.name = mounts[i] + "_Button";
            string mountTarget = mounts[i];
            button.onClick.AddListener(() => scanFolder(mountTarget));
        }
        
    }

    public class ServerData
    {
        public string Name { get; set; }
        public string URL { get; set; }
        public string Type { get; set; }
        public string Size { get; set; }
        public string Date { get; set; }
    }

    void OnDisable()
    {
        PlayerPrefs.Save();
    }

    IEnumerator GetVideoInfo(string mount){
        Debug.Log("Getting all video information from mount: "+ mount);

        choosingMount = false;
        returnButton.SetActive(true);

        UnityWebRequest www = UnityWebRequest.Get(root+"/"+mount);
        yield return www.SendWebRequest();

        if (www.result != UnityWebRequest.Result.Success)
        {
            Debug.Log(www.error);
            serverErrorText.SetActive(true);
            loading.SetActive(false);
        }
        else
        {
            serverErrorText.SetActive(false);
            string html = www.downloadHandler.text;

            HtmlDocument doc = new HtmlDocument();
            doc.LoadHtml(html);

            var trNodes = doc.DocumentNode.SelectNodes("/html/body/table/tbody/tr");
            
            var elements = new List<ServerData>();

            // Parse folders
            if (trNodes != null)
            {   
                foreach (var node in trNodes)
                {
                    var data = new ServerData();
                    data.Name = node.SelectSingleNode(".//a").InnerText.Trim();
                    data.URL = node.SelectSingleNode(".//a").Attributes["href"].Value.Trim();
                    data.Type = node.SelectSingleNode("./td[2]").InnerText.Trim();
                    data.Date = node.SelectSingleNode("./td[4]").InnerText.Trim();
                    data.Size = node.SelectSingleNode("./td[3]").InnerText.Trim();

                    if ((data.Name!="..")&&((Array.IndexOf(AllowedVideoFormats, data.Type) > -1) || data.Type == "Directory"))
                    {
                        elements.Add(data);
                    }
                }
                
                //Instantiate gameobjects
                CleanScreen();

                for (var i=0; i<elements.Count; i++){
                    if (elements[i].Type == "Directory"){
                        GameObject folder = instantiatePreview(elements[i].Name, i, type: 1);

                        Button button = folder.GetComponent<Button>();
                        button.name = elements[i].Name + "_Button";
                        string tempString = mount + "/" + elements[i].Name;

                        button.onClick.AddListener(() => scanFolder(tempString, button));

                    } else {
                        GameObject file = instantiatePreview(elements[i].Name, i, type: 0);
                        Button button = file.GetComponent<Button>();
                        button.name = elements[i].Name + "_Button";
                        string filePath =root+ "/"+ mount +"/" +elements[i].Name;
                        string name = elements[i].Name;
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
                    }
                }

                currentSubFolder = mount;
            }
        }
    }

    IEnumerator GetMounts()
    {
        Debug.Log("Creating mounts at root: "+ root);
        UnityWebRequest www = UnityWebRequest.Get(root+"/");
        www.timeout = 1;
        yield return www.SendWebRequest();
        mounts = new List<string>();

        if (www.result != UnityWebRequest.Result.Success)
        {
            Debug.Log(www.error);
            Debug.Log("Could not extract html from here, trying with the next one.");
            //Remove this server from the list
            ipToHostname.Remove(curIP);

            if (ipToHostname.Count >= 0){
                ScannedFinishedCallback();
            } else {
                Debug.Log("No more servers to try");
                serverErrorText.SetActive(true);
                loading.SetActive(false);
            }
        }
        else
        {
            prevIp = curIP;
            loading.SetActive(false);
            if (curIP != PlayerPrefs.GetString("serverIP", "none")  && curIP != "")
            {
                PlayerPrefs.SetString("serverIP", curIP);
            }
            
            serverErrorText.SetActive(false);
            string html = www.downloadHandler.text;

            HtmlDocument doc = new HtmlDocument();
            doc.LoadHtml(html);

            var ulNodes = doc.DocumentNode.Descendants("ul");
            foreach (var ulNode in ulNodes)
            {
                foreach (var aNode in ulNode.Descendants("a"))
                {
                    string href = aNode.GetAttributeValue("href", null);
                    if (!string.IsNullOrEmpty(href) && href != "/")
                    {
                        mounts.Add(href);
                    }
                }
            }
            currentSubFolder = "/";
            displayMounts();
        }

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
            currentVideo.edgeSens = vd.edgeSens;
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
                    if (format != 1){
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