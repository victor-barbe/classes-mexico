import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def mean_group(q: int) -> np.ndarray:
    mean = np.zeros(p)
    my_group = groups[q]
    for j in range(p):
        for i in my_group:
            mean[j] += X[i][j]
    return mean/len(my_group)

def update_mean_groups():
    for q in range(K):
        group_means.update({q:mean_group(q)})

def distance(A: np.ndarray, B: np.ndarray) -> float:
    return np.linalg.norm(A-B)

#parameters
K = 3
iterations = 15
x_header = 'Longitud'
y_header = 'Latitud'

#defining variables and ploting the inital data
x1 = np.random.standard_normal((100,2)) * 0.6 + np.ones((100,2))
x2 = np.random.standard_normal((100,2))* 0.5 - np.ones((100,2))
x3 = np.random.standard_normal((100,2))* 0.4 - 2 * np.ones((100,2)) + 5

#we plot the 3 different clusters
plt.scatter(x1[:, 0], x1[:, 1], c='RED')
plt.scatter(x2[:, 0], x2[:, 1], c='BLUE')
plt.scatter(x3[:, 0], x3[:, 1], c='GREEN')
plt.title("Initial X")
plt.xlabel("X")
plt.ylabel("Y")

#we create on array with all the X that needs to be clustered
X = np.concatenate((x1,x2,x3),axis=0)

n = len(X)
p = len(X[0])

groups = {}
group_means = {}

for i in range(K):
    groups.update({i:set()})
    group_means.update({i:set()})

for i in range(n):
    groups[np.random.randint(K)].add(i)

update_mean_groups()

#K-means Algorithms
for iter in range(iterations):
    for q in range(K):
        new_group=[]
        for i in groups[q]:
            x = X[i]
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

fig = plt.figure(figsize=(10,8))

for q in range(K):
    x_values = []
    y_values = []
    index = groups[q]
    for i in index:
        x_values.append(X[i][0])
        y_values.append(X[i][1])
    plt.plot(x_values, y_values, marker='x', linestyle='None', label=f'cluseter {q}: {len(groups[q])}')
    plt.plot(group_means[q][0], group_means[q][1], marker='*', linestyle='None', color='black')

plt.title(f'Kmeans for {K} groups')
plt.legend()
plt.show()