import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans 

np.random.seed(7)

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

#we create on array with all the data that needs to be clustered
X = np.concatenate((x1,x2,x3),axis=0)

"""
centroids = np.random.rand(3,2)
#print(centroids)

dist = np.linalg.norm(X - centroids[0,:],axis=1).reshape(-1,1)
print(dist[:10,:])

dist = np.append(dist,np.linalg.norm(X - centroids[1,:],axis=1).reshape(-1,1),axis=1)
print(dist[:10,:])


"""
#we import the clustering model, using 3 clusters, k-means from sklearn uses euclidian distance by default
kmean = KMeans(n_clusters = 3)
#we fit the model with the X data
kmean.fit(X)

#we get the centroids returned by the model and we plot to see if they are correctly placed
centroids = kmean.cluster_centers_
plt.scatter(centroids[:, 0], centroids[:, 1], c='BLACK', marker = '+')
plt.show()
print(centroids)
