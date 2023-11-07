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
