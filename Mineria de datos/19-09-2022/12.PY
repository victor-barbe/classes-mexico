import pandas as pd
import numpy as np
from matplotlib import pyplot as plt


archivo_sismos = '19-09-2022/iris.data'
archivo = open(archivo_sismos, mode="r")
texto_sismos = archivo.readlines()

texto=[]
for i in texto_sismos:
  text=i.replace("/'","")
  text=i.replace("\n","")
  nuevo_texto2=text.split(",")
  texto.append(nuevo_texto2)


df = pd.DataFrame(texto, columns =["Sepal_length","Sepal_width","Petal_length","Petal_width","class"])
print(type(df["Sepal_length"][149]))
print(len(df))

list = [1,2,3]
len_list = len(list)
value = 0
df[["Sepal_length","Sepal_width","Petal_length","Petal_width"]] = df[["Sepal_length","Sepal_width","Petal_length","Petal_width"]].apply(pd.to_numeric)

for i in list:
    if i < len(df):
        value = value + df["Sepal_length"][i] + df["Sepal_length"][i] + df["Sepal_length"][i] 
print("XD")
print(value)