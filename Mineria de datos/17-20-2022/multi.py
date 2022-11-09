import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from sklearn.linear_model import LinearRegression

data = pd.read_csv("Advertising.csv",index_col = 0)
X_train = data[["TV","Radio","Newspaper"]]
y_train = np.array(data["Sales"])
reg = LinearRegression().fit(X_train,y_train)
print("reg coeff : ",reg.coef_)
print("reg intercept : ",reg.intercept_)

