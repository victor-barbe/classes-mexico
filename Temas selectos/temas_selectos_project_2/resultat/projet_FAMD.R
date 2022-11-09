### FAMD: Sparrows, revisited ###

### 0. Importing data
nsp<-read.csv("/Users/victorbarbe/Desktop/temas_selectos_project_2/exams1.csv")[]

# Structure
str(nsp)

# Changing variables to factors: 
nsp[,1]<-as.factor(nsp[,1])
nsp[,2]<-as.factor(nsp[,2])
nsp[,3]<-as.factor(nsp[,3])
nsp[,4]<-as.factor(nsp[,4])
nsp[,5]<-as.factor(nsp[,5])

str(nsp) 
df<-nsp

# Descriptive analysis: 
summary(df[1:21,])
summary(df[22:48,])
#print(df[0:3,c(4,5,6)])
df<- df[0:40,c(0,1,2,3,4,5,6,7,8)]
df

#calling FactoMineR and factoextra. 
library("FactoMineR")
library("factoextra")

#computing FAMD
ob<- FAMD(df, graph = FALSE)

#getting eigenvalues
eig.val <- get_eigenvalue(ob)
head(eig.val)

#draw the scree plot 
fviz_screeplot(ob)

#coordinates, the cos2 and the contribution of all variables
var <- get_famd_var(ob)
var

# Coordinates of variables
head(var$coord)

# Cos2: quality of representation on the factor map (meaning how much of a variable is 
# represented in a given component.)
head(var$cos2)

# Contributions to the dimensions
head(var$contrib)

## Plot of variables
fviz_famd_var(ob, repel = TRUE)

##  Contribution to the first dimension
fviz_contrib(ob, "var", axes = 1)

## Contribution to the second dimension
fviz_contrib(ob, "var", axes = 2)  


# red line indicates the expected average value
 
#  To extract the results for quantitative variables, type this:
quanti.var <- get_famd_var(ob, "quanti.var")

fviz_famd_var(ob, "quanti.var", repel = TRUE,
              col.var = "black")

# The most contributing quantitative variables 

fviz_famd_var(ob, "quanti.var", col.var = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)

# We can highlight quantitative variables using their cos2 values representing

fviz_famd_var(ob, "quanti.var", col.var = "cos2", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)


#results for qualitative variables 

quali.var <- get_famd_var(ob, "quali.var")
quali.var 

# To visualize qualitative variables, type this:
fviz_famd_var(ob, "quali.var",  
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07")
)

fviz_famd_var(ob, "quali.var", col.var = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07")
)

# The plot above shows the categories of the categorical variables. 
fviz_famd_var(ob, "quali.var", col.var = "cos2", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07")
)  


# You can get the FAMD results for individuals by typing:

ind <- get_famd_ind(ob)
ind
# plotting individuals
fviz_famd_ind(ob, #col.ind = "cos2", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)
 

#color individuals by their cos2 and contribution
fviz_famd_ind(ob, col.ind = "cos2", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)
fviz_famd_ind(ob, col.ind = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)





