##time series analysis (ex: pollution through coronavirus)
library (imageRy)
library (terra)

im.list()
#many begin with EN (European Nitrogen), we import the first one
#jan
EN01 <- im.import("EN_01.png")
#march
EN13 <- im.import("EN_13.png")

#to plot them sogetehr:

par(mfrow=c(2,1))
im.plotRGB.auto (EN01)
im.plotRGB.auto (EN13)
#auto means it uses first 3 bands automatically

#to get the differences between the 2 maps:
#we can make the difference for each specific components/bands or the difference of them alltogether.
#first element 4 example

dif1 = EN01[[1]]-EN13[[1]]
plot(dif1) #perchè non im.plotrgb?

#to change color palette:
cl <- colorRampPalette(c("blue", "white", "red"))(100) 
plot(dif1, col=cl)
#red= higher in jan and blue=higher value in march

#data about ice melt and t change in greenland--> copernicus
im.list()
#"greenland.2000.tif"                                
# "greenland.2005.tif"      
#"greenland.2010.tif"                                
#"greenland.2015.tif"  are temperature data from greenland of surface t, not air t

g2000 <- im.import("greenland.2000.tif")
plot(g2000, col=cl)

#to import avery image:
g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

par(mfrow=c(1,2))
plot(g2000, col=cl)
plot(g2015, col=cl)

#stacking the data, in this case we only have one layer
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg)

#difference between first and last element
difg= g2000-g2015
or
difg <- stackg[[1]]-stackg[[4]]

plot(difg, col=cl)

#next lecture: import our own data (not imageRy)
#element of stackg correspond to different images, we put them in rbg system and each will be represented by a color (1->red, 2->ble, 3->green)

#to make an rgb plot using different years:
im.plotRGB(stackg, r=1, g=2, b=3)
#the colors we get show when the temperature was higher in that place (red=2000, green=2005 black/darkblue=2010)
