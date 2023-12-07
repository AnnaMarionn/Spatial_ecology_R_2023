## 7/12
## classifying satellite images and estimate amount of change
## different reflectance for each pixel (training areas or sites, used to check the main classes, "claster", for example type of ecosystem)--> graph with nir and red waves
## then new pixels can be classified using the nearest distance to the closest class (in the graph). we state that it is "more probable" than the pixels is related to a certain class


library(terra)
library(imageRy)

##function im.list to see all the files--> we are interested in "first views of the sun pillars"

im.list()

##"Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg"--> energy of sun gasses. on google you can simply copy and paste to find the source

sun<- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

## also nebulas images on internet
## more or less 3 levels of energy (divided by colors), cleary visible in the image
## we should explain to the software the number of clusters of the image--> classifying

#function with image and number of clusters that we want to use
sunc <- im.classify (sun, num_cluster=3)

## now it is divided by colors, without indication of level of energy
