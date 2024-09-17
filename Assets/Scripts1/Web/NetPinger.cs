using System.Collections;
using System.Collections.Generic;
using System;
using System.Diagnostics;
using System.Net;
using System.Net.NetworkInformation;
using System.Threading.Tasks;
//using UnityEngine;
namespace MultiThreadedPing
{
    public class NetPinger
    {
        public string BaseIP = "192.168.0.";
        public int StartIP = 2;
        public int StopIP = 255;
        public string ip;
        public int timeout = 100;
        public int nFound = 0;

        static object lockObj = new object();
        Stopwatch sw = new Stopwatch();
        public TimeSpan ts;

        public event EventHandler<string> PingEvent;
        public IPHostEntry host;
        public List<HostData> hosts = new List<HostData>();

        public async void RunPingSweep_Async(){
            var tasks = new List<Task>();

            sw.Restart();
            nFound = 0;

            for (int i = StartIP; i <= StopIP; i++)
            {
                ip = BaseIP + i.ToString();
                Ping p = new Ping();
                var task = PingAndUpdateAsync(p, ip);
                tasks.Add(task);
            }
            await Task.WhenAll(tasks).ContinueWith(t => {
                sw.Stop();
                ts = sw.Elapsed;
            });

            PingEvent?.Invoke(this, ts.ToString());
        }

        private async Task PingAndUpdateAsync(Ping p, string ip)
        {
            var reply = await p.SendPingAsync(ip, timeout).ConfigureAwait(false);
            if (reply.Status == IPStatus.Success)
            {
                host = Dns.GetHostEntry(ip);
                hosts.Add(new HostData(host,ip));
                lock (lockObj)
                {
                    nFound++;
                }
            }
        }

    }
}

