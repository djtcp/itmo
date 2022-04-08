# !/usr/bin/python3
# -*- coding: utf-8 -*-
from netmiko import Netmiko


r1 = {
"host": "192.168.55.36",
"username": "lir_admin",
"password": "39Gjgeuftd!!@@",
"device_type": "mikrotik_routeros",
}

net_connect = Netmiko(**r1)
command = "/export"
output = net_connect.send_command_timing(command)
print(output, file=open('r1_backup.txt','a'))
net_connect.disconnect()