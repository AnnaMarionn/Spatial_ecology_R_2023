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
plot(sunc)

## now it is divided by colors, without indication of level of energy

## now matogrosso:
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

## water absorbs all infrared so it should be black but soil underneath water is still visible

m1992c <- im.classify (m1992, num_clusters=2)
plot(m1992c)

#classes: forest =1, human=2
## second image
m2006c <- im.classify (m2006, num_clusters=2)
plot(m2006c)

#to compare
par(mfrow = c(1,2))
plot(m1992c[[1]])
plot(m2006c[[1]])

dev.off()

#to see how many pixels are in each cluster:
f1992 <- freq(m1992c)

#to calculate percentage= we divide the pixel count by the total count  (that we get with ncell)

tot1992 <- ncell(m1992c)

p1992 <-f1992*100/tot1992 

##results: 
> p1992
         layer        value    count
1 5.555556e-05 5.555556e-05 83.08683
2 5.555556e-05 1.111111e-04 16.91317

## so 83& of pixels in 1992 were forest, 16% human
# now for 2006

f2006 <- freq(m2006c)
f2006

tot2006 <- ncell(m2006c)

p2006 <-f2006*100/tot2006 
p2006

##results:
> p2006
         layer        value    count
1 1.388889e-05 1.388889e-05 45.30561
2 1.388889e-05 2.777778e-05 54.69439

## in 2006 45% was forest, 54% human

##now to put info in a graph, we first build a table with the data (class or "cover":
## building the output table
class <- c("forest", "human") 
y1992 <- c(83, 16)
y2006 <- c(45, 54)
class ##i get the columns

#then for the graph:
tabout<- data.frame(class, y1992, y2006)
tabout

#we now need a package: (ggplot2)

# final plot, colors related to the class, barplot (human one color, forest another)
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")

p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")

