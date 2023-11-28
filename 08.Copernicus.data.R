#https://land.copernicus.vgt.vito.be/PDF/portal/Application.html
#nc file, to read it:

install.packages("ncdf4")
library(ncdf4)

library(terra)
#two libraries to download data--> to tell R the location of files that we saved:
#we set working directory

setwd("C:/Users/annam/Desktop/unibo/Spatial_Eco_R")
#to import data: 
#newnameofobject <- rast("nameofthefile")

soil <- rast("c_gls_SSM1km_202311230000_CEURO_S1CSAR_V1.2.1.nc")
plot(soil)

# we get two different images: one on soil moisture, the other one about errors (noise)
# to only get one of them:

plot(soil[[1]])
#then we change the colors: 
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)

plot(soil[[1]], col=cl)

#new function: crop. we define a variable (extension, defined by max and min longitude(x)) and latitude(y) in an array

ext <- c(22, 26, 55, 75)  #minlong, maxlong ,minlat, maxlat
soilcropped <- crop (soil, ext)

plot(soilcropped[[1]], col=cl)
