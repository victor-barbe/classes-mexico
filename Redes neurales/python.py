import numpy as np
import matplotlib.pyplot as plt

#define points
C1_X = [1,1,2,3,1]
C1_Y = [2,3,2,3,1]

C2_X = [8,10,11,13,11]
C2_Y = [9,10,8,11,11]

#plot the points on the graph
plt.scatter(C1_X, C1_Y, c = "ORANGE")
plt.scatter(C2_X, C2_Y, c = "GREEN")

#define parameters
w0 = -30
w1 = 3
w2 = 2

#define X coordinates
x1 = 0
x2 = 15

#compute the Y value
y1 = (-w1*x1-w0)/w2
y2 = (-w1*x2-w0)/w2
print("y1 = ", y1 ," y2 = ", y2)

#plot the linear regression
plt.plot([x1,y1], [x2,y2], 'b-', lw = 2) 
plt.show()

#para mejorar los parámetros utilizando un método definido, podríamos crear un algoritmo que calcule la distancia de los diferentes puntos a la línea
#La distancia media de los puntos de un lado debe ser cercana a la del otro lado
#Así la regresión separaría los puntos correctamente