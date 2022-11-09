import numpy as np
import matplotlib.image as mpimg
import matplotlib.pyplot as plt
#comentar
img = mpimg.imread("imagen.png")
#comentar
print("image",img)
#comentar
print("image 0", img[0][0][0])
#comentar
print ("len de l'image", len(img))
#comentar
print("len image 0",len(img[0]))
#comentar
print("len image 0 0", len(img[0][0]))
#comentar
data_matrix=[]
for i in range (len(img)):
    for j in range(len(img[0])):
        data_matrix.append(img[i][j])
#comentar

print("len de data matrix : ",len(data_matrix[0]))
"""
from sklearn.cluster import KMeans
kmeans = KMeans (n_clusters=5, random_state=0).fit_predict(data_matrix)
#comentar
"""

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

#we create on array with all the X that needs to be clustered
X = data_matrix
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

"""
colors=[[0,0,0],[1,1,1],[0,0,1],[1,0,0],[0,1,0]]
#noir, blanc, bleu, rouge, vert
#comentar
image_kmeans=np.copy(img)
#comentar

index = 0
data_matrix=[]
for i in range(len(img)):
    for j in range(len (img[0])) :
        image_kmeans[i][j]=colors[kmeans[index]]
        index=index+1

#comentar
fig = plt.figure(figsize=(12,6))
imgplot = plt.imshow(img)
plt.show()
#comentar
fig = plt.figure(figsize=(12,6))
imgplot = plt.imshow(image_kmeans)
plt.show()
"""