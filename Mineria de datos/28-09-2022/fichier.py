import random 
import matplotlib.pyplot as plt
import numpy as np

n = 100
data_1 = []
data_2 = []
i=0
while i<n:
    x=random.random() * (1 + 1) - 1
    y=random.random() * (1 + 1) - 1
    if(x ** 2 + y ** 2 < 1.1 and x ** 2 + y ** 2 > 0.8):
        i = i + 1
        data_1.append([x,y])
data_1=np.array(data_1)

fig=plt.figure(figsize=(6,6))
plt.scatter(data_1[:,0],data_1[:,1], c = 'red')

j=0
n=100
while j<n:
    w=np.random.uniform(low=-4, high=4)
    z=np.random.uniform(low=-4, high=4)
    if(w ** 2 + z ** 2 < 4.1 and w ** 2 + z ** 2 > 3.8):
        j = j + 1
        data_2.append([w,z])
data_2=np.array(data_2)
plt.scatter(data_2[:,0],data_2[:,1], c = "Blue")
plt.show()