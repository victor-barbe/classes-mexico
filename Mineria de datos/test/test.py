import numpy as np
import pandas as pd
from datetime import datetime

"""
#import data
archivo=open('data.txt','r')
text=archivo.readlines()

#create 2 arrays
tab=[]
tab2=[]

#utilise data
for i in text:
    if i!="\n":
        tab2.append(i.split(": ")[-1][:-1])
    if "C. Exactas" in i:
        tab.append(tab2)
        tab2=[]
    
#load data in dataframe
df = pd.DataFrame(tab, columns =["Nombre","Apellido","fecha_nacimiento","ciudad","trabajo","c_exactas"])
print(df.head())
"""
#loading dates
df_dates = pd.read_csv("fechas.csv")
m = df_dates.loc[0].date_1
print(m)
print(type(m))
str_date0 = str(m)
data_object0 = datetime.strptime(str_date0,"%d%m%Y")
print(data_object0)

a = df_dates.loc[1].date_1
print(a)
str_date1 = str(a)
data_object1 = datetime.strptime(str_date1,"%d%m%Y")
print(data_object1)

b = df_dates.loc[0].date_2
print(b)
str_date2 = str(b)
data_object2 = datetime.strptime(str_date2,"%d/%m/%Y")
print(data_object2)

c = df_dates.loc[1].date_2
print(c)
str_date3 = str(c)
data_object3 = datetime.strptime(str_date3,"%d/%m/%Y")
print(data_object3)


d = df_dates.loc[0].date_3
print(d)
str_date4 = str(d)
data_object4 = datetime.strptime(str_date4,"%Y-%m-%d")
print(data_object4)

e = df_dates.loc[1].date_3
print(e)
str_date5 = str(e)
data_object5 = datetime.strptime(str_date5,"%Y-%m-%d")
print(data_object5)


lista_fechas = []
lista_fechas.append(data_object0)
lista_fechas.append(data_object1)
lista_fechas.append(data_object2)
lista_fechas.append(data_object3)
lista_fechas.append(data_object4)
lista_fechas.append(data_object5)

print(lista_fechas)
