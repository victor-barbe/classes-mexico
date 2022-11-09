import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import AgglomerativeClustering
from scipy.cluster.hierarchy import dendrogram
from scipy.cluster.hierarchy import linkage

#first we define the points we want to cluster and we plot them
data = np.array([[0,0.3,0.3,0.7],[0.3,0,0.5,0.8],[0.4,0.5,0,0.45],[0.7,0.8,0.45,0]])
plt.scatter(data[:,0], data[:,1])
plt.title("Data we define on R2")
plt.xlabel("X")
plt.ylabel("Y")
plt.show()

hierarchical_clustering = AgglomerativeClustering(n_clusters=3,affinity="euclidean",linkage="complete")
print(hierarchical_clustering)
cluster_4 = hierarchical_clustering.fit_predict(data)
print("Clustering method complete ",cluster_4)

for i in range(len(cluster_4)):
    if cluster_4[i] == 0:
        plt.scatter(data[i, 0], data[i, 1], c = "blue", label = "1st Cluster")
    elif cluster_4[i] == 1:
        plt.scatter(data[i, 0], data[i, 1], c = "green", label = "2nd Cluster")
    elif cluster_4[i] == 2:
        plt.scatter(data[i, 0], data[i, 1], c = "red", label = "3rd Cluster")


plt.title("Hierarchical grouping with complete method")
plt.xlabel("X")
plt.ylabel("Y")
plt.legend()
plt.show()

#we print the dendogram with a complete method
linkage_data = linkage(data, method="complete",metric="euclidean")
dendrogram(linkage_data)
plt.title("Dendogram with complete method")
plt.show()  