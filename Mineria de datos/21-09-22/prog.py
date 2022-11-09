import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn import datasets
from sklearn.cluster import AgglomerativeClustering

"""
x = np.array([[1.5,2.5],[1,4],[1,0],[5.5,1],[6,4],[6,0]])
fig = plt.figure(figsize =(6,6))
plt.scatter(x[:,0],x[:,1])
plt.show()
"""
#loading data
iris = datasets.load_iris()
df=pd.DataFrame(iris.data, columns=['1','2','3','4'])
df.drop(['3', '4'], axis=1, inplace=True)

#creating clustering
clustering = AgglomerativeClustering()
clustering.fit(df)

#ploting the points with different colors
fig=plt.figure(figsize=(6,6))
for i in df.index:
  if (clustering.labels_[i]==0):
    plt.scatter(df['1'][i],df['2'][i],color='red')
  else:
    plt.scatter(df['1'][i],df['2'][i],color='green')

plt.show()