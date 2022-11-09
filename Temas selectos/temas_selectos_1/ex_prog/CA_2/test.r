library(ca)
tab = as.table(rbind(c(28, 4,  0, 56),
                     c(38, 5,  9, 10),
                     c( 6, 6, 14, 13) ))
#names(dimnames(tab)) = c("activity", "period")
rownames(tab)        = c("feed", "social", "travel")
colnames(tab)        = c("morning", "noon", "afternoon", "evening")
print(tab)
#         period
# activity morning noon afternoon evening
#   feed        28    4         0      56
#   social      38    5         9      10
#   travel       6    6        14      13

#plot(ca(tab))