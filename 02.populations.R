# code related to population ecology

# a package is needed for point pattern analysis
# adding package from cran??
install.packages("spatstat")
library(spatstat)

#let's use the bei dataset (rio pexioto tree distribution, every point is a tree from gps tracking)
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

#let's build the density map -> function density in the spatstat package to pass from points to continuous surface (interpolation)
density_map <- density(bei)

#from points to PIXELS, representing the landscape. we can plot an image

plot(density_map)
# to put the points on top of an image, if we use plot we erase the previous raster, to ADD we use the function points
#blue green and red should be avoided together for colorblind people

points(bei, cex=.2)

#to change the colors (saved in R with """"), array of colors concatenated to form a variable to use as col in the function plot

colorRampPalette(c("gray", "red", "orange", "yellow"))

#how many different colors we want to use to pass from a color to another)
c1<- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(density_map, col=c1)

#the first color the eyes sees and focus on is yellow, so we use it (higher values)

c1<- colorRampPalette(c("pink", "darkorchid",  "darkmagenta", "darkgoldenrod3", "yellow"))(1000)

plot(density_map, col=c1)

#multiframing(mf) with function par, stating how many empty rows and col to fill
par(mfrow=c(1,2))

# now we fill the slots
par(mfrow=c(1,2))
plot(density_map)
plot(elevation2)

#to do one column with two rows
par(mfrow=c(2,1))
plot(density_map)
plot(elevation2)

#multiframe with 3 plots (bei, density, elevation)
# we see that high altitude area corresponds to low density distribution of trees (general knowledge)
#install terra and esdm
