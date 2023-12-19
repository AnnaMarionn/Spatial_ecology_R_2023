# measurement of RS based variability

library(imageRy)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

#band 1=nir, 2=red, 3=green
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)

#the layer that we want is the nir one, so the first:

nir <- sent[[1]]

#to calculate variability over space: moving window (standard deviation for the whole image)
focal(nir, matrix(1/9, 3, 3) fun=sd)
#don't use "sd as name since it is an element of the function"

sd3 <- focal(nir, matrix(1/9, 3, 3) fun=sd)
plot(sd3)

#colors of viridis, suitable for colorblind people

viridisc <-colorRampPalette(viridis(7))(255)
plot(sd3, col= viridisc)



