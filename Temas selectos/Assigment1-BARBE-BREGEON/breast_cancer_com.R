### THE breast cancer  CASE ###

# We use setwd to set the path to the dataset 
# read it with read.csv

setwd("C:/Users/antoi/Documents/Antoine/Udlap/Selected_topic/Tache_1")
data <-read.csv("breast-cancer_mean-2.csv", header=TRUE)

# This dataset was huge with more than 500 line and 32 columns
# We decided to reduce the number of columns to 9 and keep the most relevant of them 
# We decided to reduce also the number of line. We now have 60 rows in our dataset. 
# Has we are more use to python we have done these first steps in python
data <- data[,-1]
data <- data[,-10]
data <- data[,-8]

nrow(data)
ncol(data)

# The variables are: 
# X_1: radius
# X_2: texture
# X_3: perimeter
# X_4: area
# X_5: smoothness
# X_6: compactness
# X_7: concavity
# X_8: symmetry

# The first 30 patient have a positive diagnostic and the last 30 have a 
# negative diagnostic

### 0. Correlations
spa<-data
pairs(spa)

# Their is a high correlation between each pairs of variables.
# With this correlation we can apply PCA to this dataset. It should be possible 
# to reduce the number of dimension 

# Numerical correlations:
round(cor(spa),2)
# All pairs go from moderate to strong correlations. 

### 1. Eigen analysis

# The data is heterogeneous with not the same unit so we need to standardize it
# The data are not one the same scale so we have have to scale it
# in order that all variable have the same weight

# We also have to perform centralization of the dataset 

?prcomp
eig<-prcomp(spa, center = TRUE, scale. = TRUE)
eig

### 2. Eigenvalues

# These are the eigenvalues; i.e., the variances of the PCs
(lam<-eig$sdev^2) 

# plot of lambdas per component
plot(eig)

# If we take just the first PC it includes only  half of the total variation in the entire dataset. 
# It's not enough to represent the entire variation of the data 

# but the second Pc is also important and with the both it include 
# the great majority of total variation
# We can represent the 8-dimensional data in just 2, without a significant distortion


# We calculate the PROPORTION OF VARIATION of each Pc in order to chose how many 
# we have to take 
(per_var<-round(lam/sum(lam),3))

0.490+0.298
# 49% of the total variation is explained just by z1!
# 29,8% of the total variation is explained by z2

# if we take z1 y z2 it only represente 78,8% de la variation

# we can represent the whole data in 8 dimensions in basically 
# 1 dimension with around 50% of accuracy. 
# we can represent the whole data in just 2 dimensions with 82% of 
# accuracy.
# We might take z3 also but is it to small that it can be considered as noise.

# According to the scree test, we identify the point where the 
# eigenvalues become too small, we can identify that after the two first components
# the importance of other components become too small.

# Scree-plot
plot(seq(1,8), per_var, type="b", xlab="Principal Component",
     ylab="Proportion of variance explained", main="Scree plot")

# The proportion of variance seems to level off from the 3rd PC. Then, maybe
# we should retain a maximum of 2 PCs. 

### 3. The eigenvectors
# The eigenvectors are contained in
eig$rotation

# Columns represent the eigenvectors, the row represents each variable of 
# the dataset.
# This show the decomposition of the eigenvector threw each variable

# In order to verify that the operation is correct: 
# the sum of the squares of the components of the eigenvectors 
# must be equal to 1
apply(eig$rotation^2,2,sum) # Every thing is good. 

### 4. The scores on the PCs
 
# These scores of PCs are contained in eig$x. This contains 60 observations. 
# To get a taste of it, let's use 'head()', it print the 6 first row

head(eig$x)

# This is: the first row corresponds to the original variables measured on 
# the first patient, but now expressed as PCs.
# The other row works the same way

# Has said before the two first PC represent the majority of variation
# So we just need to keep them and ignore the others

### 5. Plotting (projecting) the data into two dimensions 
# Keeping just the first two PCs:
pc2<-eig$x[,1:2]

# 5.1 The SCORE PLOT
plot(pc2[,1], pc2[,2], xlab="PC1", ylab="PC2", ylim=c(-5,5), xlim=c(-5,5),
     main="Score plot")
abline(h=0, v=0, lty=2, col="red", lwd=1)

# In the original configuration we couldn't plot the 8 dimension variable
# But now the original 8 dimension data can be plot with 2 dimension. 
# Doing so involves distortion. In this case the distortion is less than 20%
# This projection is 80% accurate! 

# Visualizing positive
points(pc2[31:60,1],pc2[31:60,2], col="red", pch=16)

# Visualizing negative
points(pc2[1:30,1],pc2[1:30,2], col="blue", pch=16)
abline(v=0.4, lty=2, col="grey44")
abline(h=c(-2.5,2.3), lty=2, col="grey44")

# We can see a clear difference between the two groups. 
# The biggest difference is in the PC1, has we can see a huge difference on the X axis
# The cancer patients have positive values of PC1 and concentrates around 0
# of value on PC2. They have higher means contents

# In the other side the non diagnostics patient have lower means constant
# Their value of PC2 are more extend and extreme

# The lecture is: the difference is done mostly on the size of the tumor, and
# other high parameter.


### 7. The BIPLOT: showing scores and loading vector ($rotation)
# The aim of the biplot is to show PC score and loading vector in the same plot 

# the plot of the score is quite similar to the previous One
# the vectors represent the original variables and their importance on each PC. 
# The length of arrows is proportional to its variance.

round(cor(spa),2)
round(eig$rotation,2)
eig$x[,1:2]

# The direction of vector give us information on the correlation:
# two vectors with similar or opposite direction have a strong correlation.
# If the vectors are orthogonals to other they have a small correlation 

#scaled axis
biplot(eig, col=c("coral2","skyblue"))

# To notice the influence of each variables on PC1 and PC2 
# you have to measure the distance projecting the vector on axis 




















