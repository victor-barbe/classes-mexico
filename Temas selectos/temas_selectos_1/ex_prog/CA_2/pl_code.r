library("ca")
library("FactoMineR")
library("factoextra")
library("gplots")
library("corrplot")
tableau = as.table(rbind(c(12, 0,  12, 40),
                     c(38, 9,  5, 12),
                     c( 6, 6, 14, 13),
                     c(0, 15, 50, 10),
                     c(12,0,55,30),
                     c(36, 0 , 55, 40),
                     c(50, 12, 15, 0),
                     c(50, 30, 22, 0)))
rownames(tableau)        = c("Coca-cola", "fanta", "Pepsi","Seven-up","Sprite","Ice-tea","Fuse-tea","Canada-dry")
colnames(tableau)        = c("Dijon", "Bordeaux", "Paris", "Lille")
print(tableau)

tableau <- as.table(as.matrix(tableau))
dt <- as.table(as.matrix(tableau))

#here we plot the data we defined above
balloonplot(t(dt), main ="Drink sales", xlab ="Drink name", ylab="City",
            label = FALSE, show.margins = FALSE)

#Chi-square test to evaluate relation between rows and columns:

tst <- chisq.test(tableau)
tst

#we compute ca
ob.ca <- CA(tableau, graph = FALSE)

# The output a list including various pieces of information.
ob.ca

#computing eigenvalues
eig.val <- get_eigenvalue(ob.ca)
eig.val

# We can also rely (visually) in the scree plot: 
fviz_screeplot(ob.ca, addlabels = TRUE, ylim = c(0, 60))

#plot with red line for average eigenvalue
fviz_screeplot(ob.ca) +
geom_hline(yintercept=33.33, linetype=2, color="red")

#biplot
fviz_ca_biplot(ob.ca, repel = TRUE)

#get info about the rows
row <- get_ca_row(ob.ca)
row

# Coordinates
head(row$coord)
# Cos2: quality on the factore map
head(row$cos2)
# Contributions to the principal components
head(row$contrib)

#show row points
fviz_ca_row(ob.ca, repel = TRUE)

#cos2 of row points
head(row$cos2, 4)

#sum of the cos2 for rows on all the CA dimensions is equal to one.

apply(row$cos,1,sum)


#cos2 biplot
fviz_ca_row(ob.ca, col.row = "cos2",
gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
repel = TRUE)

#cor of the variable depending on dimension
library("corrplot")
corrplot(row$cos2, is.corr=FALSE)

#bar plot
fviz_cos2(ob.ca, choice = "row", axes = 1:2)

#Contributions of rows to the dimensions (Components)
row$contrib

#highlight the most contributing rowpoints for each dimension
library("corrplot")
corrplot(row$contrib, is.corr=FALSE)
?corrplot

apply(row$contrib,2,sum)

# Contributions of rows to dimension 1
fviz_contrib(ob.ca, choice = "row", axes = 1, top = 10)
mean(row$contrib[,1])

# Contributions of rows to dimension 2
fviz_contrib(ob.ca, choice = "row", axes = 2, top = 10)
mean(row$contrib[,2])

# Total contribution in both dimension 1 and 2
fviz_contrib(ob.ca, choice = "row", axes = 1:2, top = 10)
rev(sort(apply(row$contrib[,1:2],1,mean)))

#most contributing row points can be highlighted on the scatter plot as follow:
fviz_ca_row(ob.ca, col.row = "contrib",
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)
      
#Graph of column variables

col <- get_ca_col(ob.ca)
col

# The result for columns gives the same information as described for rows. 

#simple plot
fviz_ca_col(ob.ca)

#color column points by their cos2 values:
fviz_ca_col(ob.ca, col.col = "cos2",
gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
repel = TRUE)

# contribution of rows to the first two dimensions
fviz_contrib(ob.ca, choice = "col", axes = 1:2)