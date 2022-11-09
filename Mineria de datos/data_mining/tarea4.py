
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from datetime import date

"""
Ejercicio 1
"""
print("Ejercicio 1")
archivo=open('SSNMX_catalogo_19800101_20220908_m40_100_TAREA_4.txt','r')
text=archivo.readlines()

tab=[]
tab2=[]
for i in text:
    if i!="\n":
        #we use [:-1] to get rid of the "\n" at the end of the lines
        tab2.append(i[:-1])

#remove the first lines
for i in range(6):
    tab2.pop(0)


#remove the last lines
el_to_remove = []
for i in range(1,8):
    el_to_remove.append(tab2[-i])

for i in range(7):
    tab2.remove(el_to_remove[i])


value2 = []

for i in tab2:
    #tab.append(i.split(","))
    value2.append(i.split(","))

#creating a dataframe with an extra column and deliting it to get the correct form
df = pd.DataFrame(value2, columns =["Fecha","Hora","Magnitud","Latitud","Longitud","Profundidad","Referencia de localizacion","extra_column","Fecha UTC","Hora UTC","Estatus"])
df['Referencia de localizacion'] = df[['Referencia de localizacion', 'extra_column']].apply(','.join, axis=1)
df = df.drop('extra_column', axis=1)

#printing the dataframe
print(df)


"""
Ejercicio 2
"""
print("\nEjercicio 2")
#change Magnitud column from string to numeric type
df['Magnitud'] = pd.to_numeric(df['Magnitud'])
print(df.nlargest(n=10, columns=['Magnitud']))


"""
Ejercicio 3
"""
print("\nEjercicio 3")
#change Fecha column from string to date type
df['Fecha'] = pd.to_datetime(df['Fecha'])

#obtener el promedio de la magnitud por año
dm= df.groupby(df['Fecha'].dt.year)['Magnitud'].mean()
print(dm)

#graficar los promdeios
dm.plot(kind='bar', figsize=(10,3), title='Promedio de magnitud sísmica por año', color='magenta')
plt.show()


"""
Ejercicio 4
"""
print("\nEjercicio 4")
#hacemos un groupby de los meses de toda la columna fechas y graficamos
df["Fecha"] = df["Fecha"].astype("datetime64")
df.groupby(df["Fecha"].dt.month)["Fecha"].count().plot(kind="bar")
print("Como se puede ver en el histograma el mes 9, septiembre, es el mes en el cual ocurren la mayor cantidad de temblores")


"""
Ejercicio 5
"""
# Modificación del tipo de dato de las columnas de Latitud y Longitud
df['Longitud'] = df['Longitud'].astype(float)
df['Latitud'] = df['Latitud'].astype(float)

# Sismos desde 1980
sismos= df[df['Fecha'].dt.year>=1980][['Magnitud','Longitud','Latitud']]

# Separación de sismos en dos categorías (verde y rojo)
green = sismos[sismos['Magnitud']<5.0][['Latitud','Longitud']]
red = sismos[sismos['Magnitud']>=5.0][['Latitud','Longitud']]

# Gráfica de dispersión
plt.figure(figsize=(10,8))
plt.title("Sismos en México desde 1980")
plt.xlabel("Longitud")
plt.ylabel("Latitud")
plt.scatter(green['Longitud'], green['Latitud'], color='green', marker='.', linestyle='None', label='Magnitud < 5.0')
plt.scatter(red['Longitud'], red['Latitud'], color='red', marker='*', linestyle='None', label='Magnitud ≥ 5.0')
plt.legend()    
plt.show()


"""
Ejercicio 6
"""
# Sismos de solo el 2021
sismos_2021 = df[df['Fecha'].dt.year == 2021][['Magnitud','Longitud','Latitud']]

# Separación de sismos en dos categorías (verde y rojo)
green = sismos_2021[sismos_2021['Magnitud']<5.0][['Latitud','Longitud']]
red = sismos_2021[sismos_2021['Magnitud']>=5.0][['Latitud','Longitud']]

# Gráfica de dispersión
plt.figure(figsize=(10,8))
plt.title("Sismos en México durante el año 2021")
plt.xlabel("Longitud")
plt.ylabel("Latitud")
plt.scatter(green['Longitud'], green['Latitud'], color='green', marker='.', linestyle='None', label='Magnitud < 5.0')
plt.scatter(red['Longitud'], red['Latitud'], color='red', marker='*', linestyle='None', label='Magnitud ≥ 5.0')
plt.legend()    
plt.show()


"""
Ejercicio 7.
"""
print("\nEjercicio 7")
# Magnitud de sismos posteriores al 11/03/2020
sismos_covid = df[df['Fecha'].dt.date >= date(2020,3,11)]['Magnitud']

print('Sismos durante el periodo del COVID:', (sismos_covid >= 4.0).sum())
