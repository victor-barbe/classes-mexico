### 4. Factor Analysis of Mixed Data (FAMD) ###
###############################################

# Remember that PCA considers data sets defined on continuous variables.
# CA and MCA considers two and several categorical variables, respectively. 
# Now, Factor Analysis of Mixed Data (FAMD) is kind if a generalization of both, MCA and PCA. 
# FAMD makes it possible to analyze the similarity between individuals by taking into 
# account a mixed type data.
# By mixed type data we mean quantitative and qualitative (or categorical) variables at the 
# the same time. 
# Also, FAMD let us explore the association between all variables, both quantitative 
# and qualitative variables.
# Roughly speaking, the FAMD algorithm can be seen as a mixed between PCA and multiple 
# correspondence analysis (MCA)
# In other words, it acts as PCA for quantitative variables and as MCA for qualitative variables.
# Quantitative and qualitative variables are normalized during the analysis to balance the 
# influence of each set of variables.
# In this practice we show how to compute and visualize FAMD using FactoMineR (for the analysis)
# and factoextra (for data visualization) in R. 


### 1. Computation
## 1.1 Packages 
# First we need to install FactoMineR and factoextra. We've used them before, so we just call
# them into the session: 

library("FactoMineR")
library("factoextra")

## 1.2 Data format
# For this practice, we’ll use a subset of the wine data set available in FactoMineR package
data(wine)
?wine

# 'wine' is a data frame with 21 rows (the number of wines) and 31 columns
# The first column corresponds to the label of origin, the second column 
# corresponds to the soil, and the others correspond to sensory descriptors.

df <- wine[,c(1,2, 16, 22, 29, 28, 30,31)]
head(df[, 1:7], 4)

# To see the structure of the data, use:
str(df)

# The data contains 21 rows (wines, individuals) and 8 columns (variables):
# The first two columns are factors (categorical variables): label (Saumur, Bourgueil or Chinon)
# and soil (Reference, Env1, Env2 or Env4).
# The remaining columns are numeric (continuous variables).
# This is a mixed type data. 
# The goal of this study is to analyze the characteristics of the wines.

## 1.3 R code
# The function FAMD() [in FactoMineR] can be used to compute FAMD. 
# A simplified usage format is :

# FAMD (base, ncp = 5, sup.var = NULL, ind.sup = NULL, graph = TRUE)
# base: this is a data frame with n rows (individuals) and p columns (variables).
# ncp: the number of dimensions kept in the results (by default 5)
# sup.var: a vector indicating the indexes of the supplementary variables (if any)
# ind.sup: a vector indicating the indexes of the supplementary individuals.
# graph : a logical value. If TRUE a graph is displayed.

# To compute FAMD, type this:
# If you haven't call it, now type 
# library(FactoMineR)

ob<- FAMD(df, graph = FALSE)

# The output of the FAMD() function is a list including :
ob  

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

# library("factoextra")
eig.val <- get_eigenvalue(ob)
head(eig.val)

# The function fviz_eig() or fviz_screeplot() [factoextra package] can be used to draw
# the scree plot (the percentages of inertia explained by each FAMD dimensions):
fviz_screeplot(ob)

## 2.2 Graph of variables
# 2.2.1 All variables
# The function get_mfa_var() [in factoextra] is used to extract the results for 
# variables. 
# By default, this function returns a list containing the coordinates, the cos2 and 
# the contribution of all variables:
  
var <- get_famd_var(ob)
var
# The different components can be accessed as follows:
# Coordinates of variables
  head(var$coord)
# Cos2: quality of representation on the factore map
  head(var$cos2)
# Contributions to the  dimensions
  head(var$contrib)

# The following figure shows the correlation between variables - both quantitative 
# and qualitative variables - and the principal dimensions, as well as the 
# contribution of variables to the dimensions 1 and 2. The following functions 
# [in the factoextra package] are used:
    
#  fviz_famd_var() to plot both quantitative and qualitative variables
#  fviz_contrib() to visualize the contribution of variables to the principal
# dimensions

## Plot of variables
  fviz_famd_var(ob, repel = TRUE)

##  Contribution to the first dimension
  fviz_contrib(ob, "var", axes = 1)
  
## Contribution to the second dimension
  fviz_contrib(ob, "var", axes = 2)  

# The red dashed line on the graph above indicates the expected average value, If the contributions 
  # were uniform. pter @ref(principal-component-analysis)).
  
# From the plots above, it can be seen that:
# Variables that contribute the most to the first dimension are: Overall.quality and Harmony.
# Variables that contribute the most to the second dimension are: Soil and Acidity.  
  
# 2.2.2. Quantitative variables
#  To extract the results for quantitative variables, type this:
 quanti.var <- get_famd_var(ob, "quanti.var")
 quanti.var 

# You can visualize quantitative variables and highlight them according to either
 # i) their quality of representation on the factor map 
 # ii) their contributions to the dimensions.

# The R code below plots quantitative variables. We use repel = TRUE, to avoid text 
# overlapping.

fviz_famd_var(ob, "quanti.var", repel = TRUE,
              col.var = "black")

# Briefly, the graph of variables (correlation circle) shows the relationship between 
# variables, the quality of the representation of variables, as well as the correlation 
# between variables and the dimensions. 

# The most contributing quantitative variables can be highlighted on the scatter plot 
# using the argument col.var = "contrib". This produces a gradient colors, which can be 
# customized using the argument gradient.cols.

fviz_famd_var(ob, "quanti.var", col.var = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)

# Similarly, you can highlight quantitative variables using their cos2 values 
# representing the quality of representation on the factor map.
# If a variable is well represented by two dimensions, the sum of the cos2 is closed to
# one. 
# For some of the items, more than 2 dimensions might be required to represent them
# reasonably well. 

fviz_famd_var(ob, "quanti.var", col.var = "cos2", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)


# 2.2.3 Graph of qualitative variables
# Like quantitative variables, the results for qualitative variables can be extracted 
# as follow:
  
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
  
# 2.3 Graph of individuals
# You can get the FAMD results for individuals by typing:
  
ind <- get_famd_ind(ob)
ind
# To plot individuals, use the function fviz_mfa_ind() [in factoextra].
# By default, individuals are colored in blue and categories in black- 
fviz_famd_ind(ob, #col.ind = "cos2", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)

#  However, like variables, it’s also possible to color individuals by their cos2 and 
# contribution values:
fviz_famd_ind(ob, col.ind = "cos2", 
                gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                repel = TRUE)
fviz_famd_ind(ob, col.ind = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)

# In the plot above, the qualitative variable (categories) are shown in black. Env1, Env2,
# Env3 are the categories about type of soil.
# Saumur, Bourgueuil and Chinon are the categories of the wine Label. 

# Individuals with similar profiles are close to each other on the factor map.

# Note that it’s possible to color the individuals using any of the qualitative variables
# in the initial data table.
# To do this, the argument habillage is used in the fviz_famd_ind() function.
# For example, if you want to color the wines according to the supplementary qualitative
# variable “Label”, type this:
  
fviz_mfa_ind(ob, 
             habillage = "Label", # color by groups 
             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
             addEllipses = TRUE, ellipse.type = "confidence", 
             repel = TRUE # Avoid text overlapping
) 
  
?fviz_mfa_ind

# If you want to color individuals using multiple categorical variables at the same time, 
# use the function fviz_ellipses() [in factoextra] as follows

fviz_ellipses(ob, c("Label", "Soil"), repel = TRUE)

# OR you can specify categorical variable indices:
fviz_ellipses(ob, 1:2, geom = "point")




































































































































