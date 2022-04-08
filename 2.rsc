# apr/07/2022 15:11:56 by RouterOS 7.1.3
# software id = KGCL-N9VD
#
/interface ethernet
set [ find default-name=ether1 ] name=ether-ISP
set [ find default-name=ether3 ] comment=10/24 name=ether10
set [ find default-name=ether2 ] comment=55/24 name=ether55
/interface list
add name=WAN
add name=LAN
/interface lte apn
set [ find default=yes ] ip-type=ipv4
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/port
set 0 name=serial0
/snmp community
set [ find default=yes ] addresses=192.168.55.165/32
/interface bridge port
add ingress-filtering=no interface=ether10
/ip settings
set max-neighbor-entries=8192
/ipv6 settings
set disable-ipv6=yes max-neighbor-entries=8192
/interface list member
add interface=ether55 list=WAN
add list=LAN
/ip address
add address=109.195.81.141/25 interface=ether-ISP network=109.195.81.128
add address=192.168.55.36/24 interface=ether55 network=192.168.55.0
add address=192.168.10.37/24 interface=ether10 network=192.168.10.0
/ip cloud
set update-time=no
/ip dns
set allow-remote-requests=yes servers=77.88.8.8,1.1.1.1,8.8.8.8
/ip dns static
add address=192.168.55.59 name=sd.it-1.ru
/ip firewall filter
add action=accept chain=input connection-state=established,related,untracked \
    in-interface=ether-ISP
add action=drop chain=input dst-port=22,23 in-interface=ether-ISP protocol=\
    tcp
add action=drop chain=input connection-state=invalid in-interface=ether-ISP
add action=accept chain=input in-interface=ether-ISP protocol=icmp
add action=accept chain=input dst-port=8080 in-interface=ether-ISP protocol=\
    tcp
add action=accept chain=forward connection-state=\
    established,related,untracked in-interface=ether-ISP
add action=drop chain=forward connection-state=invalid in-interface=ether-ISP
add action=accept chain=forward connection-nat-state=dstnat dst-port=80 \
    in-interface=ether-ISP out-interface=ether10 protocol=tcp
add action=accept chain=forward connection-nat-state=dstnat in-interface=\
    ether-ISP out-interface=ether10
add action=drop chain=forward comment="Disable lookup up 10 to 55" disabled=\
    yes dst-address=192.168.10.0/24 out-interface=ether10 src-address=\
    192.168.55.0/24
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether-ISP
add action=dst-nat chain=dstnat comment=BT_RDP dst-address=109.195.81.141 \
    dst-port=33389 in-interface=ether-ISP protocol=tcp to-addresses=\
    192.168.10.102 to-ports=3389
add action=dst-nat chain=dstnat comment=BT_RDP dst-address=109.195.81.141 \
    dst-port=33390 in-interface=ether-ISP protocol=tcp to-addresses=\
    192.168.10.103 to-ports=3389
add action=dst-nat chain=dstnat comment=BT_http dst-address=109.195.81.141 \
    dst-port=80 in-interface=ether-ISP protocol=tcp to-addresses=\
    192.168.10.102 to-ports=80
add action=dst-nat chain=dstnat comment=WS-PC-01 dst-address=109.195.81.141 \
    dst-port=33391 in-interface=ether-ISP protocol=tcp to-addresses=\
    192.168.10.105 to-ports=3389
add action=dst-nat chain=dstnat comment=nko dst-address=109.195.81.141 \
    dst-port=20001 in-interface=ether-ISP protocol=tcp to-addresses=\
    192.168.10.80 to-ports=2000
add action=dst-nat chain=dstnat comment=nko dst-address=109.195.81.141 \
    dst-port=20002 in-interface=ether-ISP protocol=tcp to-addresses=\
    192.168.10.81 to-ports=2000
add action=dst-nat chain=dstnat comment=nko dst-address=109.195.81.141 \
    dst-port=20003 in-interface=ether-ISP protocol=tcp to-addresses=\
    192.168.10.82 to-ports=2000
add action=dst-nat chain=dstnat comment=nko dst-address=109.195.81.141 \
    dst-port=20004 in-interface=ether-ISP protocol=tcp to-addresses=\
    192.168.10.83 to-ports=2000
add action=dst-nat chain=dstnat comment=ubuntusalescript dst-address=\
    109.195.81.141 dst-port=2000 in-interface=ether-ISP protocol=tcp \
    to-addresses=192.168.10.219 to-ports=2000
add action=dst-nat chain=dstnat dst-address=109.195.81.141 dst-port=8080 \
    in-interface=ether-ISP protocol=tcp to-addresses=192.168.55.59 to-ports=\
    8080
/ip proxy
set max-cache-object-size=4096KiB
/ip proxy access
add dst-host=192.168.55.59 dst-port=8080
/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=109.195.81.254
/ip service
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/routing rule
add action=drop disabled=yes dst-address=192.168.55.0/24 interface=ether10 \
    src-address=192.168.10.0/24
/snmp
set contact=admin@itcio.ru enabled=yes location=trefoleva trap-version=2
/system identity
set name=GW-BT
