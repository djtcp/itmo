# !/usr/bin/python3
# -*- coding: utf-8 -*-
# Задание 3

from routeros_ssh_connector import MikrotikDevice
router = MikrotikDevice()
router.connect("192.168.55.37", "lir_admin", "39Gjgeuftd!!@@")
router.send_command('/export file=1')
print(router.get_export_configuration())
print(router.download_file("1.rsc",'/Users/sa/Documents/pythonProject'))
router.disconnect()

del router
router = MikrotikDevice()
router.connect("192.168.55.36", "lir_admin", "39Gjgeuftd!!@@")
router.send_command('/export file=2')
print(router.get_export_configuration())
print(router.download_file("2.rsc",'/Users/sa/Documents/pythonProject'))
router.disconnect()
del router
