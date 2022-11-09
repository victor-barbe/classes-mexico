tab <- cbind(Benito = c(52,	12,	0,	3,	30,	3,	0,	52) ,
             Rosa = c(31,	8,	0,	50,	10,	30,	0,	52) ,
             Mario = c(9,	56,	0,	0,	10,	18,	0,	52),
             Eugenia = c(20,	19,	0,	12,	30,	50,	0,	52),
             Dara = c(0,	0,	52,	0,	0,	0,	52,	0))
rownames(tab) <- c("Cook_pasta","Cook_meat","Cook_pizza","Dessetrs","Cut_vegetables",
                   "Entries","Beverages","Wash_dishes")

print(tab)
tab <- as.table(as.matrix(tab))

