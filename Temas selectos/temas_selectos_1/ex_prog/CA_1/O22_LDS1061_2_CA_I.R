### CA: Brands and attributes example ###

### 0. Constructing the Indexed Residuals, Expected proportions and
# Standardized residuals.

# Let's construct I, E and Z from the data in the presentation slides. 

# 0.1 Original table and Indexed residuals
tab<-cbind(Tasty=c(5,18,19,12,3),
           Aesthetic=c(7,46,29,40,7),
           Economic=c(2,20,39,49,16))
rownames(tab)<-c("Butterbeer","Squishee","Slurm","Fizzy","Brawndo")

chisq.test(tab)
# pvalue is quite small. We reject "H0: there is no association between
# Brands and Atrributes".

I<-cbind(Tasty=c(0.95,0.17,0.20,-0.35,-0.37),
         Aesthetic=c(0.21,0.32,-0.19,-0.04,-0.35),
         Economic=c(-0.65,-0.41,0.11,0.20,0.52))
rownames(I)<-c("Butterbeer","Squishee","Slurm","Fizzy","Brawndo")

# 0.2 Expected proportions
E<-cbind(Tasty=c(0.008,0.049,0.051,0.059,0.015),
         Aesthetic=c(0.019,0.111,0.115,0.134,0.034),
         Economic=c(0.018,0.109,0.113,0.131,0.034))
rownames(E)<-c("Butterbeer","Squishee","Slurm","Fizzy","Brawndo")

# 0.3 Standardized residuals
Z<-I*sqrt(E)
round(Z,3)

### 1. CA: Applying SVD on Z 
# 1.1 SVD on Z
ob0<-svd(Z)

# 1.2. Singular values:
round(ob0$d,4)

# Remember: these are the standard deviations along the principal components axis. 
# Thus, we square them so we get the variances, i.e., the eigenvalues. 
round(ob0$d^2,3)

# So, the proportion of variance explained is
round(ob0$d^2/sum(ob0$d^2),2)

# i.e., 84% of the total variance is explained in the 1st component
# and 16% is explained in the 2nd. 
# The third component covers such a small amount of variability that is practically
# zero. 

# 1.3 Left singular vectors: columns of U
UU<-round(ob0$u,3)
# Remember: these vectors (columns of U) are associated to the Brands. 
rownames(UU)<-c("Butterbeer","Squishee","Slurm","Fizzy","Brawndo")
colnames(UU)<-c("dim1","dim2","dim3")
UU

# 1.4 Right singular vectors: columns of V
VV<-round(ob0$v,3)
# Remember: these vectors (columns of V) are associated to Atrributes
rownames(VV)<-c("Tasty", "Aesthetic", "Economic")
colnames(VV)<-c("dim1","dim2","dim3")
VV

### 2. Plotting both categorical variables
# To get coordinates that represent the indexed residuals, we now need to 
# unweight the SVD’s outputs- 
# We divide each row of the left singular vectors by the square root of the 
# row masses, and divide each column of the right singular vectors by the square
# root of the column masses:

# From the presentation slides, this is
rmass<-c(0.044,0.269,0.279,0.324,0.083) # row mass vector
nUU<-matrix(NA, ncol=3, nrow = 5)
for(i in 1:nrow(UU)){
  nUU[i,]<-UU[i,]/sqrt(rmass[i])
}
rownames(nUU)<-c("Butterbeer","Squishee","Slurm","Fizzy","Brawndo")
colnames(nUU)<-c("dim1","dim2","dim3")
round(nUU,2)

cmass<-c(0.182,0.413,0.404) # column mass vector
nVV<-matrix(NA, ncol=3, nrow = 3)
for(i in 1:nrow(VV)){
  nVV[i,]<-VV[i,]/sqrt(cmass[i])
}
rownames(nVV)<-c("Tasty", "Aesthetic", "Economic")
colnames(nVV)<-c("dim1","dim2","dim3")
round(nVV,2)

# Now we DO get the Standard Coordinates plots
# As for Brands: 
plot(nUU[,1], nUU[,2], col="skyblue", pch=3, xlim=c(-3,3), ylim=c(-4,3),
     xlab="PC1", ylab="PC2")
abline(h=0, v=0, col="red", lty=2)
text(nUU[,1], nUU[,2]-0.25, labels=rownames(nUU), cex=0.6, col="blue")

# As for Attributes: 
points(nVV[,1], nVV[,2], col="darkorange", pch=16, xlim=c(-3,3), ylim=c(-4,3),
     xlab="PC1", ylab="PC2")
text(nVV[,1], nVV[,2]+0.25, labels=rownames(nVV), cex=0.6, col="orange")

# Interpretation: 
# 1. Brands like Brawndo and Fizzy are more "Economic", by are clearly far
# from being "Aesthetic" or "Tasty". In fact, "Tastiness" is their least represen-
# tative attribute.  

# 2. Butterbeer is clearly quite "Tasty", but definitely, far from "Economic". 
# 3. Squishee is clearly the most "Aesthetic", but not that "Economic" nor
# particularly "Tasty". 
# 4. In consequence, Brawndo and Fizzy are perhaps the two most similar Brands. 
# Butterbeer and Squishee are the most different due to their very own attributes. 
# If it were necessary to decide, Slurm seems more similar to Brawndo and Fizzy
# than to any of the other two. 



























