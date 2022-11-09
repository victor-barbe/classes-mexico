### THE SPARROWS-AFTER-THE-STORM CASE ###
#########################################

# On FEB 1, 1898, after a severe storm, a number of moribund sparrows were 
# taken to Hermon Bumpus' biological laboratory at Brown University, Rhode 
# Island. Some of them survived, some of them died. The question of interest:
# Was there any morphological difference between survivors and non-survivors? 

# Bumpus measured 5 morphological variables on each sparrow. 

# Let's call the data set 'sparrows', in the package 'mAr'(if no installed, 
# install it first).  
# Go to Tools -> Install Packages -> mAr
# Once installed: 

library(mAr)
data(sparrows)

# Some info: 
?sparrows

# Howe the data look: 
sparrows

# The variables (all measured in mm) are: 
# X_1: Total length
# X_2: Alar extent 
# X_3: Head and beak length
# X_4: Humerus length
# X_5: Sternum length 

# The individuals from row 1 up to 21 survived. From row 22 to 49, died.

### 0. Correlations
spa<-sparrows
pairs(spa)

# High correlations between each pair of variables.
# These are good news: we expect to considerably reduce the number of 
# dimensions of the data. 

# Numerical correlations:
round(cor(spa),2)
# All pairs go from moderate to strong (linear) correlations. 

### 1. Eigenanalysis
# REMEMBER: We need to decide about standardizing the data! 

# Since all variables are morphological and measured in the same units, 
# perhaps is important to keep their original variability. However, later
# we'll do this standardizing for comparison purposes. 

# Although we're not scaling right now, we do center the data matrix. 
# The argument 'center' in 'prcomp' is TRUE by default. 

?prcomp
eig<-prcomp(spa, center = TRUE, scale. = FALSE)

### 2. Eigenvalues 
# The eigenvalues of the C matrix (variances of the Zis) are
(lam<-eig$sdev^2) # These are the eigenvalues; i.e., the variances of 
# the PCs

# Remember! The sum of 'lam' should be equal to the sum of all different
# sample variances (per variable)

# Variances of the observations in each variable:
sum(diag(cov(spa)))

# Variances along the PCs
sum(lam) 

# There you go. 

# It's helpful to get a plot of lambdas per component
plot(eig)

# Again, the first PC encompasses the GREAT MAJORITY of the total variation
# in the data!
# We can represent the 5-dimensional data in just 1, and the distortion will
# be just minimum. 

# But how much of the total variation is encompassed in each PC?
# We calculate the PROPORTION OF VARIATION explained by each Zi
(per_var<-round(lam/sum(lam),3))

# Around 86% of the total variation is explained just by Z1! 
# Around 11% explained by Z2.
# Altogether, they explain almost 98% of the variability in the data
0.862+0.113

# This is: we can represent the whole data in 5 dimensions in basically 
# 1 dimension with around 86% of accuracy. 
# OR: we can represent the whole data in just 2 dimensions with 98% of 
# accuracy. Sounds like we should take it, right? 
# In a sense, the remaining variability (dispersed along the 3 remaining 
# components) is so small that might be considered just "noise". 

# In fact, plotting the amount (or proportion) of variance per PC is called
# a scree-plot, a useful graphical tool for deciding on the number of PCs 
# to keep. 
# A scree plot always displays the eigenvalues in a downward curve, ordering
# the eigenvalues from largest to smallest.
# According to the scree test, we identify the "elbow"of the graph where the 
# eigenvalues seem to level off, and components to the left of this point 
# should be retained as significant.

# Scree-plot
plot(seq(1,5), per_var, type="b", xlab="Principal Component",
     ylab="Proportion of variance explained", main="Scree plot")

# The proportion of variance seems to level off from the 3rd PC. Then, maybe
# we should retain a maximum of 2 PCs. 

### 3. The eigenvectors
# The eigenvectors are contained in
eig$rotation

# Columns represent the eigenvectors; i.e., their components are the 
# coefficients such that in a linear combination with the original variables
# give the PCs, Zis. 

# Verifying the condition: the sum of the squares of the components of the 
# eigenvectors is 1
apply(eig$rotation^2,2,sum) # There it is. 

### 4. The scores on the PCs
# Projecting the original observations into the eigenvectors give the scores,
# Z_i's. 
# These scores (on the PCs) are contained in eig$x. This contains 49 
# observations. 
# To get a taste of it, let's use 'head()'

head(eig$x)

# This is: the first row corresponds to the original variables measured on 
# the first sparrow, but now expressed in terms of the eigenvectors (the PCs).
# The second, third, fourth rows, etc., are explained the same way. 

# Notice that the first 2 PCs covers 98% of the total variation. Let's keep 
# just those two. 

### 5. Plotting (projecting) the data into two dimensions (two PCs)
# Keeping just the first two PCs:
pc2<-eig$x[,1:2]

# 5.1 The SCORE PLOT
plot(pc2[,1], pc2[,2], xlab="PC1", ylab="PC2", ylim=c(-5,5), xlim=c(-15,15),
     main="Score plot")
abline(h=0, v=0, lty=2, col="red", lwd=1)

# This is: that original cloud of points in 5 dimensions is now visible in 
# just two. 
# The distortion of doing this is minimum. This projection is 98% accurate! 

# Visualizing non-survivors
points(pc2[22:49,1],pc2[22:49,2], col="orange", pch=16)

# Coloring survivors
points(pc2[1:21,1],pc2[1:21,2], col="skyblue", pch=16)
abline(v=c(-7.5,7.5), lty=2, col="grey44")

# Apparently, it seems than non-survivors are morphologically more extreme 
# than survivors! 
# Notice that non-survivors have more extreme values in PC1 than survivors. 
# It is not that clear on PC2, but still, to some extent, sparrows with the
# more extreme values in PC2 were non-survivors. 
# The other way around: those who survived have scores more "concentrated" 
# in both PC1 and PC2. 

abline(h=c(-2.5,2.5), lty=2, col="grey44")

# The lecture is: sparrows with a typical morphology, tend to survive.
# Those whose morphology is somewhat enlarged or reduced, tend to die.
# OF course: this "empirical", exploratory analysis does not exempt us from
# further statistical tests, but is just a first impression. 

### 5.1 Manually projecting the data onto the PC's

# Since we keep the original variability, we just need to center the matrix: 
spa0<-scale(spa,
              center=TRUE, # TRUE! i.e., centering the matrix
              scale=FALSE)

# Checking their dimension
dim(eig$rotation)
dim(spa0)

# For manually making the projection, we do:
head(spa0%*%eig$rotation,6)
head(eig$x,6)

### 6. What if we'd like to give the same importance (weight) to each variable?
# Well...in that case, we need to standardize the variables (mean=0 and sd=1). 
# For this, when using the 'prcomp' function, be sure to change to
# center=TRUE and scale.=TRUE. 
# Now the eigenanalysis is done not in the covariance, but the CORRELATION
# matrix. 

### 6.1 Eigenanalysis
eig2<-prcomp(spa, center = TRUE, scale. = TRUE)
### Eigenvalues 

# 6.2 The eigenvalues of the correlation matrix are
(lam2<-eig2$sdev^2)
# Plotting lambdas per component
plot(eig2)

# Or:
(per_var2<-round(lam2/sum(lam2),2))
# Scree-plot
plot(seq(1,5), per_var2, type="b", xlab="Principal Component",
     ylab="Proportion of variance explained")

# Again, the first PC encompasses the GREAT MAJORITY of the total variation in 
# the data!!
# However, the variability of the rest of PC's does not vanishes as quick as
# before!

# 6.3 How much of the total variation is encompassed in each PC?
round(lam2/sum(lam2),3)
0.715 + 0.107
# Notice that the first 2 PCs covers 82% of the total variation. Let's keep just those
# two.

# Plotting (projecting) the data into two dimensions (two PCs)
# Keeping just the first two PCs:
pc22<-eig2$x[,1:2]
plot(pc22[,1], pc22[,2], xlab="PC1", ylab="PC2", ylim=c(-4,4), xlim=c(-5,5))
abline(h=0, v=0, lty=2, col="red", lwd=2)

# This is: that original cloud of points in 5 dimensions is now visible in 
# just two. 
# The distortion of doing this is moderate. This projection is 82% accurate! 

# Visualizing non-survivors
points(pc22[22:49,1],pc22[22:49,2], col="orange", pch=16)

# Coloring survivors
points(pc22[1:21,1],pc22[1:21,2], col="skyblue", pch=16)
abline(v=c(-2.5,2.5), lty=2, col="grey44")
abline(h=c(-1.5,1.5), lty=2, col="grey44")

# The conclusion seems to be the same as before! Extreme morphology is perhaps
# related to more chances of not surviving. 

### 7. The BIPLOT: showing scores and loadings ($rotation)
# The biplot is a way of showing both, PC scores and loading vectors at the 
# same time. 

# Once the Score Plot is constructed, the arrows (vectors) represent the 
# original variables and their importance on each PC. 
# The length of arrows is proportional to its variance.

round(cor(spa),2)
round(eig$rotation,2)
eig$x[,1:2]

# Non-scaled axis
biplot(eig, col=c("coral2","darkgrey"), scale=0)
# scale=0, shows actual scores on PCs (bottom and right) and loadings
# (top and right)
# However, it's difficult to represent actual correlations between variables
# (cosines of the angles between arrows). 

# This is: 
# - Arrows pointing to (more or less) the same direction have positive
# correlation.
# - Arrows pointing to opposite directions (kind of 180 degrees), have negative 
# correlation. 
# -Arrows pointing in nearly perpendicular directions have no (or small) 
# correlation. 

# Scaled-axis
# If scale is ignored, then the matrix of variable loadings (x$rotation) is 
# scaled by the standard deviation of the principal components (x$sdev) times
# square root of the number of observations. 
# This sets the scale for the top and right axes to what is seen on the 
# following plot.

biplot(eig, col=c("coral2","darkgrey"))

# Notice that the scores on the PCs are also scaled accordingly. 
# Clearly, when projecting on the top axis, Extent is the variable that 
# influences the most on PC1, followed by Length. 
# When projecting on the right axis, now is Length the one that influences
# the most on PC2, followed by Extent.
# The influence of the rest of variables on PC1 and PC2 are marginal. That
# also can be seen just from the loadings in the 'rotation' matrix. 




















