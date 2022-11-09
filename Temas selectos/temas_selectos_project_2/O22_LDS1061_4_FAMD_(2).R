### FAMD: Sparrows, revisited ###

### 0. Importing data
nsp<-read.csv("/Users/victorbarbe/Desktop/temas_selectos_project_2/sp2.csv")[,-1]

# Structure
str(nsp)

# This contains now 7 variables; 5 numeric and two categorical (V6 and V7)
# V6 refers to "location" (places where the sparrows are from - specific
# zones in the vicinity of Bumpus' lab, in Rhode Island)
# V7 refers to "color" (color of the sparrow).

# Changing to factors: 
nsp[,6]<-as.factor(nsp[,6])
nsp[,7]<-as.factor(nsp[,7])

str(nsp) 
df<-nsp
# Now they're factors each w/ 3 levels (categories)

# Remember: The individuals from row 1 up to 21, survived. From row 22 to 49, died.
# It'd be useful to add a "label" variable indicating whether the sparrow survived.
df[,8]<-as.factor(c(rep("S",21),rep("N",28)))
str(df)



# The question that leads this analysis is the following: 
# Q: Is there any association between survivors-nonsurvivors and 
# location and color?

# Descriptive analysis: 
summary(df[1:21,])
summary(df[22:48,])

# Apparently, there is a relationship between sparrows from location A and chances
# to survive
# Also there seems to be a relationship between sparrow from location B and C and
# chances of non surviving. 
# Regarding color...there seems to be no relationship between sparrows' color and
# surviving or not. Thus, color seems to be random regarding chances of surviving. 

# We'd like to get a visual impression of that possible relationship. 

### 1. Computation
# First we need to call FactoMineR and factoextra. 
library("FactoMineR")
library("factoextra")

# To compute FAMD, type this:
# If you haven't call it, now type 
# library(FactoMineR)

ob<- FAMD(df, graph = TRUE)

### 2. Visualization and interpretation
# For this part we’ll use the following factoextra functions:
# 1. get_eigenvalue(ob): Extract the eigenvalues/variances retained by each dimension.
# 2. fviz_eig(ob): Visualize the eigenvalues/variances.
# 3. get_famd_ind(ob): Extract the results for individuals.
# 4. get_famd_var(ob): Extract the results for quantitative and qualitative variables.
# 5. fviz_famd_ind(ob), fviz_famd_var(ob): Visualize the results for individuals and 
# variables, respectively.

## 2.1 Eigenvalues / Variances
# The proportion of variances retained by the different dimensions can be extracted 
# using the function get_eigenvalue() [factoextra package] as follows:

eig.val <- get_eigenvalue(ob)
head(eig.val)

# Notice that 52% of the variability is explained by the first 2 PCs. Not that good, 
# but...

# The function fviz_eig() or fviz_screeplot() can be used to draw the scree plot 
fviz_screeplot(ob)

# The change of explained variation going from 2 to 3 dimensions is small; i.e., 
# variability covered by dim3 is still important! (as well as that covered by dim4 
# and still dim5)
# Considering one more dim, we would cover 64%!
# It's unfortunate not to get that in the plane...

## 2.2 Graph of variables
# 2.2.1 All variables
# The function get_mfa_var() is used to extract the results for variables. 
# This returns a list containing the coordinates, the cos2 and the contribution of all 
# variables:

var <- get_famd_var(ob)
var

# The different components can be accessed as follows:
# Coordinates of variables
head(var$coord)

# Cos2: quality of representation on the factor map (meaning how much of a variable is 
# represented in a given component.)
head(var$cos2)

# Contributions to the  dimensions
head(var$contrib)

# The following figure shows the correlation between variables - both quantitative 
# and qualitative variables - and the principal dimensions, as well as the 
# contribution of variables to the dimensions 1 and 2. 

#  fviz_famd_var(): plots both quantitative and qualitative variables
#  fviz_contrib(): plots the contribution of variables to the principal dimensions

## Plot of variables
fviz_famd_var(ob, repel = TRUE)

##  Contribution to the first dimension
fviz_contrib(ob, "var", axes = 1)
# All the numeric variables are contributing a lot for to define the first axis

## Contribution to the second dimension
fviz_contrib(ob, "var", axes = 2)  
# Axis 2 is made of (basically) the influence of the factor variables

# The red dashed line on the graph above indicates the expected average value,
# if the contributions were uniform. 

# 2.2.2. Quantitative variables
#  To extract the results for quantitative variables, type this:
quanti.var <- get_famd_var(ob, "quanti.var")

# You can visualize quantitative variables and highlight them according to 
# either
# i) their quality of representation on the factor map 
# ii) their contributions to the dimensions.

# The R code below plots quantitative variables. We use repel = TRUE, to 
# avoid text overlapping.

fviz_famd_var(ob, "quanti.var", repel = TRUE,
              col.var = "black")

# The correlation circle shows the relationship between variables, the quality of 
# the representation of variables, as well as the correlation between variables and
# the dimensions. 

# The most contributing quantitative variables can be highlighted on the
# scatter plot using the argument col.var = "contrib". This produces a 
# gradient colors, which can be customized using the argument gradient.cols.

fviz_famd_var(ob, "quanti.var", col.var = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)

# Notice how they all form a bunch of variables, meaning that they all are closely 
# related. This makes sense: they all measure an aspect of size about the sparrows. 

# We can highlight quantitative variables using their cos2 values representing
# the quality of representation on the factor map.
# If a variable is well represented by two dimensions, the sum of the cos2
# is closed to one. 
# For some of the items, more than 2 dimensions might be required to 
# represent them reasonably well. 

fviz_famd_var(ob, "quanti.var", col.var = "cos2", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)

# 2.2.3 Graph of qualitative variables
# Like quantitative variables, the results for qualitative variables can
# be extracted as follows:

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

# In a sense, red sparrows are more associated to location A and to a lesser
# extent, to C. They're not that related to B. 
# Brown sparrows are more related to locations A and C, not that much to B. 
# Yellow, somehow, seems to be "halfway" between all locations. 

# 2.3 Graph of individuals
# You can get the FAMD results for individuals by typing:

ind <- get_famd_ind(ob)
ind
# To plot individuals, use the function fviz_mfa_ind() [in factoextra].
# By default, individuals are colored in blue and categories in black- 
fviz_famd_ind(ob, #col.ind = "cos2", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)
# Apparently, A is more surrounded by "survivors"
# B and C are more surrounded by "non-survivors"
# Color seems to be kind of independent of location or S or N. 

#  Like variables, it’s also possible to color individuals by their cos2 and contribution
# values:
fviz_famd_ind(ob, col.ind = "cos2", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)
fviz_famd_ind(ob, col.ind = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)

# Notice that qualitative variables (categories) are shown in black. 
# Individuals with similar profiles are close to each other on the factor map.

# Note that it’s possible to color the individuals using any of the qualitative variables
# in the initial data table.

# If you want to color individuals using multiple categorical variables at the same time, 
# use the function fviz_ellipses() [in factoextra] as follows

fviz_ellipses(ob, c("V6","V8"), repel = TRUE)
fviz_ellipses(ob, c("V7","V8"), repel = TRUE)
fviz_ellipses(ob, c("V6","V7"), repel = TRUE)


# Bottomline:

# 1. From the plot V6-V8, on the left, it seems that location A is 
# surrounded mainly by sparrows that survived
# Locations B and C appear more similar, in the sense that they are surrounded 
# mainly by sparrows that didn't survive. 

# 2. From the plot V7-V8, it seems that color doesn't seem to be related to 
# to survivors or non-survivors

# 3. From plot V6-V7, it seems that color doesn't seem to be related anyhow to
# location; i.e., the distribution of color seems to be random. 



















