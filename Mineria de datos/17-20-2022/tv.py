import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from sklearn.linear_model import LinearRegression

#data = pd.read_csv("Advertising.csv")
"""
X_train = data[["TV"]]
y_train = np.array(data["Sales"])

reg = LinearRegression().fit(X_train,y_train)


X_train = data[["TV","Radio","Newspaper"]]
y_train = np.array(data["Sales"])
reg = LinearRegression().fit(X_train,y_train)
print(reg.coef_)
print(reg.intercept_)
print(reg.score())
#plt.scatter(X_train, y_train, s=60, alpha=0.7, edgecolors="k")
#plt.show()
"""

data = pd.read_csv("Advertising.csv",index_col = 0)
fig = plt.figure(figsize=(8,6))
plt.plot(data["TV"],data["Sales"],linestyle = "none",marker = "o",color = "red",alpha = 0.5)
#plt.show()

#y sales
#x TV
dessus = 0
dessous = 0
#print(data.head())
#print(len(data["TV"]))


for i in range(1,200):
    dessus += (data["TV"][i] - data["TV"].mean()) * (data["Sales"][i] - data["Sales"].mean())
    dessous += (data["TV"][i] - data["TV"].mean()) ** 2


beta_1 = dessus / dessous
print(beta_1)

beta_0 = data["Sales"].mean() - beta_1 * data["TV"].mean()
print(beta_0)

def f(x):
    return(beta_0 + (beta_1 * x))

f_0 = f(0)
f_300 = f(300)
plt.plot([0 ,300], [f_0,f_300])

X_train = data[["TV"]]
y_train = np.array(data["Sales"])
reg = LinearRegression().fit(X_train,y_train)
print("beta_0 our model: ", beta_0)
print("beta_1 our model: ", beta_1)
print("reg coeff : ",reg.coef_)
print("reg intercept : ",reg.intercept_)
plt.show()