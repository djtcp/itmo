# !/usr/bin/python3
# -*- coding: utf-8 -*-
from random import randint
count = 100
def numbers():
    randlist = []
    comparelist = []
    comparator = int(50);

    for i in range(count):
        randlist.append(randint(1,100))

    for item in randlist:
        if (item >= comparator):
            comparelist.append(str(item) + " > High")
        else:
            comparelist.append(str(item) + " < Low")

    print ("comparator = " + str(comparator))
    print("numbers:",randlist,comparelist,"\n", sep="\n")

def names():
    import re, names, numpy as np

    list1 = []
    list2 = []

    firstNames = np.array([''.join(names.get_first_name()) for _ in range(count)])

    for name in firstNames:
        if (str(name)[0] == "A"  or str(name)[0] == "M"):
            list1.append(name)

        else :
            list2.append(name)

    print("Names:", list1, list2, sep="\n")

numbers()

names()