#Final script including all the different scripts during lectures

#Summary: 
# 01 Beginning
# 02.1 Population Density
# 02.2 Population Distribution
# 03.1 Community Multivariate Analysis
# 03.2 Communities Overlap
# 04.1 Remote Sensing Data Visualization
# 04.2 Remote Sensing Data Visualization
# 05 Spectral Indices in R
# 06 Time Series Data
# 07 External Data 
# 08 Copernicus Data
# 09 Classification
# 10 Variability
# 11 PCA

#---------------------------

# 01 Beginning

# Under the hashtag the software R will not detect the code. This is just a comment.

# exercise
# We will use R as a simple calculator
2 + 3

#Whenever we want to assign a value to an object, we rename the object. 
#This how to create a new variable with an assigned value.
a <- 2+ 3
a

gioia <- 3+5
gioia

#We can perform operations by using our new variables.
gioia * a

#To store the final operation result we rename it as "final"
final <- a*gioia
final

#Another basic operation: the result multiply for itself
final^2 

# ARRAY, a series of info coded all together.
# Example: we collected data about how many grams of microplastics we found in different spots of a lake.
# We concatenate all the data by using the "c" FUNCTION, in this way we created an array, all the collected 
# data stored inside are now called ARGUMENTS.

sophi <- c(10, 20, 30, 50, 70) 
sophi # run the code

# Let's add some data. 
# Example: We consider different amount of people in the different lake spots considered before.
# This is going to be our second variable:
paula <- c(100, 500, 600, 1000, 2000)

# We can now create a plot between the two variables.
# HOW TO CREATE A PLOT?
# We use the "plot" function.

plot(paula, sophi)
plot

# By plotting the two variables together, we observed a  direct correlation between them.

# Lets say that now I want to modify the plotting labels.
# HOW DO I ASSING NAMES TO THE LABELS?
# By using the "xlab" and the "ylab" arguments for the x axis and the y axis.

plot(paula, sophi, xlab="number of people", ylab="microplastics")
plot 

#OR I CAN assign to the old objects new names and then plotting them together 
people <- paula
microplastics <-sophi
plot(people, microplastics)

# HOW DO WE CHANGE SYMBOLS IN THE PLOT?
# By using the "pch" plot's argument. To know which one to use, we google "point symbols in R".

plot(people, microplastics, pch=19)

# HOW DO WE CHANGE THE SIZE OF OUR PLOT POINTS?
# By using the "cex" plot's argument.

plot (people, microplastics, pch=19, cex= 2)

# HOW TO CHANGE THE POINTS' COLOR?
# By using the "col" plot's argument.
plot(people, microplastics, pch=19, cex=2, col="green")

#---------------------------

# 02.1 Population density

#Code related to population ecology

# HOW TO INSTALL NEW PACKAGES IN R?
# By using the function "install.packages("name of the package").
# Note that, since we are importing external data in R, it is important to quote the name of the package.

# "spatstat" package is needed for point pattern analysis.
# Whenever we want to add a package from R archive network, we use CRAN space.
# To look at the data description: https://CRAN.R-project.org/package=spatstat

install.packages("spatstat")
library(spatstat)
library(terra)

# We will use the bei data set, which is inside spatstat.

plot(bei)

# On the plot in the R environment we observe thousands of points, 
# a representation of the monitored number of trees in the Amazonia forest.

# HOW TO CHANGE THE DOTS SIZE AND STYLE?
# We use the "cex" and "pch" functions
plot(bei, cex=0.5, pch=19)

# This is a density map, how to let R calculting the plots as a continuous image?
# By considering each group of dots as a single unit,
# where each unit is going to be more or less dense according to the number
# of dots present in that area.

# HOW TO PASS FROM POINTS TO CONTINUOUS SURFACE? 
# By using the interpolation.
# First of all we use the "density" function to create the density map and we rename it

density.map <- density(bei)
density.map
plot(density.map)

# Now, on the console, it is shown that we are working with pixels
# in this way we can plot the density map.

# To read the map: blue is low density instead yellow is high density.


# HOW TO PUT THE POINTS ON THE TOP OF THE DENSITY MAP?
# By using the "points" function, but not creating a new variable just adding it to the past "bei" plot.

points(bei, cex=0.2)

# HOW TO CHANGE THE DENSITY MAP COLORS?
# By using the "colorRampPalette" function and by concatenating the colors.
# 100 is the gradient.
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(density.map, col=cl)

# another example:
cl2 <-colorRampPalette(c("yellow", "red", "orange", "black"))(100)
plot(density.map, col=cl2)

# EXERCISE
# To built a new color palette

cl.ex <-colorRampPalette(c("cornsilk","darkred", "coral", "aquamarine"))(100)
plot(density.map, col=cl.ex)

cl.ex2 <-colorRampPalette(c("aquamarine", "coral", "darkred", "cornsilk"))(100)
plot(density.map, col=cl.ex2)

# HOW TO HAVE AN ADDITION VARIABLE?
# We use the "bei.extra" dataset, in our case we will add the "elevation" to the gradient.
plot(bei.extra)

# We set the elevation into an element which we call "elev" and we plot it.
# We will obtain only the elevation plot.
elev <- bei.extra[[1]] #bei.extra$elev
plot(elev)

# HOW TO PLOT SEVERAL THINGS ALL TOGETHER?
# By using the "par" function and the "multiframe" argument
# Inside the array we need to state how many rows and coloumns we want to plot, by concatenating them.

par(mfrow=c(1,2))
plot(density.map)
plot(elev) #run all the elements together

par(mfrow=c(2,1))
plot(density.map)
plot(elev)

#HOW TO CHANGE THE MAP COLORS?
par(mfrow=c(1,2))
plot(density.map, col=cl.ex)
plot(density.map, col=cl.ex2)

par(mfrow=c(1,2))
plot(density.map, col=cl)
plot(density.map, col=cl2)

#EXERCISE
#Run three elements together
par(mfrow=c(1,3))
plot(bei)
plot(density.map)
plot(elev)


#---------------------------

# 02.2 Population distribution

# Why populations disperse over the landscape in a certain manner?

# HOW TO INSTALL NEW PACKAGES IN R?
# By using the function "install.packages("name of the package").
# Note that, since we are importing external data in R, it is important to quote the name of the package.

install.packages("sdm") 
library(sdm) #This function is to make sure that the download completed successfully.
install.packages("terra")
library(terra) 

# HOW TO CHECK FILES' NAMES INSIDE AN R FOLDER?
# By using the "system.file" function and by specifing under parenthesis the package name.

system.file("external/species.shp", package="sdm")
file <- system.file("external/species.shp", package="sdm") 
file # after running the code, the names will be showned on the R console

# HOW TO USE THIS FILE?
# Since this is a VECTOR FILE, with the relative geographic coordinates, we will use the "vect" function
# This particular function, present in terra package, deals with vectors in the R space.

rana <- vect(file)

# HOW TO LINK TWO ELEMENTS TOGETHER?
# We use the $ symbol.

rana$Occurrence

# These codes are called PRESENCES and ABSENCES data (on the console is shown 0, 1, 0 and etc)
# 0 means absence and is an uncertain data, because it could be an error of your evaluation/monitoration 
# instead 1 means presence.

# HOW TO VISUAL SEE THE DATA IN THE ENVIRONMENT? 
# Again, by using plot function.
plot(rana)
plot (rana, cex= 0.5)

# HOW TO SELECT ONLY THE PRESENCES?
# By filtering the data ([...]) and setting the previously formed link (rana$Occurence) as equal (==) to the elements 
# that we want to extrapolate (1 = presences in occurence in our case).

rana[rana$Occurrence == 1,]

# In this manner we selected all the points in the plot that are equal to 1.

pres <- rana[rana$Occurrence ==1,]
pres$Occurrence

# After renaming the presences and linking them to Occurence, we can now plot them.

plot(pres, cex=2)

# HOW TO SELECT ABSENCES?
# Same procedure as beofore.

abs <- rana[rana$Occurrence ==0,]
abs$Occurrence
plot(abs, cex=2)

# To plot them together we use the par function.

par(mfrow=c(1,2))
plot(abs, cex=1)
plot(pres, cex=1)

# To change their color we use the function colorRampPalette

cl.pres <- colorRampPalette(c("yellow", "coral", "beige"))(3)
cl.pres

cl.abs <- colorRampPalette(c("blue", "aquamarine","navy", "lightgreen"))(4)

# We use argument "col" inside function "par" to change the colors of the two plots.

# HOW DO WE PLOT THE ABS AND PRES TOGETHER?
# We use the function "points" on the second function to add them 
# on the previous function.

plot(pres, cex=1, col= cl.pres)
points(abs, cex=1, col=cl.abs)

plot(pres, cex=1, col="darkgreen")
points(abs, cex=1, col="lightgreen")

# HOW TO UNDERSTAND WHY IN SOME AREAS THERE ARE GAPS (the absences)?
# There are some variables to explain and understand why, in these specific areas, the frog is not present.
# These variables are called PREDICTATORS (environmental variables).

# HOW TO IMPORT AN IMAGE AS A FILE FROM OUTSIDE R?
# By using system.file function to exit R and by selecting a file inside the folder called "elevation.asc". 
# "asc" is a type of file like jpeg, png; inside the sdm package.

elev <- system.file("external/elevation.asc", package="sdm")

# We call the new object elev but we won't use "vect" as before
# but "rast" because we're not dealing with points anymore, but with images (so with pixels).

elev <- rast(elev)
elev
plot(elev)

# Now we want to put on top of the elevation the points of presences.
# We use the "points" function again.

points(pres, cex=0.5) 

# Now we obtained a full map that shows where the frog is present and at which altitude
# By looking at it, we can make assumptions on the reasons why rana temporaria tends 
# to distributes more in an area rather than another.

# Lets do the same with the TEMPERATURE PREDICTOR

temp <- system.file("external/temperature.asc", package="sdm")
tempmap <-rast(temp)
plot(tempmap)
points(pres, cex=0.5)

# EXERCISE
# Lets do the same with cover of vegetation

veg <-system.file("external/vegetation.asc", package= "sdm")
vegmap <-rast(veg)
plot(vegmap)
points(pres, cex=0.5)

# To change colors of the map
plot(vegmap, col=cl.veg)
cl.veg <-colorRampPalette(c("lightgreen", "beige", "coral", "darkgreen", "yellow"))(100)

# Lets do the same with precipitation
prec <- system.file("external/precipitation.asc", package="sdm")
precmap <- rast(prec)
plot(precmap)
points(pres, cex=0.5)

# Plot everything together
par(mfrow=c(2,2))
plot(elev)
points(pres, cex=0.5)
plot(vegmap)
points(pres, cex=0.5)
plot(precmap)
points(pres, cex=0.5)
plot(tempmap)


#---------------------------

# 03.1 Community multivariate analysis

# We will use vegan package for our multivariate analysis for community ecology.
# Vegan package is for vegetation analysis.
# Overlap package is perfect to see how species are interacting during time.

install.packages("overlap")
library(overlap) 
install.packages("vegan")
library(vegan)


# Ordination method or multivariate analysis.

# To recall the data of our dataset "dune" we use the function data.

data(dune) 
dune

# HOW TO DISPLAY ONLY THE FIRST 6 ROWS OF THE DATASET?
# By using the function head().

head(dune)

# Starting using the decorana function or "Detrended Correspondence Analysis"
# It helps to see how the different species are correleted between each other in a plot.
# We take the date and reshape them in a simple manner.

# Lets assign a name to the vegan's library function decorana.

ord <- decorana(dune)
ord

# On the console, among the others, there are shown the values "axis lenghts", 
# these are the lenght of the 4 axes.
# So, how long is the range in each axes

# First we wrote the axes lenght
ldc1 = 3.7004
ldc2 = 3.1166
ldc3 = 1.30055
ldc4 = 1.47888
# We calculate the total to them
total= ldc1 + ldc2 +ldc3 +ldc4

# Percentage of each axes
pldc1 = ldc1 *100 /total
pldc2 = ldc2 *100 /total
pldc3 = ldc3 *100 /total
pldc4 = ldc4 *100 /total

# Lets see the values of the percentage
pldc1
pldc2
pldc3
pldc4

# Lets concentrate on the first two and lets see their cumulative percentage
pldc1 + pldc2

# They're representing the 71% of the whole variability.

# The final output or plot is 
plot(ord)

# The multivariate space is defined by two axes, DCA1 and DCA2
# the different names are the species, some of them are close others are far away.

#---------------------------

# 03.2 Communities Overlap


data(kerinci) #data set of Kerinci National park in Sumatra, Indonesia
head(kerinci)
#on the console different variables will appear
#the unit of time that we're considering is the day, so we will obtain 
#data from 0 to 1
summary(kerinci)
#this function will take the data set and make a 

#lets see the grpah of the movement of one of the specie during the day
#we will select the lines in the data set in which we have the animale
#that we want to monitor, in this case is the tiger
#we will use a language called Sps, using the [] which will collect info inside the data set
tiger <- kerinci[kerinci$Sps == "tiger",]
tiger #so this is the new data set in which I only have tigers

#selecting the time
Timerad <- kerinci$Time * 2 * pi
#we can add an additional coloumn in the data set in which we make the above calculation

#HOW TO ASSIGN A CALCULATION TO A NEW OBJECT WHICH IS INSIDE THE DATA SET?
#"Timerad" is the function and it will be the name of the new coloums
#This will measure time in radiants
kerinci$Timerad <- kerinci$Time * 2 * pi
tiger <- kerinci[kerinci$Sps=="tiger",]
tiger

tigertime <- tiger$Timerad
#now if we run this we will see that it has 4 coloumns
#now we will plot this time variable to see which are the peaks in time in which you can see the tiger
plot(tiger$Timerad)
densityPlot(tigertime, rug=TRUE)
#we will obtain a graphic in which we can see when we can see the tiger over 24 hours

#LETS DO THE SAME WITH MACAQUES
#exercise, select only the data on the monkeys
summary(kerinci)
macaque <- kerinci[kerinci$Sps=="macaque",]
macaque
head(macaque)

#now we will make a time variable with macaque
macaquetime <- macaque$Timerad
plot(macaque$Timerad)
par(mfrow=c(1,2))
densityPlot(tigertime, rug=TRUE)
densityPlot(macaquetime, rug=TRUE)

#lets plot them overlapped, to see when they will be at the same time in the same place
#we will use the function "overlapPlot"
overlapPlot(tigertime, macaquetime)


#---------------------------

# 04.1 Remote Sensing Data Visualization
install.packages("devtools") #we install it from CRAN
library(devtools)

# Devtools is used to install packages directly from other repository, such as github
# and not only directly from R.
# CRAN is the network of all the packages included in R
# github is also a packages comprehensory, those packages are additional to the CRAN's ones


# We will use the following images called sentinel as the project and dolomites, since the picures have been taken there
# the colors in the images are satelitte infrared images and each color has a correspondant band value.

# HOW DO WE IMPORT THE DIFFERENT LAYERS?
# we use the function im.import(name of the image of that specific layer)
devtools::install_github("ducciorocchini/imageRy", force=TRUE) #we install it from github, through devtools

library(imageRy)
3
install.packages("terra")
library(terra)

#lets use the same "im" prefix for each function
#now we will use this package

im.list()
b2 <- im.import("sentinel.dolomites.b2.tif")
b2

# Global circulation
# Latitude is the angle formed between the perpendicolar line that the point make on the elipsoide
# and the equator, so the angle of the latitude of a certain point P doesn't pass through the earth's centre
#even though the earth is always represented as a sphere, it actually is an elipsoide.

# If you have two different elipsoide, for the same point P you will obtian two measures
# as a value of the latitude at that point P
# one value will be higher than another, so it is not enough knowing which latitude we are using
# but we especially need also the geodetic datum (which elipsoide are we using to measure)
# or the value won't have any meaning.
# An example of system is WGS84 or world geodetic system
# UTM or Universal Transverse Mercator, cutting earth in angles and every one
# of them is 6 degrees. The earth is then divided in 60 zones. 
# They're numbered starting from Greenwhich. Italy is in the 32nd and 33rd zones.
# In general, if you want to overlap some datas, they must be in the same reference system
# this info are stated under the ''coordinates reference''.
# Overlapping= translation of a reference system in front of another.

# HOW TO OVERLAP TWO ELEMENTS?
# By using a six parameters transformation= translation in x,y,z and rotation in x,y,z.


# Lets change the colors of the b2
cl2 <- colorRampPalette(c("black", "grey", "white")) (100)
plot(b2, col=cl2)
# The more the blue is reflected, the closer to the minimum value (black) 2000 we are
# opposite, the more the blue is absorbed, the closer to the maximum value (white color) 5000 we will be

#EXERCISE
# Import the green band from sentinel-2 (band 3)
# This is where the green is absorbed and reflected
b3 <- im.import("sentinel.dolomites.b3.tif")
b3
cl3 <- colorRampPalette(c("black", "grey", "white")) (100)
plot(b3, col=cl3)

# Lets plot them all together
par(mfrow=c(1,2))
plot(b2, col=cl2)
plot(b3, col=cl3)


#---------------------------

# 04.2 


# Brief recap of the past lesson

install.packages("terra")
library(terra)
install.packages("devtools")
library(devtools)
devtools::install_github("ducciorocchini/imageRy", force=TRUE) 
3
library(imageRy)
im.list()
b2 <- im.import("sentinel.dolomites.b2.tif")
b2

cl <- colorRampPalette(c("black", "grey", "white")) (100)
plot(b2, col=cl)

b3 <- im.import("sentinel.dolomites.b3.tif")
b3

plot(b3, col=cl)


b4 <- im.import("sentinel.dolomites.b4.tif")
b4

plot(b4, col= cl)

b8 <- im.import("sentinel.dolomites.b8.tif" )
b8

plot(b8, col=cl)

# NEW FUNCTIONS IN R
# lets plot all the layers together in 2 rows and 2 columns
par(mfrow=c(2,2))
plot(b2, col=cl) #band 2 is blue
plot(b3, col=cl) #band 3 is green
plot(b4, col=cl) #band 4 is red
plot(b8, col=cl) #band 8 is near-infrared or nir

# we plotted all the layers
# to know the wavelenght, google the name of the numbered sentinel file 
# looking at the graphics:
# the low values on the right show the absorbance, instead the high show the reflectance (of each band)

# HOW TO STACK LAYERS OF IMAGE ALL TOGETHER INSIDE THE SAME OBJECT?  
# We simply create a concatenation between our objects of interest and we name it
stack <- (c(b2, b3, b4, b8))
stack

# Before running a new project, it is useful to close the past device
# HOW DO WE CLOSE THE PAST DEVICE?
# We use the dev.off() function
dev.off()

# now we can plot the new project, with all the layers and their data collected in the same object/stack
plot(stack, col= cl)

# HOW TO PLOT ONLY ONE LAYER OF OUR STACK?
# We use the function: (name.of.our.object [[number of the lyrs of interest]], col= )
plot(stack[[4]], col=cl)

# WHAT IS REFLECTANCE?
# it is a ratio between reflected radiant flux (energy) and the incident radiant flux (energy)
# if the reflected energy is the same as the incident, you're reflecting all the possible energy
# if the reflectance energy is zero, it means you're absorbing all the reflecting energy

# IMPORTANT! We must use integers and not float numbers to allow R software to understand our codes

# EXERCISE
# Plot in multiframe the bands with different colorRampPalettes

par(mfrow=c(2,2))
plot(b2, col=cl2) 
cl2 <- colorRampPalette(c("darkblue", "cyan", "white")) (100)
plot(b3, col=cl3) 
cl3 <- colorRampPalette(c("darkgreen", "green", "white")) (100)
plot(b4, col=cl4) 
cl4 <- colorRampPalette(c("darkred", "red", "coral")) (100)
plot(b8, col=cl8)
cl8 <- colorRampPalette(c("red", "orange", "yellow")) (100)

# RGB space, it stays for RedGreenBlue
# As we have seen, our stack is composed by differnt band associated with different colors and different numbers: 
# band2, blue element number 1, in code terms (stack[[1]])
# band3 green element number 2,(stack[[2]])
# band4 red element number 3, (stack[[3]])
# band8 infrared element number 4, (stack[[4]])

# HOW DO WE PLOT THE THREE LAYERS ONE ON THE TOP OF THE OTHERS?
# We use the function "im.plotRGB()", this allow R to create an image fully colored (as human being can see).
im.plotRGB(stack, r=3, g=2, b=1)


#---------------------------

# 05 Spectral Indices in R

pairs(stack)
#Pearson correlation coefficient
#hyper correlation of 0.99 and 1.00
#if you use the near infrared you can see that the correlation is still present but it is lower
#with values netween 0.70 and 0.75
#first and second band goes together

#VEGETATION INDEX or DVI INDEX
#it is a index of vegetation's health 
#if a plant is suffering the vegetation index will increase, instead if is not suffering
#the index will decrease and have a small value

#we are going to make the difference between the near infrared and the 

library(imageRy)
library(terra)
install.packages("ggplot2")
library(ggplot2)
install.packages("viridis")
library(viridis)

im.list()
#to know information about any file description go on ducciorocchini repository and 
#under the line of ImageRy you will ind them, now we will use the "matogrosso"
#these images come from the NASA earth observatory, about deforestation in the region of Rio Peixoto in Brasil

m1.2006 <-im.import("matogrosso_ast_2006209_lrg.jpg" )
m1.2006

m1.1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m1.2006
#bands: 1=NIR 2=RED 3=GREEN
im.plotRGB(m1.1992, r=1, g=2, b=3) #near infrared on top of the red and other componentes and so all the vegetation will become green
#we can compare the density of vegetation in the area between 1992 and 2006
par(mfrow=c(1,2))
im.plotRGB(m1.1992, 1, 2, 3)
im.plotRGB(m1.2006, r=1, g=2, b=3)

#to see it in blue and yellow colors
im.plotRGB(m1.2006, r=2, g=3, b=1)
im.plotRGB(m1.1992, r=2, g=3, b=1)


#---------------------------

# 06 Time Series Data

install.packages("terra")
library(terra)
install.packages
install.packages("devtools")
library(devtools)
devtools::install_github("ducciorocchini/imageRy", force=TRUE)
library(imageRy)
3
#First of all we import sentinel data from the NO concentration during COVID time
#We need to use the im-list function because we will import images
im.list()
EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png")

#lets plot the two images together
par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

#to continue lets first clean the device
dev.off()

#We can make a sort of "mathematical difference" between the two images
#Basically, what we are doing is making a difference between the data set of the first image
#and the data set of the second image
diff = EN01[[01]] - EN13 [[01]]
diff
plot(diff)

#lets change the color palette by using the ColorRampPAlette function
cl.diff <- colorRampPalette(c("black", "blue", "white", "red")) (100)
plot(diff, col=cl.diff)

#by looking at the image we can say that everything that is red will be higher in the first term of the year
#in January instead everything that is black will be higher during the second time of the year in March
#This difference shows how, during COVID time, the NO concentration in atmosphere low down in all the European area 
#because of the stop of vehicules circulation

#Now we will use LST data "Low Stat Temperator" and the images are about the retreats of ice sheets in Greenland
#The images and the data are downloaded from Copernicus Global Land Service
#The blue part is going to restrict year by year, instead the black one is going to increase
g2000 <- im.import("greenland.2000.tif")
plot(g2000, col=cl)

g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

cl.g <- colorRampPalette(c("black", "blue", "white", "red")) (100)
par(mfrow=c(1,2))
plot(g2000, col=cl.g)
plot(g2015, col=cl.g)

dev.off()

#we can now concatenate them as a stack and them plot all the layers together
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg, col=cl.g)

#EXERCISE: make the difference between the first and the last element of the stack
diff.g = stackg[[1]] - stackg [[4]]
plot(diff.g, col=cl.g)

#in the middle we are loosing in term of low temperators, it means that that part is particular sensitive to 
#temperate changes. This is due to climate change. The range of the image will go from 1000 to -1000

#Now we can use the RGB space to plot 3 of our 4 images, one in each channel
#first element in red, second in green and third in blue
#According to in which year we have higher values, the corresponding image (plot) will have the color of that specific year

#EXERCISE: make an RGB plot using the different years of the stack
im.plotRGB(stackg, r=1, g=2, b=3)
#it is greenish and then blueish, it means that the highest temperators can be found in the last period


#----------------------------------

# 07 External Data


#Working directory=
#We need to create a folder in which we download all the images (from Earth observatory as an example) 
#and so where all the data are stored.
#We then will import the new folder, already present in our computer, inside R. 
#This folder will be our working directory in R.

install.packages("terra")
library(terra)

#The "getwd" is the function that we use to know how to write our path
getwd()

#function "set working directory" inside parenthesis we write the path 
setwd("/Users/riolli/Desktop/images_R")
setwd
#Now we will insert the name of the downloaded image
naja.2023 <- rast("najafiraq_etm_2003140_lrg.jpeg")

#To plot the image directly in terra we will use the function
plotRGB(naja.2023, r=1, g=2, b=3)

#We import the second image
naja.2003 <- rast("najafiraq_oli_2023219_lrg.jpeg")
plotRGB (naja.2003, r=1, g=2, b=3)

#now we plot the two images together
par(mfrow=c(2,1))
plotRGB (naja.2003, r=1, g=2, b=3)
plotRGB(naja.2023, r=1, g=2, b=3)

#We can make the difference between the two of them
najadiff= naja.2003[[1]] - naja.2023[[1]]
najadiff
najacol <- colorRampPalette(c("brown", "grey", "orange"))(100)
dev.off()
plot(najadiff, col=najacol)

#lets apply the same codes for other images, in this case the selected images are from the recent Arno flooding
#Showing the difference between October, before the floods, and November, right after them

tuscany.October2023 <- rast("italyflooding_oil_2023275.jpeg")
plotRGB(tuscany.October2023, r=1, g=2, b=3)
tuscany.November2023 <- rast("italyflooding_oil_2023307.jpeg")
plotRGB(tuscany.November2023, r=1, g=2, b=3)

par(mfrow=c(2,1))
plotRGB(tuscany.October2023, r=1, g=2, b=3) #green
plotRGB(tuscany.October2023, r=2, g=1, b=3) #near-infrared
plotRGB(tuscany.October2023, r=3, g=2, b=1) #blue

plotRGB(tuscany.November2023, r=1, g=2, b=3) #//
plotRGB(tuscany.November2023, r=2, g=1, b=3) #//
plotRGB(tuscany.November2023, r=3, g=2, b=1) #//

tuscanycol <- colorRampPalette(c("brown", "black", "orange")) (100)
difftuscany = tuscany.October2023[[1]] - tuscany.November2023 [[1]]
dev.off()

#in orange we can observe the water flooding in the area between Prato and the gulf of Livorno
plot(difftuscany, col=tuscanycol)


#------------------------------------------

# 08 Copernicus Data

# Today we will import data from Copernicus website, where the extension of data is .nc
# To be able to read them, R needs the "ncdf4" package

install.packages("ncdf4")
library(ncdf4)

# Data available at:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html
 # Today we will import data from Copernicus website, where the extension of data is .nc
# To be able to read them, R needs the "ncdf4" package

# We will explain to R in which outside folder the data are going to be stored
# Working directory
getwd()

# HOW TO CHANGE AND SET THE NEW WORKING DIRECTORY? 
# By using the "setwd" function

setwd("/Users/riolli/Desktop/GCE/R/images_R/")

# We then import the presaved object and rename it

soil_moisture_2023 <- rast("c_gls_SSM1km_202311140000_CEURO_S1CSAR_V1.2.1.nc")
plot(soil_moisture_2023) # "noise" are the errors

# To plot a single image 
plot(soil_moisture_2023[[1]])

# We change the colors with the ColorRampPalette function
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(soil_moisture_2023 [[1]], col=cl)


# min and max long and min and max lat

ext <- c(60, 67, 30, 35) 

#function crop to crop the image by using as extension of the image the max and min values of lat and long that we settled before
soil_moisture_crop <- crop(soil_moisture_2023, ext)
plot(soil_moisture_crop[[1]], col= cl)


#----------------------------------

# 09 Classification

# Classifying satellite images and estimate the amount of change


library(terra)
library(imageRy)
im.list()

# Image from the solar orbit
solar <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
solar

# HOW TO CREATE A CLASSIFIED IMAGE?
# By using the im.classify function and by setting the number of clusters.
# cluster= different objects having same features, collected all together
solarc <- im.classify(solar, num_clusters = 3)
plot(solarc)
# White is the class with highest energy. Green is third cluster, lowest amount of energy is the yellow 
# The random set we used for classification is different everytime we use the classification function
# That's why my images are different from professor's ones. 
# So how can I generally state the correct energy pattern?
# We should apply this to the mato grosso forest to estimate the amount of change.
im.list()

?im.classify
mato1992 <- im.import("matogrosso_l5_1992219_lrg.jpg"  )                  
mato2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")                   

# By classifing the image and setting 2 clusters we can define the two spaces (human part=2 and forest=1)
m1992c <- im.classify(mato1992, num_clusters= 2)
plot(m1992c)

# lets do the same with the second image, where the human related class is amplified (cluster 2)
m2006c <- im.classify(mato2006, num_clusters=2)
plot(m2006c)
dev.off()
# let's plot them together
par(mfrow=c(1,2))
plot(m1992c[[1]])
plot(m2006c[[1]])

# We use the freq to determine which is the frequency of something of a certain population
f1992 <- freq(m1992c)
f1992

# Image that we want to calculate the percentage, simply dividing by the total number of pixels
# HOW DO WE CALCULATE THE NUMBER OF PIXELS WITHIN A IMAGE?
# By using the function ncell
tot1992 <- ncell(m1992c)
tot1992

# HOW DO WE CALCULATE THE PERCENTAGE?
# By dividing the frequency with the total number of pixels
perc1992 <- f1992 *100 / tot1992
perc1992

# We are going to take the percentage (from the console)
# Forest got 83% while human related area got 16%

# Lets do the same with the 2006 to see the difference
f2006 <- freq(m2006c)
f2006

tot2006 <- ncell(m2006c)
tot2006

p2006 <- f2006* 100 / tot2006
p2006
# We've obtained that human related area got 54% while forest got 45%

# Lets make a graph with the two of them together
# We will create a dataframe first and build the final table
# HOW TO CREATE A DATA FRAME?
# By using the data.frame function
class <- c("forest", "human")
y1992 <-  c(83, 17)
y2006 <- c(45, 55)
mydf <- data.frame(class, y1992, y2006)
mydf

library(ggplot2)

#final plot
# aes is aesthetics where x is the class, y is the columns related to the years (values of human/forest precences percentage in this case)
# the color is related to the class (human class will have one color, forest another)
# geombar is because we'll use an histogram. It is normally related to stathistics, so you can use the function to calculate mean, median and so on
# in our case we will only use the identity so the data that we've already imported in our data frame. The fill is to fill the bar with a certain color

p1 <- ggplot(mydf, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p1

p2 <- ggplot(mydf, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p2



#------------------------------

# 10 Variability

#measuring of RS based variability 
#important in abiotic and biotic component

#libraries we need
library(imageRy)
library(terra)
library(viridis)

im.list() #to see all the files there are 

sent <- im.import("sentinel.png") #we imported our data
#in this case, band1=NIR, band2=red, band3=green
im.plotRGB(sent,r=1,g=2,b=3) #vegetation is red
im.plotRGB(sent,r=2,g=1,b=3) #vegetation is green

#we want to understand the variability using the standard deviation

nir<-sent[[1]]
plot(nir) #green part are vegetation, bare soil is orange. we have 256 values so we are working with bits

#to calculate variability, we use the moving window methods
#we calculate the standard deviation for a the central pixel of a few pixel with one moving window
#and then we move to calculate the others sd. at the end the moving window will pass from one pixel to the others
sd3<-focal(nir, matrix(1/9,3,3), fun=sd) #function that makes the calculation of the sd with moving window
#matrix describes the dimension of the moving windows. it is composed of 9 pixels, from 1 to 9, 3 by 3 pixels
#function tells what function we want to use, that in this case is sd.
plot(sd3)
#let's change the legend by using the package called virisid 
#we are using the 7 colours of the viridis legend
viridisc<-colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)
#by watching where the sd is higher, we can see where the variability is higher
#in this case is north-west as there are some glaciers and geomorphological uncertaintanties


#let's calculate the variability in 7x7 moving windows
sd7<-focal(nir, matrix(1/49,7,7), fun=sd)
plot(sd7, col=viridisc)

#let's plot via par(mfrow()) the 3x3 and the 7x7 sd
par(mfrow=c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc) #the effect of higher variability is due to the additional pixels we are including

#original image+sd plot all together
par(mfrow=c(1,2))
im.plotRGB(sent,r=2,g=1,b=3)
plot(sd7, col=viridisc)
#we can compare directly the two images. 
#high sd can mean or geological variability or species variability

#how to choose the layer to which apply the sd calculation?
#here we chose NIR, but we need a method
#this method is the multivariate analysis



#----------------------------------

# 11 PCA


# measuring variability from RS imagery

library(terra)
library(imageRy)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

im.plotRGB(sent, 1, 2, 3)

nir <- sent[[1]] 
#standard deviation can be calculated only for one band, that' why then we will apply multivariate analysis

# EXERCISE
# To calculate variability in a 7x7 moving window
sd7 <-focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridis)

# To plot together the 7x7 and the 3x3
par(mfrow=c(1,2))
plot(sd7, col=viridis) #here you have more variability because the focal window is bigger so you include more pixels
plot(sd3, col=viridis)

#to have the rgb plot of the original image and the standard deviation ot the right 
par(mfrow=c(1,2))
im.plotRGB(sent, r=2, g=1, b=3)
plot(sd7, col=viridis)

#high variability in the ecosystem means more species living in the ecosystem

calculation
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # function focal can be used for other stathitistic calculation (always for only one layer)

viridis <- colorRampPalette(viridis(7))(255)
plot(sd7, col=viridis)

#when you have a 4th element how do you do?
#compact the three bands of sentinel for example in only one band (stack them)
#also because standard variation can be calculated only for a layer. in this way we can calculate sd for the three bands
# the axis where the widest range of the data lays is called principal component 1
# the axis perperndicular to the first is called second principal component and is where the smallest range of data lays

# we will use pca
# first we take sentinel data and, instead of choosing only one band, we perform pca, than we take the first principal components and use it for the calculation
im.list()
sent <- im.import("sentinel.png")
pairs(sent) 
dev.off()

#Now we perform PCA
sentpc <- im.pca2(sent)
pc1 <- sentpc$PC1 #we link it with PC1 value
plot(pc1, col=viridis)
viridis <- colorRampPalette(viridis(7))(255)
pc1.sd3 <- focal(pc1, matrix(1/9, 3,3), fun=sd)
plot(pc1.sd3, col=viridis)

pc1.sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1.sd7, col=viridis)

# we basically choose all the bands that we wanted to calculate
# we plot all together, again we can also use the stack function
par(mfrow=c(2,3))
im.plotRGB(sent, r=2, g=1, b=3)
plot(sd3, col=viridis) #the standard deviaiton is showing the amount of variability in a moving window, more local
plot(sd7, col=viridis) #wider moving window
plot(pc1, col=viridis)
plot(pc1.sd3, col=viridis) 
plot(pc1.sd7, col=viridis)

#or

# we than obtain the sd value
