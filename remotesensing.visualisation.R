library(devtools)
#CRAN archive network with most of the packages, some are in Github
#use devtools
#another way: writing the package first
devtools::install_github("ducciorocchini/imageRy")

library(imageRy)
#to get all the possible images of the package
im.list()
#we need terra package since imageRy is based on that
library(terra)

#we're using datasets about the dolomites (sentinel.dolomites...with different information) in bands
#sentinel 2: satellite that took info about cortina d'ampezzo (2016), resolution of 10 m
#different bands have info about different wavelenghts (b2=blue(0.490nanom), b3=green(0.560),...)
#we're gonna use images of the same resolution (10 meters): b2,b3,b4,b8

#now we import the layers: first blue, with function im.import

band2 <- im.import("sentinel.dolomites.b2.tif")
band2 #to get the information like resolution, coordinate system,...

#26/10
library(imageRy)
library(terra)

#theory about coordinates

#let's build a new color palette(100 is the gradient)

clb <- colorRampPalette(c("dark gray","gray","light gray")) (100)
plot(band2, col=clb)

#the results show reflectance
#now we import the green band data from Sentinel(band3)

band3 <- im.import("sentinel.dolomites.b3.tif")
band3

plot(band3. col=clb)
