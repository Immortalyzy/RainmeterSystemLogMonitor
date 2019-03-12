# !/usr/bin/python3

import pymongo
import os
import json

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["auto"]
mycol = mydb["suv"]
root = "F:\Autohome\wom_suv"  # 开始遍历
i = 1
for dirpath, dirname, filenames in os.walk(root):
    for filepath in filenames:
        i = i + 1
        if(i % 100 == 0):
            print(i)
        names = os.path.join(dirpath, filepath)
        with open(names, 'r', encoding='UTF-8') as f:
            file_data = json.load(f)
        mycol.insert(file_data)

myclient.close()
