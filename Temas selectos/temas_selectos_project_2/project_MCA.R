##loading libraries
library(FactoMineR)
library(factoextra)

#loading dataset of tea 
data(tea)
head(tea)

# Some info about: 
help(tea)
#dimensions
dim(tea)


#print(tea[0:3,c(13,3,15,7,14)])
#print(tea[0:3,c(1,4,3,15,7,14)])

#here are the variables we will be using in the project as describe in the report
active<-tea[0:150,c(1,4,3,15,7)]
head(active)
#print(tea[0:150,0:18])
#print(tea[0:4,c(13,14,15)])

#sumary of selected variables
summary(active)[,1:5]

#graph of variables
par(mfrow=c(1,5))
for(i in 1:5){
  plot(active[,i], main=colnames(active)[i], ylab="counts", col="skyblue",
       ylim=c(0,300))
}


#computing MCA
ob.mca<-MCA(active, ncp=5, graph=FALSE)

MCA(active, ncp=5, graph=TRUE)

#getting eigenvalues
eigenvals<-get_eigenvalue(ob.mca)
eigenvals
sum(eigenvals[,1])

#visualizing the variances
fviz_screeplot(ob.mca, addlabels=TRUE, ylim=c(0,50))

#getting the biplot
fviz_mca_biplot(ob.mca, 
                repel=TRUE# Avoid text overlapping (can get slow if many points)
)

#getting the variables
var <- get_mca_var(ob.mca)
var

# variables are:
# - var$coord: coordinates of variables to create a scatter plot
# - var$cos2: indicates the quality of the variables representation on the
# factor map.
# - var$contrib: contains the contributions (in percentage) of the variables to 
# each of the dimensions. 


#correlation between variables and MCA principal dimensions
fviz_mca_var(ob.mca, choice = "mca.cor",
             repel = TRUE, # Avoid text overlapping (slow)
             ggtheme = theme_minimal())


#getting round
round(var$coord, 2)
head(round(var$coord, 2),4)

#plot the coordinates of variables
fviz_mca_var(ob.mca,
             repel = TRUE, # Avoid text overlapping (slow)
             ggtheme = theme_minimal())

#getting cos2 value of variables
head(var$cos2, 4)

# Color by cos2 values: quality on the factor map
fviz_mca_var(ob.mca, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, # Avoid text overlapping
             ggtheme = theme_minimal())


#getting corplot of the data, on which dimension each variables are represented
library("corrplot")
par(mfrow=c(1,1))
corrplot(var$cos2, is.corr=FALSE)

head(round(var$contrib,2), 4)

# Contributions of rows to dimension 1
fviz_contrib(ob.mca, choice = "var", axes = 1, top = 15)
# Contributions of rows to dimension 2
fviz_contrib(ob.mca, choice = "var", axes = 2, top = 15)

# Total contribution to dimension 1 and 2
fviz_contrib(ob.mca, choice = "var", axes = 1:2, top = 15)

#red line indicates the expected average value if the contributions were uniform 


#most contributing categories 

fviz_mca_var(ob.mca, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, # avoid text overlapping (slow)
             ggtheme = theme_minimal()
)


#Graph of individuals
ind <- get_mca_ind(ob.mca)
ind

# Coordinates of column points
head(ind$coord)
# Quality of representation
head(ind$cos2)
# Contributions
head(ind$contrib)

# visualizing individuals 
fviz_mca_ind(ob.mca, col.ind = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, # Avoid text overlapping (slow if many points)
             ggtheme = theme_minimal())


# Cos2 of individuals
fviz_cos2(ob.mca, choice = "ind", axes = 1:2, top = 20)

# Contribution of individuals to the dimensions
fviz_contrib(ob.mca, choice = "ind", axes = 1:2, top = 20)

# The next piece of R code colors the individuals by groups using the levels of the
# variable Vomiting.
# The argument "habillage" is used to specify the factor variable for coloring the
# individuals by groups. 
# A concentration ellipse can be also added around each group using the argument 
# addEllipses = TRUE. 
# If you want a confidence ellipse around the mean point of categories, use 
# ellipse.type = "confidence"
# The argument palette is used to change group colors.

fviz_mca_ind(ob.mca,
             label = "none", # hide individual labels
             habillage = "sugar", # color by groups
             palette = c("#00AFBB", "#E7B800"),
             addEllipses = TRUE, ellipse.type = "confidence",
             ggtheme = theme_minimal())

# To specify the value of the argument "habillage", it's also possible to use the
# index of the column as (habillage = 2).
# Additionally, you can provide an external grouping variable like this
# habillage = poison$Vomiting.
# For example:
# habillage = index of the column to be used as grouping variable
fviz_mca_ind(ob.mca, habillage = 2, addEllipses = TRUE)
# habillage = external grouping variable
fviz_mca_ind(ob.mca, habillage = poison$lunch, addEllipses = TRUE)

# To color individuals using multiple categorical variables at the same time, use 
# the function fviz_ellipses():
fviz_ellipses(ob.mca, c("lunch", "sugar"),
              geom = "point")

# OR you can specify categorical variable indices:
fviz_ellipses(ob.mca, habillage= 1, geom = "point")
fviz_ellipses(ob.mca, habillage= 1:2, geom = "point")
fviz_ellipses(ob.mca, habillage= 1:3, geom = "point")
fviz_ellipses(ob.mca, habillage= 1:4, geom = "point")
fviz_ellipses(ob.mca, habillage= 1:5, geom = "point")

