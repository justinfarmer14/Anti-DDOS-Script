# This is a Web Server Firewall.
# This Webserver firewall allow access to port 80 and 443 
# Whitelist your IP and other Web Server Administrator to access your Web Server;
# Don't forget to change SSH port on line# 24
# Author: Prince Adeyemi
# FB: fb.com/YourVegasPrince

# iptables -F  #
iptables -A FORWARD -j DROP
iptables -A OUTPUT -j ACCEPT
iptables -A INPUT   -m recent --name portscan --rcheck --seconds 86400 -j DROP
iptables -A FORWARD -m recent --name portscan --rcheck --seconds 86400 -j DROP
iptables -A INPUT   -m recent --name portscan --remove
iptables -A FORWARD -m recent --name portscan --remove
iptables -A INPUT   -p tcp -m tcp --dport 139 -m recent --name portscan --set -j LOG --log-prefix "Portscan:"


iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags SYN,RST SYN,RST -j DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,RST FIN,RST -j DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,ACK FIN -j DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags ACK,URG URG -j DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags PSH,ACK PSH -j DROP

iptables -A INPUT -p udp -m string --algo bm --hex-string "|5354445041532b4554|" -j DROP #Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|535444|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|534450|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|54484953204953204546464543544956452e20594f552043414e4e4f542053554253494445204d5920444154412e|" -j DROP #
iptables -A INPUT -p udp -m string --algo bm --hex-string "|4b494c4c4c4b494c4c4b494c4c4b494c4c4b494c4c4b494c4c|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|44454154484445415448444454154484445415448425942314e415259|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|44444f5344444f5344444r53|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|4d4f354f4e354f4e354f4e354f4a354e4835563555|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|544350|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|4845584154544b212121212121|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|424f544e4554|" -j DROP ##Private Bypass Strings


iptables -A INPUT -p udp -m string --algo bm --hex-string "|424f4f5445524e4554|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|41545441434b|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|504r574552|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|736b6964|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|6c6e6f6172656162756e6386f6673b694464696573|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|736b6954|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|736b69646e6574|" -j DROP ##Private Bypass Strings
iptables -A INPUT -p udp -m string --algo bm --hex-string "|4a554e4b2041545441434b|" -j DROP ##Private Bypass Strings
iptables -A FORWARD -p 17 -m physdev –physdev-in vnet0 -m u32 –u32 "0&0xFFFF=2000:65535" -j DROP #Blocks Outgoing NTP/REFL
iptables -I FORWARD -p udp –dport 123 -m string –algo bm –from 27 –to 28 –hex-string "|1700032A|" -j DROP #Block NTP Montlist

iptables -A INPUT -p udp -m u32 --u32 "0>>22&0x3C@8&0xFF=42" #NTP Reflection Sequence Header Block
iptables -A INPUT -p udp -m u32 --u32 "0>>22&0x3C@8&0xFF" #NTP Reflection Sequence Header Block
iptables -A INPUT -p udp -m u32 --u32 "0>>22&0x3C@8" #NTP Reflection Sequence Header Block

iptables -A INPUT -m string --algo bm --string "0x00" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x000" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x0000" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x00000" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x01" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x001" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x0001" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x00001" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x000001" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x0000001" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x00000001" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x000000001" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x0000000001" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x00000000001" -j DROP 
iptables -A INPUT -m string --algo bm --string "0x000000000001" -j DROP


echo "stresser bypass patch"

iptables -t raw -A PREROUTING -p udp -m length --length 65535 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-65535 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 60000 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-60000 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 30000 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-30000 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 10000 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-10000 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 4096 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-4096 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 1052 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-1052 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 1000 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-1052 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 912 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-912 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 540 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-540 packets/3
iptables -t raw -A PREROUTING -p udp -m length --length 55 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-55 packets/1
iptables -t raw -A PREROUTING -p udp -m length --length 38 -j DROP #Malicious Botnet-UDP Payload / UDP flood/37
iptables -A PREROUTING -p udp -m length --length 0:28 -j DROP #Dropping Empty UDP Packets / Deemed Illegitimate Packets
iptables -A INPUT -p udp -m u32 --u32 "2&0xFFFF=0x2:0x0100" #Generic-UDP-Header-Sequence
iptables -A INPUT -p udp -m u32 --u32 "12&0xFFFFFF00=0xC0A80F00" -j DROP #Katura-UDP-Payload
iptables -A INPUT -p tcp -syn -m length --length 52 u32 --u32 "12&0xFFFFFF00=0xc838" -j DROP #Mikey-Shit-TCP
iptables -A INPUT -p udp -m length --length 28 -m string --algo bm --string "0x0010" -j DROP #Botnet UDP
iptables -A INPUT -p udp -m length --length 28 -m string --algo bm --string "0x0000" -j DROP #Botnet UDP
iptables -A INPUT -p tcp -m length --length 40 -m string --algo bm --string "0x0020" -j DROP #Botnet TCP
iptables -A INPUT -p tcp -m length --length 40 -m string --algo bm --string "0x0c54" -j DROP #Botnet TCP
iptables -A INPUT -p tcp -m length --length 40 -m string --algo bm --string "0x38d3" -j DROP #Botnet TCP
iptables -A INPUT -p tcp -ack -m length --length 52 -m string --algo bm --string "0x912e" -m state --state ESTABLISHED  -j DROP #Yubina-Kill-ACK
iptables -A INPUT -p tcp -syn -m length --length 52 -m string --algo bm --string "0xc838" -m state --state ESTABLISHED  -j DROP













iptables -A INPUT -m string --algo bm --string "0x00" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000" -j DROP
iptables -A INPUT -m string --algo bm --string "0x0000" -j DROP
iptables -A INPUT -m string --algo bm --string "0x00000" -j DROP
iptables -A INPUT -m string --algo bm --string "0x01" -j DROP
iptables -A INPUT -m string --algo bm --string "0x001" -j DROP
iptables -A INPUT -m string --algo bm --string "0x0001" -j DROP
iptables -A INPUT -m string --algo bm --string "0x00001" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000001" -j DROP
iptables -A INPUT -m string --algo bm --string "0x0000001" -j DROP
iptables -A INPUT -m string --algo bm --string "0x00000001" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000000001" -j DROP
iptables -A INPUT -m string --algo bm --string "0x0000000001" -j DROP
iptables -A INPUT -m string --algo bm --string "0x00000000001" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000000000001" -j DROP  
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF0" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF00" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF000" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF0000" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF00000" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF000000" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF0000000" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF00000000" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF000000000" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF0000000000" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF00000000000" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF000000000000" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF0000000000000" -j DROP
 
 
 
iptables -A INPUT -m string --algo bm --string "0xFA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAAA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAAAA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAAAAA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAAAAAA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAAA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAAAA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAAAAA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAAAAAA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAAAAAAA" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAAAAAAAA" -j DROP
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFFFFFFFF" -j DROP
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF1" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1F" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFFFFFFFF" -j DROP
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF2" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2F" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFFFFFFFF" -j DROP
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF3" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3F" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFFFFFFFF" -j DROP
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF4" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4F" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFFFFFFFF" -j DROP
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF5" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5F" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFFFFFFFF" -j DROP
 
 
 
iptables -A INPUT -m string --algo bm --string "0xfe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xfffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xffffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xfffffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xffffffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xfffffffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xffffffffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xffffffffffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xfffffffffffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xffffffffffffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xfffffffffffffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xffffffffffffffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xfffffffffffffffe" -j DROP
iptables -A INPUT -m string --algo bm --string "0xffffffffffffffffe" -j DROP
 
 
 
iptables -A INPUT -m string --algo bm --string "0x000F" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFFFFFFF" -j DROP
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFFFFFFFF" -j DROP
 
 
 
iptables -A INPUT -m string --algo bm --string "0x00" -j DROP #BSSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000" -j DROP #BSSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x0000" -j DROP #BSSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x00000" -j DROP #BSSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x01" -j DROP #BSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x001" -j DROP #BSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x0001" -j DROP #BSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x00001" -j DROP #BSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000001" -j DROP #BSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x0000001" -j DROP #BSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x00000001" -j DROP #BSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000000001" -j DROP #BSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x0000000001" -j DROP #BSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x00000000001" -j DROP #BSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000000000001" -j DROP #BSTD Bypass Strings
 
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF0" -j DROP #NSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF00" -j DROP #NSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF000" -j DROP #NSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF0000" -j DROP #NSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF00000" -j DROP #NSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF000000" -j DROP #NSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF0000000" -j DROP #NSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF00000000" -j DROP #NSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF000000000" -j DROP #NSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF0000000000" -j DROP #NSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF00000000000" -j DROP #NSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF000000000000" -j DROP #NSTD Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF0000000000000" -j DROP #NSTD Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "0xFA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFAAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFFFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFFFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFFFFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFFFFFFF" -j DROP #Crunch Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xFFFFFFFFFFFFFFFF" -j DROP #Crunch Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF1" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1F" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FF" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FFF" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FFFF" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FFFFF" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFF" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFF" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFF" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFFF" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFFFF" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFFFFF" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFFFFFF" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFFFFFFF" -j DROP #0xF1 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF1FFFFFFFFFFFFFF" -j DROP #0xF1 Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF2" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2F" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FF" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FFF" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FFFF" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FFFFF" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFF" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFF" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFF" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFFF" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFFFF" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFFFFF" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFFFFFF" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFFFFFFF" -j DROP #0xF2 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF2FFFFFFFFFFFFFF" -j DROP #0xF2 Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF3" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3F" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FF" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FFF" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FFFF" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FFFFF" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFF" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFF" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFF" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFFF" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFFFF" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFFFFF" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFFFFFF" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFFFFFFF" -j DROP #0xF3 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF3FFFFFFFFFFFFFF" -j DROP #0xF3 Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF4" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4F" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FF" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FFF" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FFFF" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FFFFF" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFF" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFF" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFF" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFFF" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFFFF" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFFFFF" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFFFFFF" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFFFFFFF" -j DROP #0xF4 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF4FFFFFFFFFFFFFF" -j DROP #0xF4 Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "0xF5" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5F" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FF" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FFF" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FFFF" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FFFFF" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFF" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFF" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFF" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFFF" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFFFF" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFFFFF" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFFFFFF" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFFFFFFF" -j DROP #0xF5 Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xF5FFFFFFFFFFFFFF" -j DROP #0xF5 Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "0xfe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xfffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xffffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xfffffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xffffffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xfffffffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xffffffffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xffffffffffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xfffffffffffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xffffffffffffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xfffffffffffffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xffffffffffffffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xfffffffffffffffe" -j DROP #OVH-Dropper Bypass Strings
iptables -A INPUT -m string --algo bm --string "0xffffffffffffffffe" -j DROP #OVH-Dropper Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "0x000F" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFFFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFFFFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFFFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFFFFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFFFFFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFFFFFFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000FFFFFFFFFFFFFFF" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x0f" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x00f" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000f" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000ff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000fff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000ffff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000fffff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000ffffff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000fffffff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000ffffffff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000fffffffff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000ffffffffff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000fffffffffff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000ffffffffffff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000fffffffffffff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000ffffffffffffff" -j DROP #IPsLap Bypass Strings
iptables -A INPUT -m string --algo bm --string "0x000fffffffffffffff" -j DROP #IPsLap Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "1xFA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "1xFAAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "2xFA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "2xFAAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "3xFA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "3xFAAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "4xFA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "4xFAAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "5xFA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5xFAAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "6xFA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "6xFAAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "7xFA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "7xFAAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "8xFA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "8xFAAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "9xFA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "9xFAAAAAAAAAAAAAA" -j DROP #SAAM Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "flood" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood1" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood11" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood1111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood11111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood111111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood1111111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood11111111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood111111111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood1111111111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood11111111111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood111111111111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood1111111111111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood11111111111111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood111111111111111" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood1111111111111111" -j DROP #Flood Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "flood" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood2" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood22" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood2222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood22222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood222222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood2222222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood22222222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood222222222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood2222222222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood22222222222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood222222222222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood2222222222222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood22222222222222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood222222222222222" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood2222222222222222" -j DROP #Flood Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "flood" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood3" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood33" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood3333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood33333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood333333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood3333333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood33333333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood333333333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood3333333333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood33333333333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood333333333333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood3333333333333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood33333333333333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood333333333333333" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood3333333333333333" -j DROP #Flood Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "flood" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood4" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood44" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood4444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood44444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood444444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood4444444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood44444444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood444444444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood4444444444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood44444444444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood444444444444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood4444444444444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood44444444444444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood444444444444444" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood4444444444444444" -j DROP #Flood Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "flood" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood5" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood55" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood5555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood55555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood555555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood5555555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood55555555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood555555555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood5555555555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood55555555555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood555555555555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood5555555555555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood55555555555555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood555555555555555" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood5555555555555555" -j DROP #Flood Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "flood" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood6" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood66" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood6666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood66666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood666666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood6666666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood66666666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood666666666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood6666666666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood66666666666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood666666666666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood6666666666666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood66666666666666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood666666666666666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood6666666666666666" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood7" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood77" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood7777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood77777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood777777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood7777777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood77777777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood777777777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood7777777777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood77777777777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood777777777777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood7777777777777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood77777777777777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood777777777777777" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood7777777777777777" -j DROP #Flood Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "flood" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood8" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood88" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood8888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood88888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood888888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood8888888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood88888888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood888888888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood8888888888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood88888888888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood888888888888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood8888888888888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood88888888888888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood888888888888888" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood8888888888888888" -j DROP #Flood Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "flood" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood9" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood99" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood9999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood99999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood999999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood9999999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood99999999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood999999999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood9999999999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood99999999999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood999999999999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood9999999999999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood99999999999999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood999999999999999" -j DROP #Flood Bypass Strings
iptables -A INPUT -m string --algo bm --string "flood9999999999999999" -j DROP #Flood Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "SAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAAAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAAAAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAAAAAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAAAAAAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAAAAAAAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAAAAAAAAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAAAAAAAAAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAAAAAAAAAAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAAAAAAAAAAAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAAAAAAAAAAAAM" -j DROP #SAAM Bypass Strings
iptables -A INPUT -m string --algo bm --string "SAAAAAAAAAAAAAAM" -j DROP #SAAM Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "5M" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AM" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAM" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAM" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAM" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAM" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAM" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAM" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAM" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAM" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAM" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAAM" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAAAM" -j DROP #5AM Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAAAAM" -j DROP #5AM Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "5M" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AT" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAT" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAT" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAT" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAT" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAT" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAT" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAT" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAT" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAT" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAAT" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAAAT" -j DROP #5AT Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAAAAT" -j DROP #5AT Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "5M" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AF" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAF" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAF" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAF" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAF" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAF" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAF" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAF" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAF" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAF" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAAF" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAAAF" -j DROP #5AF Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAAAAF" -j DROP #5AF Bypass Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "5M" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AP" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAP" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAP" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAP" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAP" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAP" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAP" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAP" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAP" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAP" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAAP" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAAAP" -j DROP #5AP Bypass Strings
iptables -A INPUT -m string --algo bm --string "5AAAAAAAAAAAAAP" -j DROP #5AP Bypass Strings
 
 
 
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
echo "Alpha Numratic Patches"
 
iptables -A INPUT -m string --algo bm --string "1" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "12" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "123" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "1234" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "12345" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "123456" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "1234567" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "12345678" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "123456789" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "12345678910" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "1234567891011" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "123456789101112" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "12345678910111213" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "1234567891011121314" -j DROP #Numerical Strings
iptables -A INPUT -m string --algo bm --string "123456789101112131415" -j DROP #Numerical Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "0A" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "1A" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "2A" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "3A" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "4A" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "5A" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "6A" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "7A" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "8A" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "9A" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "0AA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "1AA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "2AA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "3AA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "4AA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "5AA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "6AA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "7AA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "8AA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "9AA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "0AAA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "1AAA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "2AAA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "3AAA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "4AAA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "5AAA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "6AAA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "7AAA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "8AAA" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "9AAA" -j DROP #Alpha/Numerical Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "CRI" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "STD" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "std" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "SAAM" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "ddos" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "DDOS" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "Ddos" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "DDoS" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "ddoS" -j DROP #Alpha/Numerical Strings
iptables -A INPUT -m string --algo bm --string "udpflood" -j DROP #Alpha/Numerical Strings
 
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
echo "Botnet Attack Filters"
 
iptables -t raw -A PREROUTING -p udp -m length --length 65535 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-65535 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 60000 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-60000 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 30000 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-30000 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 10000 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-10000 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 4096 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-4096 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 1052 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-1052 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 1000 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-1052 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 912 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-912 packets/4
iptables -t raw -A PREROUTING -p udp -m length --length 540 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-540 packets/3
iptables -t raw -A PREROUTING -p udp -m length --length 55 -j DROP #Malicious Botnet-UDP Payload / a UDP flood of length-55 packets/1
iptables -t raw -A PREROUTING -p udp -m length --length 38 -j DROP #Malicious Botnet-UDP Payload / UDP flood/37
iptables -A PREROUTING -p udp -m length --length 0:28 -j DROP #Dropping Empty UDP Packets / Deemed Illegitimate Packets
iptables -A INPUT -p udp -m u32 --u32 "2&0xFFFF=0x2:0x0100" #Generic-UDP-Header-Sequence
iptables -A INPUT -p udp -m u32 --u32 "12&0xFFFFFF00=0xC0A80F00" -j DROP #Katura-UDP-Payload
iptables -A INPUT -p tcp -syn -m length --length 52 u32 --u32 "12&0xFFFFFF00=0xc838" -j DROP #Mikey-Shit-TCP
iptables -A INPUT -p udp -m length --length 28 -m string --algo bm --string "0x0010" -j DROP #Botnet UDP
iptables -A INPUT -p udp -m length --length 28 -m string --algo bm --string "0x0000" -j DROP #Botnet UDP
iptables -A INPUT -p tcp -m length --length 40 -m string --algo bm --string "0x0020" -j DROP #Botnet TCP
iptables -A INPUT -p tcp -m length --length 40 -m string --algo bm --string "0x0c54" -j DROP #Botnet TCP
iptables -A INPUT -p tcp -m length --length 40 -m string --algo bm --string "0x38d3" -j DROP #Botnet TCP
iptables -A INPUT -p tcp -ack -m length --length 52 -m string --algo bm --string "0x912e" -m state --state ESTABLISHED  -j DROP #Yubina-Kill-ACK
iptables -A INPUT -p tcp -syn -m length --length 52 -m string --algo bm --string "0xc838" -m state --state ESTABLISHED  -j DROP
 
 
#Reckless-Mikey-Shit-TCp
iptables -A INPUT -p tcp -rst -m length --length 40 -m string --algo bm --string "0xd3da" -m state --state ESTABLISHED  -j DROP #Yubina-RST
iptables -A INPUT -p tcp -ack -m length --length 40 -m string --algo bm --string "0x0c54" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -rst -m length --length 40 -m string --algo bm --string "0x0c54" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -syn -m length --length 40 -m string --algo bm --string "0x0c54" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -fin -m length --length 40 -m string --algo bm --string "0x0c54" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -psh -m length --length 40 -m string --algo bm --string "0x0c54" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -ack -m length --length 40 -m string --algo bm --string "0x38d3" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -rst -m length --length 40 -m string --algo bm --string "0x38d3" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -syn -m length --length 40 -m string --algo bm --string "0x38d3" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -fin -m length --length 40 -m string --algo bm --string "0x38d3" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -psh -m length --length 40 -m string --algo bm --string "0x38d3" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -ack -m length --length 40 -m string --algo bm --string "0x0c54" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -rst -m length --length 40 -m string --algo bm --string "0x0c54" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -syn -m length --length 40 -m string --algo bm --string "0x0c54" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -fin -m length --length 40 -m string --algo bm --string "0x0c54" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -psh -m length --length 40 -m string --algo bm --string "0x0c54" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -ack -m length --length 40 -m string --algo bm --string "0xd3da" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -rst -m length --length 40 -m string --algo bm --string "0xd3da" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -syn -m length --length 40 -m string --algo bm --string "0xd3da" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -fin -m length --length 40 -m string --algo bm --string "0xd3da" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -psh -m length --length 40 -m string --algo bm --string "0xd3da" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -ack -m length --length 40 -m string --algo bm --string "0x912e" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -rst -m length --length 40 -m string --algo bm --string "0x912e" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -syn -m length --length 40 -m string --algo bm --string "0x912e" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -fin -m length --length 40 -m string --algo bm --string "0x912e" -m state --state ESTABLISHED  -j DROP #Random-TCP
iptables -A INPUT -p tcp -psh -m length --length 40 -m string --algo bm --string "0x912e" -m state --state ESTABLISHED  -j DROP #Random-TCP
 
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
echo "Long-INT"
 
iptables -A INPUT -m string --algo bm --string "" -j DROP #Empty Long IT/STR/PL
iptables -A INPUT -m string --algo bm --string "U" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
iptables -A INPUT -m string --algo bm --string "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" -j DROP #SAO-UDP Strings
 
 
 
iptables -A INPUT -m string --algo bm --string "\x77" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09\xF7\xC7" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09\xF7\xC7\xC0\xE6" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09\xF7\xC7\xC0\xE6\xF5\x9B" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09\xF7\xC7\xC0\xE6\xF5\x9B\xDC\x23" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09\xF7\xC7\xC0\xE6\xF5\x9B\xDC\x23\x6E\x12" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09\xF7\xC7\xC0\xE6\xF5\x9B\xDC\x23\x6E\x12\x29\x25" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09\xF7\xC7\xC0\xE6\xF5\x9B\xDC\x23\x6E\x12\x29\x25\x1D\x0A" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09\xF7\xC7\xC0\xE6\xF5\x9B\xDC\x23\x6E\x12\x29\x25\x1D\x0A\xEF\xFB" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09\xF7\xC7\xC0\xE6\xF5\x9B\xDC\x23\x6E\x12\x29\x25\x1D\x0A\xEF\xFB\xDE\xB6" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09\xF7\xC7\xC0\xE6\xF5\x9B\xDC\x23\x6E\x12\x29\x25\x1D\x0A\xEF\xFB\xDE\xB6\xB1\x94" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09\xF7\xC7\xC0\xE6\xF5\x9B\xDC\x23\x6E\x12\x29\x25\x1D\x0A\xEF\xFB\xDE\xB6\xB1\x94\xD6" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -m string --algo bm --string "\x77\x47\x5E\x27\x7A\x4E\x09\xF7\xC7\xC0\xE6\xF5\x9B\xDC\x23\x6E\x12\x29\x25\x1D\x0A\xEF\xFB\xDE\xB6\xB1\x94\xD6\x7A\x6B" -j DROP #OVH-SMACK Bypass Strings/
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT ! -i lo -d 127.0.0.0/8 -j DROP
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport http -j ACCEPT
iptables -A INPUT -p tcp --dport https -j ACCEPT

iptables -N specialips
iptables -A specialips -s xxx.xxx.xxx.xxx -j RETURN  # a trusted IP Address
iptables -A specialips -s yyy.yyy.yyy.yyy -j RETURN  # another trusted IP Address
iptables -A specialips -j DROP

iptables -A INPUT -j specialips
iptables -A INPUT -p tcp --dport 2200 -j ACCEPT           # change this port to your prefer SSH port.
iptables -A INPUT -j DROP

iptables-save > /etc/iptables.rules
