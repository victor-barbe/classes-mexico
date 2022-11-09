import numpy as np
import matplotlib.pyplot as plt

n = 10
#nvestiga la matriz de adyacencia del grafo camino


#Crea una función llamada mat_path(n) tal que recibe un número natural n y regrese la
#matriz de adyacencia del grafo camino con n vértices.

def mat_path(n):

    return 0

#Para n= 500 y 1000, calcula los valores propios de dicha matriz
#y crea histogramas de dichos valores

#Genera una lista tal que para cada k desde 1 hasta n tenga el valor de 2cos(kpi/n+1)
def list_creator(n):
    list = []
    for k in range(n):
        list.append(2 * np.cos(( k * np.pi ) / ( n + 1 ) ))
    return(list)



#Crea histograma de dicha listas con n=500 y 1000

list_500 = list_creator(500)
list_1000 = list_creator(1000)

plt.hist(list_500, density=True, bins=10)  
plt.ylabel('Probability')
plt.xlabel('list_500')
plt.show()

plt.hist(list_1000, density=True, bins=10)  
plt.ylabel('Probability')
plt.xlabel('list_1000')
plt.show()
#Verifica que los histogramas son similares, ¿qué puedes conjeturar al respecto?