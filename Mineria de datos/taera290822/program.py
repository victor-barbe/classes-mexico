import numpy as np
import pandas as pd

archivo=open('data2.txt','r')
text=archivo.readlines()

tab=[]
tab2=[]
for i in text:
    if i!="\n":
        tab2.append(i.split(": ")[-1][:-1])
    if "C. Exactas" in i:
        tab.append(tab2)
        tab2=[]
    
df = pd.DataFrame(tab, columns =["Nombre","Apellido","fecha_nacimiento","ciudad","trabajo","c_exactas"])
print(df)
