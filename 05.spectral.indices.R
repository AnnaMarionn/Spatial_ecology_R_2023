#7/11
library(imageRy)
library(terra)

im.list()
#we're gonna use the data on matogrosso. to get description on the file: repository imageRy on ducciorocchini Github (Datadescription)
#also you can copy the name from rstudio description and paste it into google 
#matogrosso is a brazilian deforested island, in this case the images are from nasa earth observatory regardinf
#let's import the data, 30 m resolution (sentinel was 10m)

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
#the image we get has already been processed, and the bands are the following:
# 1=NIR, 2=RED, 3=GREEN

im.plotRGB(m1992, r=1, g=2, b=3) 
# or also written as
im.plotRGB(m1992, 1, 2, 3)
#the red we get is tropical forest, in 1992 they had already stareìted to build
#we put nir on top of the green:
im.plotRGB(m1992, 2, 1, 3)
or
im.plotRGB(m1992, r=2, g=1, b=3) 
#nir on top of the blue:
im.plotRGB(m1992, r=2, g=3, b=1) 
#water should be black but it appaears similar to soil (it is polluted with particles
#let's see the same image in 2006
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=3, b=1)
#the yellow color, once again, catches our eyes more than other colors and enhances the soil consumption of the area
#let's try to calculate the same index for vegetation for the two different years

library(ggplot2)
library(viridis)

#9_11
#matogrosso, we take the image first, then the bands
m1992<- im.import("matogrosso_l5_1992219_lrg.jpg")
#here we have infrared, red and green bands in this specific order
#components:blue, green, red ("channel") -->bands 123 (1=infrared)
#based on the order (and in which channel we put the infrared) we see the vegetal part in a certain color (bgr)
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
#we see the difference on the location

#today, we build multiframe with the two images
par(mfrow=c(1,2))
im.plotRGB(m1992, 2, 1, 3)
im.plotRGB(m2006, 2, 1, 3)

#to get info about the image: run the name of the image
#now we plot the first element of m1992:
plot(m1992[[1]])
#we see that the range of reflectance gets to 255, why? reflectance0 ratio of reflected and incident radiant flux
#we're gonna rescale by using bits (shannon)--Z every piece of infomation can either be 0 or 1 (binary code)
#with two bits you can get 4 different information ("0","1","2","3"), from 3 bits to 8 info, with 4--> 16
#many info is stored in 8 bit
#DVI=NIR-RED
#bands: 1=NIR, 2=RED, 3=GREEN

dvi1992=m1992[[1]]-m1992[[2]]
plot(dvi1992)

#from the image we get info about health of the forest (the greener, the healthier)
#to change the palette:
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100) # specifying a color scheme
plot(dvi1992, col=cl)
#here we don't have rgb, but a single layer (from the subtraction nir-red)
#for dvi2006:

dvi2006=m2006[[1]]-m2006[[2]]
plot(dvi2006, col=cl)

#NDVI used for plant diversity, ranges from -1 to 1 (riguardare)
#to get ndvi= you normalize the subtraction (NIR-RED) by the sum of NIR+RED
#less related to n of bits, dvi depends on the ??, ndvi has always the same range
#to calculate ndvi:

ndvi1992= dvi1992/(m1992[[1]]+m1992[[2]])
plot(ndvi1992, col=cl)
ndvi2006= dvi2006/ (m2006[[1]]-m2006[[2]])
plot(ndvi2006, col=cl)

#to get them together
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

#to speed up calculation, without writing the formula each time: im.ndvi)
ndvi2006a<- im.ndvi(m2006, 1, 2)
