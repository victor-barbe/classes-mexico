import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
"""
#first step we create 3 cluters
x1 = np.random.standard_normal((100,2)) * 0.6 + np.ones((100,2))
x2 = np.random.standard_normal((100,2))* 0.5 - np.ones((100,2))
x3 = np.random.standard_normal((100,2))* 0.4 - 2 * np.ones((100,2)) + 5

#we plot the 3 different clusters
plt.scatter(x1[:, 0], x1[:, 1], c='RED')
plt.scatter(x2[:, 0], x2[:, 1], c='BLUE')
plt.scatter(x3[:, 0], x3[:, 1], c='GREEN')
plt.title("Initial data")
plt.xlabel("X")
plt.ylabel("Y")
plt.show()
#X = np.concatenate((x1,x2,x3),axis=0)
"""
X = pd.read_csv('data.csv')

"""--------------- HIPERPARÁMETROS ---------------"""
K = 3
iterations = 15
x_header = 'Longitud'
y_header = 'Latitud'

"""--------------- INICIALIZACIÓN ---------------"""

X = X[[x_header, y_header]].to_numpy()

n = len(X)
p = len(X[0])

groups = {}
group_means = {}
#we create on array with all the data that
k = 3
def kmeans(X, k):
    diff = 1
    cluster = np.zeros(X.shape[0])
    centroids = X.sample(n=k).values
    while diff:
    # for each observation
        for i, row in enumerate(X):
            mn_dist = float('inf')
            # dist of the point from all centroids
            for idx, centroid in enumerate(centroids):
                d = np.sqrt((centroid[0]-row[0])*2 + (centroid[1]-row[1])*2)
                # store closest centroid
                if mn_dist > d:
                    mn_dist = d
                    cluster[i] = idx
        new_centroids = pd.DataFrame(X).groupby(by=cluster).mean().values
     # if centroids are same then leave
        if np.count_nonzero(centroids-new_centroids) == 0:
            diff = 0
        else:
            centroids = new_centroids
    return centroids, cluster

a = kmeans(X,k)