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

