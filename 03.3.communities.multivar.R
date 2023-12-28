#multivaried analysis or "ordination methods"
#first principal component= 90% of variability (wider range possible), the second is normal to the first and represents 10%
#from 2 plot to one
#19/10
#spiecies in space and in time: 2 excercise
#numerical ecology book
library(vegan) #dataset of plants on dunes
#let's recall the data of package:
data(dune)
#another function to see only the first few(6) rows is head (and the function tail to anly see the last rows
head(dune)
#important function: decorana (detrended correspondence analysis), to rearrange the data and have a summary
ord <- decorana(dune)
#usually we are interestend in the lenght of the range inside the axis (ex: 3.7 and 3.1) to scale the plot
#if we sum the lenghts we find the percentage and lenght for principal component:
ldc1 = 3.7007
ldc2=3.1166
ldc3=1.3055
ldc4 = 1.47888
total= ldc1+ldc2+ldc3+ldc4
#percentage of each axis:
pldc1=ldc1*100/total
pldc2=ldc2*100/total
pldc3=ldc3*100/total
pldc4=ldc4*100/total

pldc1
pldc2

pldc1+pldc2

plot(ord) #to see the plot of decorana based on the two axis
