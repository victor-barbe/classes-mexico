import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

"""
valores_x=np.arange(0.1,100,0.1)
valores_y=np.log(valores_x)
fig=plt.figure(figsize=(12,6))
plt.plot(valores_x,valores_y)
plt.show()
fig.savefig('logaritmo.pdf',format='pdf',dpi=1200)    
"""
df_apoyo=pd.read_csv("mujeres-afiliadas-programa-apoyo-productivo-mujer-poblana-20180228.csv")

"""
print(df_apoyo[['Municipio','Edad']])
print ("Edad promedio: ",np.mean(df_apoyo["Edad"]))
print ("Edad promedio: ",np.max(df_apoyo["Edad"]))
print ("Edad minina: ",np.min(df_apoyo["Edad"]))

print (df_apoyo.loc[0], "\n\n", df_apoyo.loc[1])

for i in range (10):
    print(df_apoyo.loc[i], "\n\n")

df_apoyo.describe()


df_reconstruccion=pd.read_csv("avance-reconstruccion-escuelas-afectadas-sismo-19s-20191113.csv")
df_geo=df_reconstruccion[["Latitud","Longitud"]]

fig=plt.figure(figsize=(6,8))
plt.plot(df_geo["Longitud"],df_geo["Latitud"],linestyle='None',marker=".",alpha=0.5,color="green")
plt.show()


"""

#count the number of municipalities
table_cities = df_apoyo["Municipio"].unique()
print(table_cities)
print(len(table_cities))

#count the number of mujues by city
print(df_apoyo.groupby(["Municipio"]).size())

print(df_apoyo.groupby(["Etapa"])["Edad"].mean())