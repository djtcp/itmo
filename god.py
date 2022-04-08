#!/usr/bin/python3
# -*- coding: utf-8 -*-
def year_is(year):
    if (year % 4 == 0 and year % 100 != 0) or year % 400 == 0:
        return "високосный"
    else:
        return "не високосный"
 
year = int(input("введите год :"))
print(year_is(year))