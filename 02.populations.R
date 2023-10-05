# code related to population ecology

# a package is needed for point pattern analysis
# adding package from cran??
install.packages("spatstat")
libraru(spatstat)

#let's use the bei dataset
# data description:
#https://CRAN.R-project.org/package=spatstat

bei

#plotting the data
plot(bei)
#changing graphic- cex (0.5 or .5) and pch (symbol)

plot(bei, cex=0.2, pch=19)

#to see an image file (raster)
bei.extra
plot(bei.extra)

#let's use only part of the bei dataset: elev
bei.extra$elev

#simplifying

elevation <- bei.extra$elev
plot(elevation)
# selecting the first element

elevation2 <- bei.extra[[1]]
plot (elevation2)
