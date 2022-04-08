# !/usr/bin/python3
# -*- coding: utf-8 -*-
label = ['cheese', 'milk', 'butter', 'eggs', 'bread', 'water', 'meat', 'cake', 'potato', 'tomato']
cost = [7.62, 8.50, 2.50, 7.2, 4.5, 2, 15.50, 8, 11, 6]
hum_id = [101, 202, 303, 404, 505, 606, 707, 808, 909, 111]
for item in zip(label , cost, hum_id):
    print(item)