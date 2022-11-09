import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def mean_group(q: int) -> np.ndarray:
    mean = np.zeros(p)
    my_group = groups[q]
    for j in range(p):
        for i in my_group:
            mean[j] += Data[i][j]
    return mean/len(my_group)

def update_mean_groups():
    for q in range(K):
        group_means.update({q:mean_group(q)})

def distance(A: np.ndarray, B: np.ndarray) -> float:
    return np.linalg.norm(A-B)

"""--------------- BASE DE DATOS ---------------"""

df = pd.read_csv('data.csv')

"""--------------- HIPERPARÁMETROS ---------------"""
K = 3
iterations = 15
x_header = 'Longitud'
y_header = 'Latitud'

"""--------------- INICIALIZACIÓN ---------------"""

Data = df[[x_header, y_header]].to_numpy()

n = len(Data)
p = len(Data[0])

groups = {}
group_means = {}

for i in range(K):
    groups.update({i:set()})
    group_means.update({i:set()})

for i in range(n):
    groups[np.random.randint(K)].add(i)

update_mean_groups()

fig, (ax1,ax2,ax3) = plt.subplots(nrows=1, ncols=3, figsize=(15,8))

for q in range(K):
    x_values = []
    y_values = []
    index = groups[q]
    for i in index:
        x_values.append(Data[i][0])
        y_values.append(Data[i][1])
    ax1.plot(x_values, y_values, marker='x', linestyle='None', label=f'cluseter {q}: {len(groups[q])}')
    ax1.legend()
    ax1.set_title('Inicialización')

"""--------------- ALGORITMO ---------------"""

for iter in range(iterations):
    for q in range(K):
        new_group=[]
        for i in groups[q]:
            x = Data[i]
            new_group.append([q,i])
            minimum = distance(x,group_means[q])
            for s in range(K):
                test = distance(x,group_means[s])
                if test < minimum:
                    minimum = test
                    new_group[-1] = [s,i]
        for g in new_group:
            s = g[0]
            i = g[1]
            if s != q:
                groups[q].remove(i)
                groups[s].add(i)
    update_mean_groups()

for q in range(K):
    x_values = []
    y_values = []
    index = groups[q]
    for i in index:
        x_values.append(Data[i][0])
        y_values.append(Data[i][1])
    ax2.plot(x_values, y_values, marker='x', linestyle='None', label=f'cluseter {q}: {len(groups[q])}')
    ax2.plot(group_means[q][0], group_means[q][1], marker='*', linestyle='None', color='black')
    ax2.set_title('Kmeans')
    ax2.legend()

"""
----------------------- VALIDACIÓN CON SKLEARN ------------------------------
"""
from sklearn.cluster import KMeans

data_matrix = np.transpose(np.array([df[x_header].to_numpy(), df[y_header].to_numpy()]))

kmeans = KMeans(n_clusters=K, random_state=0).fit_predict(data_matrix)

colors = ['red', 'green', 'blue', 'pink', 'purple', 'yellow'] # K <= 6

df['color'] = df[x_header]

for i in range(len(df)):
    df['color'][i] = colors[kmeans[i]]


ax3.scatter(df[x_header], df[y_header], color=df['color'], marker='x', linestyle='None')
ax3.set_title('sklearn Kmeans')

plt.show()