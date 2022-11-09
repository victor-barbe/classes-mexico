import matplotlib.pyplot as plt
import numpy as np

def Distancia(vector1, vector2) :
    dist = 0
    for i in range (len(vector1)):
        dist += (vector1[i]-vector2[i]) ** 2
    return (np.sqrt(dist))

def Centroide(lista_vectores):
    centroide = []
    for i in range (len(lista_vectores)):
        promedio_i = 0
        for j in range(len(lista_vectores[0])):
            promedio_i += lista_vectores[j][i]
        promedio_i = promedio_i / len(lista_vectores)
        centroide.append(promedio_i)
    return centroide

a = [2,3,1]
b = [-3,2,1]
c = [-1,5,1]
print (Distancia(b, a))
print (Distancia(a, c))
print (Distancia(b, c))
cluster = [a, b, c]
x = Centroide(cluster)
print(x)

fig = plt.figure()
ax = fig.add_subplot(projection='3d')
ax.scatter(2, 3, 1, c = 'red')
ax.scatter(-3, 2, 1, c = 'BLUE')
ax.scatter(-1, 5, 1, c = 'GREEN')
ax.scatter(x[0],x[1], x[2], c='BLACK')
plt.show()
"""
plt.scatter(2,3, c='RED')
plt.scatter(-3,2, c='BLUE')
plt.scatter(-1,5, c='GREEN')
plt.scatter(x[0],x[1], c='BLACK')
plt.title("Initial data")
plt.xlabel("X")
plt.ylabel("Y")
plt.show()
"""