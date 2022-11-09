import pandas as pd

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

#printing the columns and the head of the dataframe
print(df.columns)
print(df.head())

df["Magnitud"] = pd.to_numeric(df["Magnitud"])

print(len(df[df['Magnitud'] > 7]))
