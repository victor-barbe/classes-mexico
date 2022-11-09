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

# Now let's consider the dataset 'tea': 
data(tea)
head(tea)

# Some info about the tea dataset: 
help(tea)

# The dataset "tea" used in this study concern a questionnaire on tea. 
# It shows the response of 300 individuals on how they drink tea over 18 questions, 
# how they consider their product on 12 questions and finally some personal details on 4 questions. 

# Number of rows and columns inside tea dataset
dim(tea)

# Individuals we're going to use: from row 1 to 300 ("Active individuals")
# Variables to consider: columns 4, 7, 8, 9 and 11 ("Active variables")

### 1.1. Data Format: 
active<-tea[, c(4, 7, 8, 9, 11)]

head(active)

### 1.2 Summary

# It gives us the repartition of variables in our categorical variables
summary(active)[,1:5]

# Or visually: 

# We can plot our five categorical variables here
par(mfrow=c(1,5))
for(i in 1:5){
  plot(active[,i], main=colnames(active)[i], ylab="counts", col="skyblue",
       ylim=c(0,300))
}

### 1.3 R Code

# help(MCA)
# We apply MCA and get and idea of the importance of each categorical variable 
# for Dim1 and Dim2
ob.mca<-MCA(active, ncp = 5, graph=TRUE)

# - ncp: number of dimensions kept in the results (by default 5)
# - graph=TRUE is the default option. 

### 2. Visualization and interpretation
# 2.1 Eigenvalues (a.k.a., variances)
eigenvals<-get_eigenvalue(ob.mca)
eigenvals

# Eigen value sum is equal to 1
sum(eigenvals[,1])

# Visualizing the variances
# We have Dim1 equal to 27,7% and Dim2 equal to 20,2%.
# Both of them explains the dataset with 47,7% of accuracy
fviz_screeplot(ob.mca, addlabels=TRUE, ylim=c(0,50))

# 2.2 Biplot
# Here's a biplot representing both categorical variables and individuals. 
# The closer 2 points are, the more related they are. The higher they are on x or y axis, 
# The most influencial they are on Dim1, Dim2 respectively. 
fviz_mca_biplot(ob.mca, 
                repel=TRUE
)

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
# This plot is showing the influence of each categorical variables over Dim1 and Dim2. 
# The higher they are on x or y axis, 
# The most influencial they are on Dim1, Dim2 respectively. 

fviz_mca_var(ob.mca, choice = "mca.cor",
             repel = TRUE, # Avoid text overlapping (slow)
             ggtheme = theme_minimal())

# Here we can say that work, resto and tearoom are more influencing Dim1 than home and lunch
# While home, lunch and tearoom are more influencing Dim2 than work and resto

round(var$coord, 2)
head(round(var$coord, 2),4)

# Here we are doing the same than previously but on every variables inside the categorical variables of our dataset. 
# Two variables on opposite quadrants are negatively correlated such as work/not.work, home/not.home, tearoom/not.tearoom
# Similar variables are grouped together in the same quadrant, such as not.tearoom and not.home.
# Distance between points and origin define the quality of their representation on the factor map. 
# The factor map is a tool used to better understand clusters formed by correlated variables. 
# The more a category point is far from the origin, the better he is represented on the factor map. 
fviz_mca_var(ob.mca,
             repel = TRUE, # Avoid text overlapping (slow)
             ggtheme = theme_minimal())

# 2.3.2  Quality of representation of variable categories
# The two dimensions 1 and 2 are sufficient to retain 47,9% of the total variation
# in the data, which is not really accurate. We have to find a way to measure how well data is represented.
# That's were cos2 is useful. It gives the relation between variables and axis (here, Dim1 and Dim2)

# The cos2 of variable categories can be extracted as follows:

head(var$cos2, 4)

# The more cos2 is close to 1, the more the related row/variable is well represented in 2 dimensions

# Color by cos2 values: quality on the factor map
fviz_mca_var(ob.mca, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, # Avoid text overlapping
             ggtheme = theme_minimal())
# Here, we can see that variables such as tearoom are much more "important" than work related to Dim1 and Dim2. 

# However the previous plot gives us only the cos2 values associated to the categorical variables for Dim1 and Dim2
# Thanks to corrplot, we will do it for the 5 dimensions we could build. 
library("corrplot")
par(mfrow=c(1,1))
corrplot(var$cos2, is.corr=FALSE)
# It gives us a really good visualisation on how specific variables are influent over dimensions
# For example, work is a bit influential for Dim1, and totally inexistant over Dim2 and Dim3 while 
# being the most influential variable over Dim4. 

### 2.3.3 The contribution of the categories (in %) to the definition of the
# dimensions can be extracted as follows:

head(round(var$contrib,2), 4)

# Contributions of rows to dimension 1
fviz_contrib(ob.mca, choice = "var", axes = 1, top = 15)
# Contributions of rows to dimension 2
fviz_contrib(ob.mca, choice = "var", axes = 2, top = 15)

# Total contribution to dimension 1 and 2
fviz_contrib(ob.mca, choice = "var", axes = 1:2, top = 15)

# Here we god the contribution of each variable for Dim1, Dim2 and Dim1-2 respectively. 
# We will notice that tearoom is the most influential one, which could looks quite obvious related to the topic of our study. 
# The red line gives the expected mean of contributions of the variable if the contributions were uniforms
# We can see that it is quite accurate for what we can see of the distribution. It won't be the case for the individuals... 

fviz_mca_var(ob.mca, col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, # avoid text overlapping (slow)
             ggtheme = theme_minimal()
)

# Here, such as for cos2, we have the representation of influence of variables over Dim1 and Dim2, colored by their contribution
# As we have seen, tearoom is by far the most important variable here. 


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
# Here we are doing the same than previously. We are plotting the influence of individuals over Dim1 and Dim2, colored by their cos2. 
# We can see than some values looks quite irrelevant compared to others. 
fviz_mca_ind(ob.mca, col.ind = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, 
             ggtheme = theme_minimal())

# The next R code creates bar plots of individuals cos2 and their contributions:
# Cos2 of individuals
fviz_cos2(ob.mca, choice = "ind", axes = 1:2, top = 20)

# this representation of the highest cos2 values of individuals is quite uniform because our 
# dataset is 300 rows long. 

# Contribution of individuals to the dimensions
# This representation is more representative of the disparities we have through the repartition of contribution over the rows
# We can see that those 20 rows are contributing to approximately 30% on Dim1 and Dim2. 
# In other terms, 6,66% of the data are contributing for the third of our dimensions. 

fviz_contrib(ob.mca, choice = "ind", axes = 1:2, top = 20)

# The next piece of R code colors the individuals by groups using the levels of the
# variable lunch. 
# It display confidence ellipse. It shows where the cluster of data for each variables is. 
# The smaller this ellipse is, the more accurate the center of the cluster is. 
# If the ellipse are not overlapping, we can say that there is a real distinction between them. 
fviz_mca_ind(ob.mca,
             label = "none", # hide individual labels
             habillage = "lunch", # color by groups
             palette = c("#00AFBB", "#E7B800"),
             addEllipses = TRUE, ellipse.type = "confidence",
             ggtheme = theme_minimal())


fviz_ellipses(ob.mca, c("lunch", "work", "home", "tearoom", "resto"),
              geom = "point")
# Finally, throughout our study we have plotted the distribution of the influence of the categorical variables
# over Dim1 and Dim2. The closer they are to each other, the more they are related. 
# With the different plot, the ellipses and our study in general we can answer to our initial question and  conclude that : 
# lunch tea looks more associated to not drinking tea in restaurant, at work or oustide than in a tearoom. 

