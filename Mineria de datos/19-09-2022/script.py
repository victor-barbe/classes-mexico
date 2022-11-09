import pandas as pd
import numpy as np

#df = pd.read_csv("iris.data")
#print(df.head())

archivo=open("iris.data",'r')
text=archivo.readlines()

tab = []

for i in text:
    if i!="\n":
        #we use [:-1] to get rid of the "\n" at the end of the lines
        tab.append(i[:-1])

value = []
for i in tab:
    #tab.append(i.split(","))
    value.append(i.split(","))

df = pd.DataFrame(value, columns =["Sepal_length","Sepal_width","Petal_length","Petal_width","class"])
#print(df.head())

#we convert the type of the data to numerical values
df[["Sepal_length","Sepal_width","Petal_length","Petal_width"]] = df[["Sepal_length","Sepal_width","Petal_length","Petal_width"]].apply(pd.to_numeric)

print("\nMin of each column")
min = df[["Sepal_length","Sepal_width","Petal_length","Petal_width"]].min()
print(min)

print("\nMax of each column")
max = df[["Sepal_length","Sepal_width","Petal_length","Petal_width"]].max()
print(max)

print("Average of each column")
average = df[["Sepal_length","Sepal_width","Petal_length","Petal_width"]].mean()
print(average)