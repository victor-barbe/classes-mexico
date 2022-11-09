library("FactoMineR")
library("factoextra")


data(housetasks)
head(housetasks) # visualizing just the first 6 rows of the object
help("housetasks")


library("gplots")

dt <- as.table(as.matrix(housetasks))

balloonplot(t(dt), main ="housetasks", xlab ="", ylab="",
label = FALSE, show.margins = FALSE)

tst <- chisq.test(housetasks)
tst

ob.ca <- CA(housetasks, graph = FALSE)

ob.ca

eig.val <- get_eigenvalue(ob.ca)
eig.val

fviz_screeplot(ob.ca, addlabels = TRUE, ylim = c(0, 60))

fviz_screeplot(ob.ca) +
geom_hline(yintercept=33.33, linetype=2, color="red")

fviz_ca_biplot(ob.ca, repel = TRUE)

row <- get_ca_row(ob.ca)
row

head(row$coord)

head(row$cos2)

head(row$contrib)


fviz_ca_row(ob.ca, repel = TRUE)

fviz_ca_row(ob.ca, col.row="darkorange", shape.row = 14)

head(row$cos2, 4)

apply(row$cos,1,sum)

round(1-row$cos[,3],2)

fviz_ca_row(ob.ca, col.row = "cos2",
gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
repel = TRUE)


library("corrplot")
corrplot(row$cos2, is.corr=FALSE)

 
fviz_cos2(ob.ca, choice = "row", axes = 1:2)

row$contrib

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

fviz_ca_row(ob.ca, col.row = "contrib",
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE)


col <- get_ca_col(ob.ca)
col

fviz_ca_col(ob.ca)

# Like row points, it's also possible to color column points by their cos2 values:
fviz_ca_col(ob.ca, col.col = "cos2",
gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
repel = TRUE)

fviz_contrib(ob.ca, choice = "col", axes = 1:2)