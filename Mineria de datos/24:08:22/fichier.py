import pandas as pd
import numpy as np
#opening the dataset
archive = open("data.txt","r")
text = archive.readlines()
#print(text)
archive.close()
x = []
for i in range (11):
    x.append(text[i].split())
print(x)
#df = pd.read_csv('data.txt', sep=";")
#print(df)

#df = pd.DataFrame()
#df.columns = 
a = np.random.rand(100)

X1 = np.random.uniform(0,5)
X2 = np.random.uniform(8,15)

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
# opening the dataset
archive = open("data.txt", "r")
text = archive.readlines()
# print(text)
archive.close()
x = text[0].split()
# print(x)


# for i in range(text.count("\n")):
#     df.append(text[i+1].split())

# print(df)
# # df = pd.read_csv('data.txt', sep=" ")
# # print(df)

# a = np.random.rand(100)

df = pd.DataFrame(columns=['Firstname', 'Lastname','BirthDate', 'CityOfBirth', 'Workplace', 'Field'])
for i in range(len(text)):
    df.loc[i] = text[i].split()

print(df)

a = np.random.rand(100)
hist, bin_edges = np.histogram(a)
plt.hist(a, bin_edges)
plt.show()