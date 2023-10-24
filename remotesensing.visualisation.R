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
