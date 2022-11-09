import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from sklearn.linear_model import LinearRegression

data = pd.read_csv("Advertising.csv",index_col = 0)
fig = plt.figure(figsize=(8,6))
plt.plot(data["Newspaper"],data["Sales"],linestyle = "none",marker = "o",color = "red",alpha = 0.5)
#plt.show()

#y sales
#x Newspaper
dessus = 0
dessous = 0
#print(data.head())
#print(len(data["Newspaper"]))


for i in range(1,200):
    dessus += (data["Newspaper"][i] - data["Newspaper"].mean()) * (data["Sales"][i] - data["Sales"].mean())
    dessous += (data["Newspaper"][i] - data["Newspaper"].mean()) ** 2


beta_1 = dessus / dessous
print(beta_1)

beta_0 = data["Sales"].mean() - beta_1 * data["Newspaper"].mean()
print(beta_0)

def f(x):
    return(beta_0 + (beta_1 * x))

f_0 = f(0)
f_115 = f(115)
plt.plot([0 ,115], [f_0,f_115])
plt.show()

X_train = data[["Newspaper"]]
y_train = np.array(data["Sales"])
reg = LinearRegression().fit(X_train,y_train)

print("beta_0 our model: ", beta_0)
print("beta_1 our model: ", beta_1)
print("reg coeff : ",reg.coef_)
print("reg intercept : ",reg.intercept_)