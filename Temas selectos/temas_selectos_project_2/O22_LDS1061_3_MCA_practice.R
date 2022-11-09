### Multiple Correspondence Analysis (MCA) ###
##############################################

# MCA is an extension of the simplest CA procedure. Remember: the purpose
# is to summarize and visualize a data (contigency) table, but now, 
# with MCA, we consider the possible case of more than two categorical 
# variables. 

# The general goals: 
# 1. Identify individuals with similar profile in their answers
# 2. Identify associations between categories of variables. 

# Now, as for the analysis, we're going to use the 'FactoMineR' (A) package and
# for visualization purposes, we'll use 'factoextra' (B).

### 1. Computation: 
# Instal both, (A) and (B), then load them: 
library(FactoMineR)
library(factoextra)

# Now let's consider the data set 'poison': 
data(poison)
head(poison)

# Some info about: 
help(poison)

# "The data used here refer to a survey carried out on a sample of children of
# primary school who suffered from food poisoning. They were asked about their 
# symptoms and about what they ate."

# Number of rows and columns
dim(poison)

# Individuals we're going to use: from row 1 to 55 ("Active individuals")
# Variables to consider: columns 5 to 15 ("Active variables")
# Those variables not consider in the MCA are called "Supplementary variables"
# We'll try to predict them.
# From those, columns 1 and 2 are Supplementary Quantitative Variables
# columns 3 and 4 are called Supplementary Qualitative Variables. 


### 1.1. Data Format: 
active<-poison[1:55,5:15]
head(active)

### 1.2 Summary
# We may be interested in a quick summary of some or all variables. Let's try
# a summary of just 5 variables

summary(active)[,1:5]

# i.e., we see the frequency of observations in each of two categories per
# factor (variable)
# Or visually: 

par(mfrow=c(1,5))
for(i in 1:5){
  plot(active[,i], main=colnames(active)[i], ylab="counts", col="skyblue",
       ylim=c(0,55))
}

# Variable categories with a very low frequency may distort the analysis. The 
# recommendation is to remove them. 

### 1.3 R Code
# For conducting an MCA over the active individuals, we just type: 
# Check the help! help(MCA)

ob.mca<-MCA(active, ncp=5, graph=FALSE)

# Now, for understanding what is in ob.mca:
MCA(active, ncp=5, graph=TRUE)

# - ncp: number of dimensions kept in the results (by default 5)
# - graph=TRUE is the default option. Try it! I'm sure you'll get an idea of
# the meaning of it.

# ob.mca contains a lot of info. We'll see how to access and interpret them. 

### 2. Visualization and interpretation
# 2.1 Eigenvalues (a.k.a., variances)
eigenvals<-get_eigenvalue(ob.mca)
eigenvals

# Notice that the sum of eigenvalues is 1; i.e., the data was weighted so that
# all of the variables has the same importance. 

sum(eigenvals[,1])

# Also, notice that the first 5 dimensions counts for (roughly) only 75% of the total
# variability. Not that good, but...it is what it is. 

# Visualizing the variances (remember, some authors call these "inertias"):
fviz_screeplot(ob.mca, addlabels=TRUE, ylim=c(0,50))

# You can also use this function, but I think the previous one is more complete. 
# (Uncomment the next row to try it)
# fviz_eig(ob.mca, ylim=c(0,50))

# 2.2 Biplot
fviz_mca_biplot(ob.mca, 
                repel=TRUE# Avoid text overlapping (can get slow if many points)
)
  
# The biplot is a complete representation of the data. 
# For both, individuals (blue) and variables (red), the distance between any row 
# or column points is a measure of how (dis)similar they are (the more the distance,
# the more dissimilar). 
# Rows or column points with similar profiles are close in the biplot. 

# 2.3 Graph of variables
# We can use the function 'get_mca_var()' to extract the results for variable 
# categories. 
# This function returns a list containing
# - the coordinates, 
# - the cos2 and 
# - the contribution of variable categories.

var <- get_mca_var(ob.mca)
var

# The components of 'var' can be used in the plot of ROWS as follows:
# - var$coord: coordinates of variables to create a scatter plot
# - var$cos2: indicates the quality of the variables representation on the
# factor map.
# - var$contrib: contains the contributions (in percentage) of the variables to 
# each of the dimensions. 

# 2.3.1 Correlation between variables and principal dimensions
# To visualize the correlation between variables and MCA principal dimensions,
# type this:

fviz_mca_var(ob.mca, choice = "mca.cor",
             repel = TRUE, # Avoid text overlapping (slow)
             ggtheme = theme_minimal())

# Sounds familiar? Yeap. It's the same plot obtained by default in previous lines. 
# With this plot we can identify "clusters" of variables according to they degree of
# correlation with each dimension. 
# The plot above helps to identify variables that are the most correlated with each 
# dimension; e.g., variables Diarrhea, Abdominals and Fever are the most correlated
# with (or along) dimension 1. Similarly, the variables Courgette and Potato are the 
# most correlated with (or along) dimension 2.

round(var$coord, 2)
# A lot of variables! Let's visualize just 4 (this is just for having an idea of the
# object).
head(round(var$coord, 2),4)

# In line 149, we see the coordinates of each variable on each dimension. 
# Now, visualizing them in just two: 
fviz_mca_var(ob.mca,
             repel = TRUE, # Avoid text overlapping (slow)
             ggtheme = theme_minimal())

# The plot above shows the relationships between variable categories.
# The interpretation goes as follows: 
# i) Variable categories with a similar profile are grouped together.
# ii) Negatively correlated variable categories are positioned on opposite sides of
# the plot (opposed quadrants).
# iii) The distance between category points and the origin measures the quality of
# the variable category on the factor map. 
# iv) Category points that are away from the origin are well represented on the factor
# map.

# 2.3.2  Quality of representation of variable categories
# The two dimensions 1 and 2 are sufficient to retain 46% of the total variation
# in the data.As said before, not that good...
# Thus, not all the points are equally well displayed in the two dimensions.
# We'd like to have a way of measuring the quality of their representation. 
# The quality of the representation is called "the squared cosine" (cos2), which 
# measures the degree of association between variable categories and a particular axis. 
# The cos2 of variable categories can be extracted as follows:

head(var$cos2, 4)

# If a variable category is well represented by two dimensions, the sum of the cos2 is
# close to one.
# For some of the rows, more than 2 dimensions are required to perfectly represent 
# the data.

# A nice way to visualize how well categories are represented is by coloring
# them according to their cos2 values using the argument col.var = "cos2". 
# This produces a map with color gradient, which can be customized using the argument
# gradient.cols; e.g., 

# gradient.cols = c("white", "blue", "red") means that:
# - variable categories with low cos2 values will be colored in "white"
# - variable categories with mid cos2 values will be colored in "blue"
# - variable categories with high cos2 values will be colored in "red"

# OK, now putting all that in practice: 
# Color by cos2 values: quality on the factor map
fviz_mca_var(ob.mca, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, # Avoid text overlapping
             ggtheme = theme_minimal())

# You can change the transparency by cos2 values. 
# Honestly, I prefer the last one, but it's up to you. 
# If you want to try, just uncomment the next 3 rows. 
# fviz_mca_var(ob.mca, alpha.var="cos2",
#             repel = TRUE,
#             ggtheme = theme_minimal())

# It's also possible to visualize the cos2 of row categories on all the dimensions
# using the corrplot package:
library("corrplot")
par(mfrow=c(1,1))
corrplot(var$cos2, is.corr=FALSE)

# Categories Fish_n, Fish_y, Icecream_n and Icecream_y are not very well represented 
# by the first two dimensions. This implies that the position of the corresponding 
# points on the scatter (bi)plot should be interpreted with some caution. 
# For sure, a higher dimensional solution is probably necessary.

### 2.3.3 The contribution of the categories (in %) to the definition of the
# dimensions can be extracted as follows:

head(round(var$contrib,2), 4)

# Categories with larger values contribute the most to the definition of dimensions.
# Categories that contribute the most to Dim.1 and Dim.2 are the most important in
# explaining the variability in the data set.

# Contributions of rows to dimension 1
fviz_contrib(ob.mca, choice = "var", axes = 1, top = 15)
# Contributions of rows to dimension 2
fviz_contrib(ob.mca, choice = "var", axes = 2, top = 15)

# Total contribution to dimension 1 and 2
fviz_contrib(ob.mca, choice = "var", axes = 1:2, top = 15)

# FYI: The red dashed line on the graph above is not arbitrary. It indicates the
# expected average value if the contributions were uniform. 
# Calculations of that are out of the scope of the course. However...
# By noticing how "far" the bars are, and based on your knowledge of Statistical
# Inference, Would you suspect there is evidence to reject "H0: uniform contributions"?
# Personally, I would say so.  

# It can be seen that:
# i) Categories Abdo_n, Diarrhea_n, Fever_n and Mayo_n are the most important in the
# definition of the first component.
# ii) Categories Courg_n, Potato_n, Vomit_y and Icecream_n contribute the most to the
# dimension 2
# iii) The most important (or, contributing) categories can be highlighted
# on the scatter plot as follows:

fviz_mca_var(ob.mca, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, # avoid text overlapping (slow)
             ggtheme = theme_minimal()
)

# This last graph gives an idea of in which direction and in which component the 
# categories are contributing most importantly.
# The Abdo_n, Diarrhea_n, Fever_n and Mayo_n categories have an important 
# contribution in the positive part of the first component, while the Fever_y and
# Diarrhea_y categories have a greater contribution in the negative part of the same
# component.

### 3. Graph of individuals ###
# We can use the function 'get_mca_ind()' to extract the results for individuals. 
# This function returns a list containing the coordinates, the cos2 and the contri
# - butions of individuals:

ind <- get_mca_ind(ob.mca)
ind

# The result for individuals gives the same information as described for variable
# categories. 
# There is no point in repeating all that, right? 
# Here is the display of all that: 

# Get access to the different components by using:
# Coordinates of column points
head(ind$coord)
# Quality of representation
head(ind$cos2)
# Contributions
head(ind$contrib)

# To visualize individuals we use the function fviz_mca_ind() 
# It's also possible to color individuals by their cos2 values (just like categories
# of variables before):

fviz_mca_ind(ob.mca, col.ind = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, # Avoid text overlapping (slow if many points)
             ggtheme = theme_minimal())

# The next R code creates bar plots of individuals cos2 and their contributions:
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
             habillage = "Vomiting", # color by groups
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
fviz_mca_ind(ob.mca, habillage = poison$Vomiting, addEllipses = TRUE)

# To color individuals using multiple categorical variables at the same time, use 
# the function fviz_ellipses():
fviz_ellipses(ob.mca, c("Vomiting", "Fever"),
              geom = "point")

# OR you can specify categorical variable indices:
fviz_ellipses(ob.mca, habillage= 1, geom = "point")
fviz_ellipses(ob.mca, habillage= 1:2, geom = "point")
fviz_ellipses(ob.mca, habillage= 1:3, geom = "point")
fviz_ellipses(ob.mca, habillage= 1:4, geom = "point")

### 4. Supplementary data (ind and vars)
head(poison)

# Supplementary variables and individuals are not used for the determination of
# the principal dimensions. 
# Their coordinates are predicted using only the information provided by the
# performed MCA on active variables/individuals.
# The data doesn't contain supplementary individuals. For demonstration, we'll
# use individuals 53:55 as supplementary individuals.

res.mca <- MCA(poison, 
               ind.sup = 53:55,
               quanti.sup = 1:2, 
               quali.sup = 3:4, 
               graph=FALSE)

# Biplot of individuals and variable categories
fviz_mca_biplot(res.mca, repel = TRUE,
                ggtheme = theme_minimal())

# Blue: Active individuals
# Darkblue: Supplementary individuals
# Red: Active variable categories 
# Darkgreen: Supplementary variable categories 















                
                
                
                
                
                
                
                
                
                
                







































