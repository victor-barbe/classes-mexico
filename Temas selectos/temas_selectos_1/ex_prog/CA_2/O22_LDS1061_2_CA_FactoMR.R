### CA 2: Using FactoMineR + factoextra###

# We continue with (simple) correspondence analysis (CA). 
# As we already know, this is used to analyze frequencies in a contingency table.
# A typical question in this context is whether certain row elements are associated
# with some elements of column elements.
# As a result of CA we obtain factor scores (coordinates) for both row and column 
# points
# These coordinates let us visualize graphically the association between rows and
# columns in a low dimensional space. 
# Ultimately, the aim is to have a global view of the data that is useful for
# interpretation.
# Here we show how to use 'FactoMineR' for performing CA and 'factoextra' for 
# visualizing. 

### 0. Installing pakcages
# To install both packages type this:
# install.packages(c("FactoMineR", "factoextra"))
# Once installed, call them: 

library("FactoMineR")
library("factoextra")

### 1. Data format
# The data should be a contingency table. We'll use the demo data sets housetasks
# in factoextra. 
library(ca)

tab <- cbind(Benito = c(52,	12,	0,	3,	30,	3,	0,	52) ,
             Rosa = c(31,	8,	0,	50,	10,	30,	0,	52) ,
             Mario = c(9,	56,	0,	0,	10,	18,	0,	52),
             Eugenia = c(20,	19,	0,	12,	30,	50,	0,	52),
             Dara = c(0,	0,	52,	0,	0,	0,	52,	0))
rownames(tab) <- c("Cook_pasta","Cook_meat","Cook_pizza","Dessetrs","Cut_vegetables",
                   "Entries","Beverages","Wash_dishes")


print(tab)
tab <- as.table(as.matrix(tab))
#data(housetasks)
#head(housetasks) # visualizing just the first 6 rows of the object
#help("housetasks")

# The data is a contingency table with 13 housetasks and their division in a 
# couple. 
# Rows are the different tasks 
# Columns are referred to who perform the task. 

### 2.  Plotting contingency tables and chi-square test
# Housetasks - Laundry, Main_Meal and Dinner - appear to be done more frequently 
# by the Wife.
# Repairs and driving are dominantly done by the husband.
# Holidays are more associated with the column "jointly".

# A contingency table can be visualized using the functions 'balloonplot()' or 
# 'mosaicplot()'
# 1st, install the package:
# install.packages("gplots")
# Then, call it:

library("gplots")
# First convert the data as a table
dt <- as.table(as.matrix(housetasks))
# Now, use the function: 
balloonplot(t(dt), main ="housetasks", xlab ="", ylab="",
            label = FALSE, show.margins = FALSE)

# i.e., this plot highlights cells with high frequency by using a large 
# ballon and viceversa. This makes easier to identify relationships. 
# Row and column sums are printed by default in the bottom and right margins,
# respectively. We ask the function to hide these values using the argument 
# show.margins = FALSE.

# We can use the Chi-square test to evaluate whether there is a significant
# relation between rows and columns:

tst <- chisq.test(housetasks)
tst

## Pearson's Chi-squared test
##
## data: housetasks
## X-squared = 1944.5, df = 36, p-value <2e-16

# Remember: the test consists in the following hypotheses: 
### H0: "there is no relationship between categories (row vs columns)
### HA: "there is a relationship between categories 

# The pvalue is really small; hence, there is a lot of evidence against H0. 
# We reject H0 favoring HA. 

### 3. Computing CA 
# Use the function CA() to perform CA. A simplified format is
# CA(X, ncp = 5, graph = TRUE)
# X : a data frame (contingency table)
# ncp : number of dimensions kept in the final results.
# graph : a logical value. If TRUE a graph is displayed.

# To compute correspondence analysis, do the following:
ob.ca <- CA(housetasks, graph = FALSE)

# The output a list including various pieces of information.
ob.ca

### 4. Visualization and interpretation
# The first step is to evaluate whether there is a significant relationship
# between the rows and columns.This is done with the Chi-Square test. 
# As we know, the test was significant. However, it also appears at the 
# beginning of the output ob.ca. 

# As in PCA, we examine the eigenvalues to determine the number of axis to 
# consider when representing the data in a few dimensions. 
# The eigenvalues and the proportion of variances retained by the different
# axes can be extracted using 'get_eigenvalue()'.

eig.val <- get_eigenvalue(ob.ca)
eig.val

# Eigenvalues represent the amount of information retained by each axis.
# Dimensions are ordered decreasingly and listed according to the amount of
# variance explained.
# Dimension 1 explains the most variance (49%, roughly), followed by dimension 
# 2 (40% roughly), etc.
# The first two dimensions cover 88.6% of the variation in the data. Sounds good. 

# We can also rely (visually) in the scree plot: 
fviz_screeplot(ob.ca, addlabels = TRUE, ylim = c(0, 60))

# visually, it's pretty clear that a 2 dim solution is OK. 

# The next piece of R code draws the scree plot with a red dashed line 
# specifying the average eigenvalue:
fviz_screeplot(ob.ca) +
geom_hline(yintercept=33.33, linetype=2, color="red")

# Since there are 3 components, the average eigenvalue should cover 1/3 of the
# total variation. Notice the first two are above the average; thus, this 
# confirms chosing 2-dim as a solution. 

# Biplot
# We can now draw the biplot by using this function: 
fviz_ca_biplot(ob.ca, repel = TRUE)
# repel= TRUE avoids text overlapping (slow if many point)

# The graph above is called SYMMETRIC PLOT, and shows the global pattern 
# in the data.
# Rows are represented by blue points and columns by red triangles.
# The distance between any row points or column points gives a measure of 
# their similarity. 
# Row points with similar profile are close on the factor map. 
# The same holds true for column points. 

# What we conclude just by watching the raw data is confirmed her in the biplot.
# Notice that around "Husband" and "Wife" there are some tasks, as well as
# "Alternating" and "Jointly". What we identified in the crosstab here is shown
# visually. 

# Symetric plot represents the row and column profiles simultaneously in a 
# common space. 
# In this case, only the distance between row points or the distance between 
# column points can be really interpreted.
# The distance between any row and column items is not meaningful! 
# In order to interpret the distance between column and row points, the column 
# profiles must be presented in row space or vice-versa. This is called
# asymmetric biplot. 

# The next step for the interpretation is to determine which row and column 
# variables contribute the most in the definition of the dimensions retained 
# in the model.

#### Graph of row variables
# The function get_ca_row() is used to extract the results for row variables.
# This function returns a list containing 
# -- the coordinates,
# -- the cos2, 
# -- the contribution and the variance row variables. 
 
row <- get_ca_row(ob.ca)
row

# The components in 'row' can be used in the plot of rows as follows:
# row$coord: coordinates of each row point in each dimension (1, 2 and 3).
# Used to create the plot.
# row$cos2: quality of representation of rows.
# var$contrib: contribution of rows (in %) to the definition of the dimensions.

# To get a taste of them, try:
# Coordinates
head(row$coord)
# Cos2: quality on the factore map
head(row$cos2)
# Contributions to the principal components
head(row$contrib)

# row$coord shows the coordinates of each row point in each dimension 
# If we'd like to visualize only row points: 
fviz_ca_row(ob.ca, repel = TRUE)

# You might like to change color or symbol, like in here:
fviz_ca_row(ob.ca, col.row="darkorange", shape.row = 14)

# REMARKS: 
# -- Rows with a similar profile are grouped together.
# -- Negatively correlated rows are positioned on opposite sides of the plot 
# origin (opposed quadrants).
# -- The distance between row points and the origin measures the quality of 
# the row points on the factor map.
# -- Row points that are away from the origin are well represented on the 
# factor map.

### About the quality of representation of rows
# The result of the analysis shows that the contingency table has been 
# successfully represented in 2-dim. Both cover 88.6% of the total (variation)
# in the data.
# However, not all the points are equally well displayed in this reduced space

# The quality of representation of the rows on the biplot is called the 
# squared cosine (cos2) or the squared correlations.

# The cos2 measures the degree of association between rows/columns and a 
# particular axis. The cos2 of row points can be extracted as follow:

head(row$cos2, 4)

# The values of the cos2 are between 0 and 1. The sum of the cos2 for rows 
# on all the CA dimensions is equal to one.

apply(row$cos,1,sum)

# The quality of representation of a row or column in n dimensions is simply 
# the sum of the squared cosine of that row or column over those n dimensions.
# In this case, we'd like to consider the sum over the first two dimensions. 

round(1-row$cos[,3],2)

# As can be seen, most of row points are well represented. Finances is practi
# -cally nailed. The row point that is worst represented is Official (which 
# happens to be quite well represented over the third component).   

# We can represent via colors how well a row point is represented in the biplot. 
# Color by cos2 values: quality on the biplot
fviz_ca_row(ob.ca, col.row = "cos2",
gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
repel = TRUE)

# As before, practically all of them are very well represented, except for 
# Official. 

# You can visualize the cos2 of row points on all the dimensions using the
# corrplot package:
library("corrplot")
corrplot(row$cos2, is.corr=FALSE)

# As you can see, Official is quite well associated with dim 3. 
# We can also create a bar plot of rows' cos2 over the first 2 dim. 
fviz_cos2(ob.ca, choice = "row", axes = 1:2)

# The position of the point Official on the biplot should be interpreted with 
# some caution. 
# A higher dimensional solution is probably necessary for that point. 

### Contributions of rows to the dimensions (Components)
# The contribution of rows (in %) to the definition of the dimensions can be extracted
# as follows:
row$contrib

# The row variables with the larger value, contribute the most to the definition of
# the dimensions. 

# Notice how Official and Driving contribute a lot defining Dim3! 

# Rows that contribute the most to Dim.1 and Dim.2 are the most important in explaining
# the variability in the data set.
# Rows that do not contribute much to any dimension or that contribute to the last 
# dimensions are less important.
# It’s possible to use the function corrplot() to highlight the most contributing row
# points for each dimension:

library("corrplot")
corrplot(row$contrib, is.corr=FALSE)
?corrplot

apply(row$contrib,2,sum)

# The function fviz_contrib() can be used to draw a bar plot of row contributions.
# If the data contains many rows, you can decide to show only the top 
# contributing rows. 
# The R code below shows the top 10 rows contributing to the dimensions:

# Contributions of rows to dimension 1
fviz_contrib(ob.ca, choice = "row", axes = 1, top = 10)
mean(row$contrib[,1])

# Contributions of rows to dimension 2
fviz_contrib(ob.ca, choice = "row", axes = 2, top = 10)
mean(row$contrib[,2])

# Total contribution in both dimension 1 and 2
fviz_contrib(ob.ca, choice = "row", axes = 1:2, top = 10)
rev(sort(apply(row$contrib[,1:2],1,mean)))

# The row items Repairs, Laundry, Main_meal and Driving are the most 
# important in the definition of the first dimension.
# The row items Holidays and Repairs contribute the most to dimension 2.

# The most important (or, contributing) row points can be highlighted on
# the scatter plot as follow:
fviz_ca_row(ob.ca, col.row = "contrib",
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)

# Row categories Repair and Driving have an important contribution to the
# positive side of the first dimension, while the categories Laundry and
# Main_meal have a major contribution to the negative side of the first
# dimension; etc, ....
# In other words, dimension 1 is mainly defined by the opposition of 
# Repair and Driving (positive side), and Laundry and Main_meal (negative
# side).
                
#### Graph of column variables
# The function get_ca_col()  is used to extract the results for column 
# variables. This function returns a list containing the coordinates, the
# cos2, the contribution and the variance of columns variables:                                                                      

col <- get_ca_col(ob.ca)
col

# The result for columns gives the same information as described for rows. 

# The fviz_ca_col() is used to produce the graph of column points. To create a 
# simple plot, type this:
fviz_ca_col(ob.ca)

# Like row points, it's also possible to color column points by their cos2 values:
fviz_ca_col(ob.ca, col.col = "cos2",
gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
repel = TRUE)

# Recall the value of the cos2 is between 0 and 1. A cos2 closed to 1 corresponds 
# to a column/row variables that are well represented on the factor map.
# Note that, only the column item Alternating is not very well displayed on the 
# first two dimensions. The position of this item must be interpreted with caution
# in the space formed by dimensions 1 and 2.

# To visualize the contribution of rows to the first two dimensions, type this:
fviz_contrib(ob.ca, choice = "col", axes = 1:2)