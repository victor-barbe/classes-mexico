import matplotlib.pyplot as plt
from sklearn import datasets
from sklearn.decomposition import PCA
import pandas as pd

# import some data to play with
iris = datasets.load_iris()
print(iris)

df = pd.DataFrame(iris)