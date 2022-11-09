import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import AgglomerativeClustering
from scipy.cluster.hierarchy import dendrogram
from scipy.cluster.hierarchy import linkage

#first we define the points we want to cluster and we plot them
#data = np.array([[2,3],[1,2],[1,3],[4,3],[5,1.5]])
#chaque sous tableau est une ligne
data = np.array([[0,0.3,0.4,0.7],[0.3,0,0.5,0.8],[0.4,0.5,0,0.45],[0.7,0.8,0.45,0]])
plt.scatter(data[:,0], data[:,1])
plt.title("Data we define on R2")
plt.xlabel("X")
plt.ylabel("Y")
plt.show()

#1st type
#Hierarchical grouping with singe linkage
#here we first print the different clusters
hierarchical_clustering = AgglomerativeClustering(n_clusters=3,affinity="euclidean",linkage="single")
print(hierarchical_clustering)
cluster_1 = hierarchical_clustering.fit_predict(data)
print("Clustering method single ", cluster_1)

for i in range(len(cluster_1)):
    if cluster_1[i] == 0:
        plt.scatter(data[i, 0], data[i, 1], c = "blue", label = "1st Cluster")
    elif cluster_1[i] == 1:
        plt.scatter(data[i, 0], data[i, 1], c = "green", label = "2nd Cluster")
    elif cluster_1[i] == 2:
        plt.scatter(data[i, 0], data[i, 1], c = "red", label = "3rd Cluster")

plt.title("Hierarchical grouping with single method")
plt.xlabel("X")
plt.ylabel("Y")
plt.legend()
plt.show()

#we print the dendogram with a single method
linkage_data = linkage(data, method="single",metric="euclidean")
dendrogram(linkage_data)
plt.title("Dendogram with single method")
plt.show()  



#2nd type
#Hierarchical grouping with ward linkage
#here we print define the clusters and print them on a graph
hierarchical_clustering = AgglomerativeClustering(n_clusters = 3, affinity="euclidean",linkage="ward")
print(hierarchical_clustering)
cluster_2 = hierarchical_clustering.fit_predict(data)

#we print data depending on the cluster it belongs to
print("Clustering method ward : ",cluster_2)
for i in range(len(cluster_2)):
    if cluster_2[i] == 0:
        plt.scatter(data[i, 0], data[i, 1], c = "blue", label = "1st Cluster")
    elif cluster_2[i] == 1:
        plt.scatter(data[i, 0], data[i, 1], c = "green", label = "2nd Cluster")
    elif cluster_2[i] == 2:
        plt.scatter(data[i, 0], data[i, 1], c = "red", label = "3rd Cluster")

plt.title("Hierarchical grouping with ward method")
plt.xlabel("X")
plt.ylabel("Y")
plt.legend()
plt.show()

#now we print the dendogram with ward method
linkage_data = linkage(data, method="ward",metric="euclidean")
dendrogram(linkage_data)
plt.title("Dendogram with ward method")
plt.show()  



#3rd type
#Hierarchical grouping with average linkage
#here we first print the different clusters
hierarchical_clustering = AgglomerativeClustering(n_clusters=3,affinity="euclidean",linkage="average")
print(hierarchical_clustering)
cluster_3 = hierarchical_clustering.fit_predict(data)
print("Clustering method average ",cluster_3)

for i in range(len(cluster_3)):
    if cluster_3[i] == 0:
        plt.scatter(data[i, 0], data[i, 1], c = "blue", label = "1st Cluster")
    elif cluster_3[i] == 1:
        plt.scatter(data[i, 0], data[i, 1], c = "green", label = "2nd Cluster")
    elif cluster_3[i] == 2:
        plt.scatter(data[i, 0], data[i, 1], c = "red", label = "3rd Cluster")

plt.title("Hierarchical grouping with average method")
plt.xlabel("X")
plt.ylabel("Y")
plt.legend()
plt.show()

#we print the dendogram with a average method
linkage_data = linkage(data, method="average",metric="euclidean")
dendrogram(linkage_data)
plt.title("Dendogram with average method")
plt.show()



#4th type
#Hierarchical grouping with complete linkage
#here we first print the different clusters
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