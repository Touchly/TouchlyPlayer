using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;
using System.Text.RegularExpressions;
using HtmlAgilityPack;
using System;

public class WebDAV : MonoBehaviour
{
    private List<string> mounts = new List<string>();
    private string[] AllowedVideoFormats = new string[] {"MKV-File", "MP4-File","WEBM-File"};
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(GetMounts());
        StartCoroutine(GetVideoInfo());
    }

    public class ServerData
    {
        public string Name { get; set; }
        public string URL { get; set; }
        public string Type { get; set; }
        public string Size { get; set; }
        public string Date { get; set; }
    }

    IEnumerator GetVideoInfo(){

        UnityWebRequest www = UnityWebRequest.Get("http://localhost:8080/mount1/");
        yield return www.SendWebRequest();

        if (www.result != UnityWebRequest.Result.Success)
        {
            Debug.Log(www.error);
        }
        else
        {
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

                    if ((Array.IndexOf(AllowedVideoFormats, data.Type) > -1) || data.Type == "Directory")
                    {
                        elements.Add(data);
                    }
                    
                }
            }
        }
    }

    IEnumerator GetMounts()
    {
        UnityWebRequest www = UnityWebRequest.Get("http://localhost:8080/");
        yield return www.SendWebRequest();

        if (www.result != UnityWebRequest.Result.Success)
        {
            Debug.Log(www.error);
        }
        else
        {
            string html = www.downloadHandler.text;

            HtmlDocument doc = new HtmlDocument();
            doc.LoadHtml(html);

            var ulNodes = doc.DocumentNode.Descendants("ul");
            foreach (var ulNode in ulNodes)
            {
                foreach (var aNode in ulNode.Descendants("a"))
                {
                    string href = aNode.GetAttributeValue("href", null);
                    if (!string.IsNullOrEmpty(href))
                    {
                        Debug.Log(href);
                        mounts.Add(href);
                    }
                }
            }
        }
    }
}