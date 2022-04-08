# !/usr/bin/python3
# -*- coding: utf-8 -*-
from random import randint
cost = [randint(10, 100) for i in range(10)]
price = cost
print(cost)

for i in range(len(price)):
    price[i] += price[i] * 0.20

print(price)
