#external data
library(terra)

#to set working directory we're working with:
#(in slash: pwd)
#file-> properties-> path to directory: C:\Users\annam\Desktop\unibo\Spatial Eco. R
#for windows users-> C:\\ <- not good!Just text showed by windows to not let you get into the file it must be C://path/downloads or whaterver
setwd("C://Users/annam/Desktop/unibo/Spatial Eco.R")

#im.import we put name of the image: in this case we use rast("")
#sometimes windows mask the extention (.jpeg)--> click on properties to see it, then write the extension at the end of the name
naja <- rast("najafiraq_etm_2003140_lrg.jpg")

#to plot: plotRGB, equal to im.plotRGB :
plotRGB(naja, r=1, g=2, b=3)
