# !/usr/bin/python3
# -*- coding: utf-8 -*-

def listValues():
    tlv = ['-5', '1', '3', '7', '10', '13'];
    return tlv


def resultTuple(tlv):
    if (len(tlv) == 0):
        return "List is empty"

    maxvalue = []
    minvalue = []
    for value in tlv:
        if int(value) <= 0:
            maxvalue.append(value)
        else:
            minvalue.append(value)

    maxvalue.sort()
    minvalue.sort(reverse=True)

    resultTuple = (maxvalue, minvalue)
    return resultTuple


def degree():
    value = input("Enter value: \n")
    degree = input("Enter degree: \n")
    print("Result:" + str(int(value) ** int(degree)))


def degreeRecursive(value, degree):
    if (degree == 1):
        return (value)
    if (degree != 1):
        return (value * degreeRecursive(value, degree - 1))


print(resultTuple(listValues()))

degree()

value = int(input("Enter value: "))
degree = int(input("Enter degree: "))
print("Result:", degreeRecursive(value, degree))
