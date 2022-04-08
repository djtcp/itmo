# !/usr/bin/python3
# -*- coding: utf-8 -*-
import pandas as pd
column = []
csv_input = pd.read_csv('/Users/sa/Documents/pythonProject/orderdata_sample.csv')
csv_input['Total'] = csv_input['Quantity']
for i in range(1, len(column)):
            result = column[i]
            column[i].append(float(result[3]) * float(result[4]) * float(result[5]))
csv_input.to_csv('/Users/sa/Documents/pythonProject/orderdata_sample2.csv', index=False)
