#importing libraries
library("FactoMineR")
library("factoextra")
library("gplots")
library("corrplot")

#creating our dataset
tab <- cbind(Victor = c(55,	40,	0,	0,	55,	40,	0,12) ,
             Pierre = c(0,	32,	12,	34,	55,	12,	0,0) ,
             Antoine = c(55, 12,40,	0,	0,	12,	0,12),
             Pedro = c(55,	40,	40,	0,	55,	0,	24,20),
             John = c(40,	0,	40,	12,	40,	0,	55,0))
rownames(tab) <- c("Contact_client","Do_comptability","Order_material","Contact_compagnies","Manuel_work",
                   "Meet_client","Write_contracts","Clean_office")

#printing our dataset
print(tab)
tab <- as.table(as.matrix(tab))
dt <- as.table(as.matrix(tab))

#ploting the data
balloonplot(t(dt), main ="Company work", xlab ="Names", ylab="Activities",
            label = FALSE, show.margins = FALSE)

# We can use the Chi-square test to evaluate whether there is a significant
# relation between rows and columns (explained in the report)

tst <- chisq.test(tab)
tst

# To compute correspondence analysis, we use this function
ob.ca <- CA(tab, graph = FALSE)

# The output a list including various pieces of information.
ob.ca

#here we get the eigenvalues of our CA to better understand 
#how the variance is distributed over the dimensions

eig.val <- get_eigenvalue(ob.ca)
eig.val

# The first two dimensions cover 80% of the variance, which will 
#allow to get a lot of info about the dataset

#we visualize the % of variance explained in each dimension
fviz_screeplot(ob.ca, addlabels = TRUE, ylim = c(0, 60))

# The next piece of R code draws the scree plot with a red dashed line 
# specifying the average eigenvalue:
fviz_screeplot(ob.ca) +
geom_hline(yintercept=25, linetype=2, color="red")

#we have 4 components so the average eigenvalue show cover 1/4 of the total variation
#we can see the 2 first one are above average, we choose a 2d sol.

#here we plot our 2d representation, explained in the report
fviz_ca_biplot(ob.ca, repel = TRUE)


#now to interpret the data, lets see which row or column contribute the most
#to the 2d we kept

##First we will display graphs about the row variables

# The function get_ca_row() is used to extract the results for row variables.
# This function returns a list containing 
# -- the coordinates,
# -- the cos2, 
# -- the contribution and the variance row variables. 
 
row <- get_ca_row(ob.ca)
row

#here we get the coordinates of each point in each 4 dimension
head(row$coord)
#show the quality of the representation
head(row$cos2)
#show the contribution of rows in each dimension in %
head(row$contrib)

#to vizualise row points
fviz_ca_row(ob.ca, repel = TRUE)

# The quality of representation of the rows on the biplot is called the 
# squared cosine (cos2) or the squared correlations.
# The cos2 measures the degree of association between rows/columns and a 
# particular axis. The cos2 of row points can be extracted as follow:

head(row$cos2, 4)

#here we color by cos2 value to see which rows are correctly representend
#on the biplot
fviz_ca_row(ob.ca, col.row = "cos2",
gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
repel = TRUE)

#all of the variable are quiete well represented except Order_material

#visualizing the cos2 of row points on all the dimensions
corrplot(row$cos2, is.corr=FALSE)

#we can see that order material is quite well associated with dim 3. 
# We can also create a bar plot of rows' cos2 over the first 2 dim. 
fviz_cos2(ob.ca, choice = "row", axes = 1:2)

# The position of the point order_material on the biplot should be interpreted with 
# some caution, as we would need a 3d solution for that point

##Contributions of rows to the dimensions (Components)

# The contribution of rows (in %) to the definition of the dimensions can be extracted
# as follows:
row$contrib

#Order material contributes a lot to the 3rd dimension 
#Rows that contribute the most to Dim.1 and Dim.2 are the most important in explaining
#the variability in the data set.

#show most contributing row to each dimension
corrplot(row$contrib, is.corr=FALSE)
?corrplot

apply(row$contrib,2,sum)

#now we will see the contribution of each row to the dimensions
# Contributions of rows to dimension 1
fviz_contrib(ob.ca, choice = "row", axes = 1, top = 10)
mean(row$contrib[,1])

# Contributions of rows to dimension 2
fviz_contrib(ob.ca, choice = "row", axes = 2, top = 10)
mean(row$contrib[,2])

# Total contribution in both dimension 1 and 2
fviz_contrib(ob.ca, choice = "row", axes = 1:2, top = 10)
rev(sort(apply(row$contrib[,1:2],1,mean)))

#write_contract and order_material contribute most to d1
#contact_compagnies and write_contract the most to d2

#contribution of row points
fviz_ca_row(ob.ca, col.row = "contrib",
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)

#contact_companies and manuel_work have the most contribution to the positive
#side of the first d
#write_contracts and order_material have the most contribution to the negative
#side of the first d
#this means d1 is defined by the opposition of contact_companies, manuel_work
# and write_contracts, order_material
                
##Graph of column variable
                                                                    
#get coordinates,cos2, contribution and variance for columns
col <- get_ca_col(ob.ca)
col

#simple plot of columns
fviz_ca_col(ob.ca)

# Like row points, it's also possible to color column points by their cos2 values:
fviz_ca_col(ob.ca, col.col = "cos2",
gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
repel = TRUE)

#when the cos2 value is close to one, the columns is well represented on the 2d space. 
#when it goes much lower, it might not be well represented on those dimensions

# To visualize the contribution of rows to the first two dimensions, type this:
fviz_contrib(ob.ca, choice = "col", axes = 1:2)

