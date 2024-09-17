using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.Net;
using System.Net.NetworkInformation;
using System.Threading.Tasks;
using System.Diagnostics;

public class ScanIPs : MonoBehaviour
{
    string subnet = "192.168.1";
    int start = 2;
    int end = 255;
    private Dictionary<string, string> ipToHostname = new Dictionary<string, string>();
    static object lockObj = new object();

    // Start is called before the first frame update
    void Start()
    {
        PingSubnet();
    }

    public async void PingSubnet(){
        var tasks = new List<Task>();

        for (int i = start; i < end; i++)
        {
            System.Net.NetworkInformation.Ping ping = new System.Net.NetworkInformation.Ping();
            string ip = $"{subnet}.{i}";
            var task = PingSubnetAsync(ping, ip);
        }

        int timeout=10000;
        await Task.WhenAny(Task.WhenAll(tasks), Task.Delay(timeout)).ContinueWith(t => {
            UnityEngine.Debug.Log(ipToHostname.Count);
        });
    }

    private async Task PingSubnetAsync(System.Net.NetworkInformation.Ping ping, string ip)
    {
        await Task.Run(() =>
        {
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
            else
            {
                UnityEngine.Debug.Log($"{ip}, {reply.Status}");
            }
        });
    }
}
