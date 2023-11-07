#7/11
#bands 2,3,4,8 correspond to elements ([[x]]) based on the wavelenghts that gets reflected differently by different parties in the rgb scheme of components of colors in computers
#we're gonna ??????
# RGB space
# stacksent: 
# band2 blue element 1, stacksent[[1]] 
# band3 green element 2, stacksent[[2]]
# band4 red element 3, stacksent[[3]]
# band8 nir element 4, stacksent[[4]]
im.plotRGB(stacksent, r=3, g=2, b=1)

#we get rid of the color blue (1)
im.plotRGB(stacksent, r=4, g=3, b=2)
#we get an image where we get the infrared that shoes the different kinds of vegetation (that reflect strongly the infrared wavelenght) so gives us more information
#we can change again the position of the infrared, so every part that is vegetation (4) will appear green (g)
im.plotRGB(stacksent, r=3, g=4, b=2)
#in violet we'll get bare soil (we are now sure how to differenciate from water
#another composition to see the infrared--> blue component=vegetation, yellow will become soil (cities/urbanisation)
im.plotRGB(stacksent, r=3, g=2, b=4)

#reflectance= ratio between incident and reflected radiation

#to see correlation between bands: by confronting value of reflectance for different bands for the same pixels
#stacksent gets all the information (billions of pixels)
#pairs also called scatterplot matrices, very useful for pairwise correlation with any kind of table
?pairs
#4 bands, multiply by 3 and divided by 2 to get all the correlations, now we use pairs wth stacksent

pairs(stacksent)
#we get a graph with pearson correlation and scatterplots that symbolise how strong and linear the correlation actually is. the histogram show the reflactance values frequency for the different bands

#ndvi is a vegetation index based on the difference between near infrared and red reflectance (this value gives us information on the health of the plant)
#more infrared then red is expected for healthy plants(robust enough to reflect infrared and do photosynthesis)--> the same pixel will have different reflectance for red and infrared
#nir(higher value) - red(low value) calculated for each plant (pixel), low value for this calculation shows unhealthy plant 
#also same measurements on same sites that give different values will give information of the effect of any activity on vegetation

