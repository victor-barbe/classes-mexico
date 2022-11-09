import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from datetime import datetime

#comentar
data = pd.read_csv("Advertising.csv", index_col=0)
#comentar
fig = plt.figure(figsize=(6,6))
plt.plot(data["TV"], data["Sales"], linestyle = "none", marker="o", color="red", alpha=0.5)
plt.show()
#comentar
fig = plt.figure(figsize=(6,6))
plt.plot(data["TV"], data["Radio"], linestyle="none", marker="o", color="red", alpha=0.5)
plt.show()
#comentar
fig = plt.figure(figsize=(6,6))
plt.hist(data["TV"])
plt.show()