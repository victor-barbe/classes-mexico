import pandas as pd



dates = [0,0,0]
fruits = [0,0,0]
prices = [0,0,0]
for i in range(200):
    dates.append(i)
    fruits.append(i + 12)
    prices.append(i + 30)
data = pd.DataFrame({'Date':dates ,
                   'Fruit':fruits ,
                   'Price': prices})

print(data)

from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import style
style.use('ggplot')

fig = plt.figure()
ax1 = fig.add_subplot(111, projection='3d')

x3 = []
y3=  []
z3=  []
for i in range(203):
    x3.append(data['Date'][i])
    y3.append(data['Fruit'][i])
    z3.append(0)

print(x3)
dx = np.ones(203)
dy = np.ones(203)
dz = np.ones(203)

print(data["Date"])

ax1.bar3d(x3,y3,z3, dx, dy, dz)


ax1.set_xlabel('x axis')
ax1.set_ylabel('y axis')
ax1.set_zlabel('z axis')

plt.show()