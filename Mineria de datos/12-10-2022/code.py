import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

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
plt.show()