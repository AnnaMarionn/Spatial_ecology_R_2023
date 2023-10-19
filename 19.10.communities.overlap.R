#recognize species and count them through cameras with movement sensors
#relation among species through time
#using overlap package and data from kerinci national park in indonesia
#duccio and harini in biodiversity and conservation
data(kerinci)
head(kerinci) #shows times and species seen during the day (time scaled from 0 to 1)
summary(kerinci) #sps=species

#now we only want the tiger
#we use sql: we use the name of the data and square parenthesis and $ to relate data ans column
tiger <- kerinci[kerinci$sps=="tiger", ]
#now we have a "new dataset with only tigers

#to get from linear to radiant for time: we multiply time by 2pi
kerinci$Time*2*pi
#now we add a column fro the time in radiant
kerinci$TimeRad <- kerinci$Time*2*pi

#we launch tiger again to overwrite
tiger <- kerinci[kerinci$Sps=="tiger", ]

#plot
plot(tiger$TimeRad)

#or

timetiger <- tiger$TimeRad
densityPlot(timetig, rug=TRUE)

#now with macaque
macaque <- kerenci[kerinci$sps=="macaque",]
timemac <- macaque$TimeRad
densityPlot(timemac, rug=TRUE)

#overlap trough the day with overlapPlot function 
overlapPlot(timetiger, timemac)
