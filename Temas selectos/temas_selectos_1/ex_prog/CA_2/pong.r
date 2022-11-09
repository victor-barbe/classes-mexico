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

tab <- cbind(Victor = c(23,	49,	5,	0,	2,	40,	1) ,
             Pierre = c(2,	32,	11,	34,	55,	11,	0) ,
             Antoine = c(35, 11,44,	14,	0,	17,	0),
             Pedro = c(34,	41,	43,	0,	56,	0,	24),
             John = c(2,	8,	0,	12,	40,	0,	15))
rownames(tab) <- c("Contact_client","Do_comptability","Order_material","Contact_compagnies","Manuel_work",
                   "Meet_client","Write_contracts")

print(tab)
tab <- as.table(as.matrix(tab))
# First convert the data as a table
dt <- as.table(as.matrix(tab))
# Now, use the function: 
balloonplot(t(dt), main ="housetasks", xlab ="", ylab="",
            label = FALSE, show.margins = TRUE)