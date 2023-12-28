# why populations disperse in a certain manner?
#species distribution model sdm

library(sdm)
library(terra) #used in spatial function

#function sysrem.file to catch file in the R system (search for the file in the folders to import) with path for the folder external

file <- system.file("external/species.shp", package="sdm")

#now we use the file (usually a vector file)

#example: rana temporaria

rana <- vect(file)
rana$Occurrence #to see inside rana (0s and 1s)

#we get presences and absences data(for each point 1 or 0 shows either if the organism is there or not, NOT how many organisms (that would be budance))
# 0 could be missing data -> uncertanty
# to see the data:

plot(rana)
## let's try to only see the presences (1)
pres <- rana[rana$Occurrence == 1,]
plot(rana[rana$Occurrence == 1,],col='blue',pch=16)

#from sql language (==). to close the query -> ,]

#selecring absences

abs <- rana[rana$Occurence == 0 ,]
plot(abs)

#plot pres and abs one beside the other

par(mfrow=c(1,2))
plot(pres)
plot(abs)

#new friend: dev.off for graphical nulling

plot(pres, col="dark blue")
points(abs, col="light blue")

#predictors: env variables
#we use not vect but rasters (asci) to import:

elev <- system.file("external/elevation.asc", package="sdm")

elevmap <- rast(elev) #from terra package
plot(elevmap)

points (pres, cex=.5)

#to do the same with temperature

temp <- system.file("external/temperature.asc", package="sdm")
tempmap <- rast (temp)
plot(tempmap)
points(pres, cex=.7)

#same with vegetation
vege <- system.file("external/vegetation.asc", package="sdm")
vegemap <- rast(vege)
plot (vegemap)
points(pres, cex=.7)

#precipitation

prec <- system.file("external/precipitation.asc", package="sdm")
precmap <- rast(prec)
plot (precmap)
points(pres, cex=.7)

#multiframe with everything
par(mfrow=c(2,2))
plot(elevmap)
points(pres, cex=.7)
plot(tempmap)
points(pres, cex=.7)
plot (vegemap)
points(pres, cex=.7)
plot (precmap)
points(pres, cex=.7)

#OR plot(c(elevmap, tempmap, vegemap, precmap)), ma complicato poi aggiungere i punti

#OR loop (at end of the course)
