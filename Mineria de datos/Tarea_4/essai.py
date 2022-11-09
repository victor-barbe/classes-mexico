import pandas as pd
tab = [["12","ZA"],[11,"A"]]

df = pd.DataFrame(tab, columns =["Fecha","Hora"])
print(df.head())
