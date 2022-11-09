import pandas as pd
import numpy as np
from matplotlib import pyplot as plt


archivo_sismos = 'iris.data'
archivo = open(archivo_sismos, mode="r")
texto_sismos = archivo.readlines()

texto=[]
for i in texto_sismos:
  text=i.replace("/'","")
  text=i.replace("\n","")
  nuevo_texto2=text.split(",")
  texto.append(nuevo_texto2)


df = pd.DataFrame(texto, columns =["Sepal_length","Sepal_width","Petal_length","Petal_width","class"])

print(df.head())



df[["Sepal_length","Sepal_width","Petal_length","Petal_width"]] = df[["Sepal_length","Sepal_width","Petal_length","Petal_width"]].apply(pd.to_numeric)

print(df[["Sepal_length","Sepal_width","Petal_length","Petal_width"]].min())


print(df[["Sepal_length","Sepal_width","Petal_length","Petal_width"]].max())


print(df[["Sepal_length","Sepal_width","Petal_length","Petal_width"]].mean())