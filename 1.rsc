# apr/07/2022 15:09:39 by RouterOS 7.1.3
# software id = H1PA-W4VW
#
# model = RB2011iL
# serial number = D52B0D54EF3A
/interface bridge
add comment=LAN name=br
add name=loopback
/interface ethernet
set [ find default-name=ether5 ] name=ether5-br
set [ find default-name=ether6 ] comment="ISP 109.195.86.203" name=ether6-isp
/interface list
add name=WAN
add name=LAN
/interface lte apn
set [ find default=yes ] ip-type=ipv4
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=l2tp ranges=192.168.100.100-192.168.100.200
/port
set 0 name=serial0
/ppp profile
add bridge=br change-tcp-mss=yes dns-server=192.168.55.113 local-address=\
    192.168.101.1 name=l2tp only-one=no remote-address=l2tp use-compression=\
    yes use-encryption=yes use-ipv6=no use-mpls=no use-upnp=no
add bridge=br change-tcp-mss=yes dns-server=192.168.55.113 local-address=\
    192.168.100.1 name=l2tp2 only-one=no remote-address=l2tp use-compression=\
    yes use-encryption=yes use-ipv6=no use-mpls=no use-upnp=no
/routing bgp template
set default as=65530 disabled=no name=default output.network=bgp-networks
/routing table
add fib name=""
/snmp community
set [ find default=yes ] addresses=192.168.55.165/32
/interface bridge port
add bridge=br ingress-filtering=no interface=ether1
add bridge=br ingress-filtering=no interface=ether2
add bridge=br ingress-filtering=no interface=ether3
add bridge=br ingress-filtering=no interface=ether4
add bridge=br ingress-filtering=no interface=ether5-br
/interface bridge settings
set allow-fast-path=no use-ip-firewall=yes
/ip neighbor discovery-settings
set discover-interface-list=all
/ip settings
set max-neighbor-entries=8192
/ipv6 settings
set disable-ipv6=yes max-neighbor-entries=8192
/interface l2tp-server server
set allow-fast-path=yes authentication=mschap2 default-profile=l2tp enabled=\
    yes l2tpv3-digest-hash=none use-ipsec=required
/interface list member
add interface=ether1 list=WAN
add interface=ether2 list=LAN
add interface=ether3 list=LAN
add interface=ether4 list=LAN
add interface=ether5-br list=LAN
add interface=ether6-isp list=LAN
add interface=ether7 list=LAN
add interface=ether8 list=LAN
add interface=ether9 list=LAN
add interface=ether10 list=LAN
/interface pptp-server server
set authentication=mschap2 default-profile=l2tp
/ip address
add address=192.168.55.37/24 interface=br network=192.168.55.0
add address=109.195.86.203/24 interface=ether6-isp network=109.195.86.0
/ip dns
set allow-remote-requests=yes servers=77.88.8.8,8.8.8.8,1.1.1.1
/ip firewall address-list
add address=192.168.0.0/16 list=Allow_IP_WinBox
add address=172.16.16.1 list=Allow_IP_WinBox
add address=104.248.204.200 list="block Hacker"
/ip firewall filter
add action=accept chain=input comment="Allow established,related,untracked" \
    connection-state=established,related,untracked in-interface=ether6-isp
add action=reject chain=input dst-port=22,23 in-interface=ether6-isp \
    protocol=tcp reject-with=icmp-network-unreachable
add action=drop chain=input comment="drop invald" connection-state=invalid
add action=add-src-to-address-list address-list="BAN HONEYPOT" \
    address-list-timeout=4w2d chain=input comment=\
    "block honeypot ssh rdp winbox" connection-state=new dst-port=\
    22,23,3389,8291 in-interface=ether6-isp protocol=tcp
add action=drop chain=input comment="drop DNS request ISP interface" \
    dst-port=53 in-interface=!ether6-isp protocol=udp
add action=add-src-to-address-list address-list="BAN ASTERISK" \
    address-list-timeout=4w2d chain=input comment="block ddos asterisk" \
    connection-state=new dst-port=5060 in-interface=ether6-isp protocol=udp
add action=add-src-to-address-list address-list="block Hacker" \
    address-list-timeout=none-dynamic chain=input dst-address-list=\
    "BAN ASTERISK" dst-port=22,23 in-interface=ether6-isp protocol=tcp
add action=accept chain=input in-interface=ether6-isp ipsec-policy=in,ipsec \
    protocol=ipsec-esp
add action=return chain=detect-ddos dst-limit=32,42,src-and-dst-addresses/1s
add action=accept chain=input comment="Allow VPN ports" dst-port=\
    500,1701,4500 in-interface=ether6-isp log-prefix=lt2p protocol=udp
add action=return chain=detect-ddos src-address=192.168.55.113
add action=accept chain=input comment="Allow GRE" connection-state=new \
    in-interface=ether6-isp protocol=gre
add action=accept chain=input comment="Allow ICMP" in-interface=ether6-isp \
    protocol=icmp
add action=jump chain=forward connection-state=new jump-target=detect-ddos
add action=accept chain=forward comment="Allow established,related,untracked" \
    connection-state=established,related,untracked in-interface=ether6-isp
add action=drop chain=forward comment="drop invalid" connection-state=invalid
add action=accept chain=forward comment="Allow forward to local bridge" \
    in-interface=ether6-isp out-interface=br
add action=drop chain=forward comment="drop 1C to world" disabled=yes \
    src-mac-address=B6:83:41:51:27:FD
add action=drop chain=forward comment="drop all forward" \
    connection-nat-state=!dstnat in-interface=ether6-isp log-prefix=drop_dst
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether6-isp
add action=accept chain=srcnat dst-address=192.168.56.0/24 src-address=\
    192.168.55.0/24
add action=accept chain=srcnat dst-address=192.168.55.0/24 src-address=\
    192.168.56.0/24
add action=accept chain=srcnat dst-address=192.168.57.0/24 src-address=\
    192.168.56.0/24
add action=accept chain=srcnat dst-address=192.168.56.0/24 src-address=\
    192.168.57.0/24
add action=dst-nat chain=dstnat dst-address=109.195.86.203 dst-port=1198 \
    in-interface=ether6-isp log=yes log-prefix=ovpn protocol=udp \
    to-addresses=192.168.55.251 to-ports=1198
add action=dst-nat chain=dstnat dst-address=109.195.86.203 dst-port=\
    10000-20000 in-interface=ether6-isp protocol=udp to-addresses=\
    192.168.55.26 to-ports=10000-20000
add action=dst-nat chain=dstnat disabled=yes dst-address=109.195.86.203 \
    dst-port=5060-5062,5160 in-interface=ether6-isp protocol=udp \
    to-addresses=192.168.55.26 to-ports=5060-5062
add action=dst-nat chain=dstnat disabled=yes dst-address=109.195.86.203 \
    dst-port=5060-5062 in-interface=ether6-isp protocol=tcp to-addresses=\
    192.168.55.26 to-ports=5060-5062
add action=dst-nat chain=dstnat dst-address=109.195.86.203 dst-port=4443 \
    protocol=tcp to-addresses=192.168.55.240 to-ports=443
/ip firewall raw
add action=drop chain=prerouting in-interface=ether6-isp src-address-list=\
    "block Hacker"
/ip firewall service-port
set sip ports=5060,5061,5062,5160
/ip proxy
set enabled=yes max-cache-size=none
/ip proxy access
add action=deny disabled=yes dst-port=23-25
add disabled=yes dst-port=80
add dst-address=192.168.55.251 dst-host=openvpn.itceo.ru dst-port=1198
add dst-address=192.168.55.240 dst-host=help1.itceo.ru dst-port=443
add action=deny
/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=109.195.86.1 \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
add disabled=no dst-address=192.168.10.0/24 gateway=192.168.55.36 \
    routing-table=main suppress-hw-offload=no
add disabled=no distance=1 dst-address=192.168.56.0/24 gateway=192.168.100.3 \
    pref-src="" routing-table=main scope=10 suppress-hw-offload=no \
    target-scope=10
add disabled=no distance=1 dst-address=192.168.57.0/24 gateway=192.168.101.2 \
    pref-src="" routing-table=main scope=10 suppress-hw-offload=no \
    target-scope=10
add disabled=yes distance=1 dst-address=192.168.57.0/24 gateway=192.168.100.3 \
    pref-src="" routing-table=main scope=10 suppress-hw-offload=no \
    target-scope=10
add disabled=no dst-address=192.168.52.0/24 gateway=192.168.55.251 \
    routing-table=main suppress-hw-offload=no
add disabled=no distance=1 dst-address=192.168.54.0/24 gateway=192.168.55.251 \
    pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
/ip service
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/ppp secret
add local-address=192.168.101.1 name=kurch-1stage profile=l2tp \
    remote-address=192.168.101.2 service=l2tp
add local-address=192.168.100.1 name=kurch-4stage profile=l2tp2 \
    remote-address=192.168.100.3 service=l2tp
add disabled=yes name=kurch-buh1 profile=l2tp service=l2tp
add disabled=yes name=kurch-buh2 profile=l2tp service=l2tp
/snmp
set contact=admin@itcio.ru enabled=yes location=trefoleva trap-version=2
/system clock
set time-zone-name=Europe/Moscow
/system identity
set name=GW-LIR
