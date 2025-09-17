###### Libraries ######

library (terra)      # for geospatial raster data analysis
library (viridis)    # colorblid friendly palettes
library (ggplot2)    # graph visualization 
library (imageRy)    # for satellite image processing and PCA visualization

###### Color palettes #######
# I define color palettes using the viridis package to ensure accessibility 
# for colorblind users. These are used consistently to plot data.
viridisc <- colorRampPalette(viridis(7))(255)
mako <- colorRampPalette(mako(7))(255)
magma <- colorRampPalette(magma(7))(255)

# For classification graphs:
cl_plots <- viridis(4)

# Lastly I define four color palettes to plot bands separately
# B2 - blue
clb <- colorRampPalette(c("blue", "lightblue", "white")) (100)
# B3 - green
clg <- colorRampPalette(c("darkgreen", "green", "white")) (100)
# B4  - red
clr <- colorRampPalette(c("red", "orange", "white")) (100)
# B8 - nir
cln <- colorRampPalette(c("purple", "pink", "white")) (100)

###### Import function ######
# The SpatRaster files used in this project were gathered from the Copernicus Browser,
# specifically from Sentinel-2. Instead of importing and cutting each file individually,
# I create a function, called "import_crop()". 
# Inputs: acquisition date/time code (year), bands to load (band), extent of bounding box (ext),
# path using paste0() concatenating function (path).
# Output: a list of SpatRaster objects corresponding to the selected bands and area of interest.

import_crop <- function(year, band, ext, path = ".") {
  filename <- file.path(path, paste0("T32TQR_", year, "_B", band, ".jp2"))
  r <- rast(filename)
  crop(r, ext)}

# I define the baseline bands that I will import for each date:
bands <- c("02", "03", "04", "08")

# While for the drought analysis, I will use bands 8A, 11 and 12 aswell
bands_drought <- c("02", "03", "04", "08", "8A", "11", "12")

# For the Montello area, I use the following extent (xmin, xmax, ymin, ymax):
ext_montello <- ext(735000, 749400, 5074500, 5085000) 

# To analyse the Grave di Ciano area, instead, I crop using this extent:
ext_grave <- ext(735000, 742000, 5078500, 5083500)

# Finally, for the variation analysis, I crop the river bed out of the frame:
ext_vegetation <- ext(735950, 738500, 5079750, 5081300)
# extents are in TM Zone 32N coordinates (EPSG:32632), in meters.

###### 1) Land cover analysis: 2016-2023 - Montello ######

# Objective: study the land cover change between 2016 and 2023 in the Montello area.
# To do that, I use thresholds of the NDVI to classify the area
# and get the percentages of each category trough the years.

# Importing 2016 data:
year2016 <- "20160628T101032"
bands_2016 <- lapply(bands, function(b) import_crop(year2016, b, ext_montello))
names(bands_2016) <- paste0("B", bands)
stack_2016 <- c(bands_2016$B02, bands_2016$B03, 
                bands_2016$B04, bands_2016$B08)
# Plotting real color satellite view:
montello_2016_rc <- im.plotRGB(stack_2016, 3, 2, 1)

# Importing 2023 data:
year2023 <- "20230811T101031"
bands_2023 <- lapply(bands, function(b) import_crop(year2023, b, ext_montello))
names(bands_2023) <- paste0("B", bands)
stack_2023 <- c(bands_2023$B02, bands_2023$B03, 
                bands_2023$B04, bands_2023$B08)
montello_2023_rc <- im.plotRGB(stack_2023, 3, 2, 1)

# To compare visually, I plot the false color images:
par(mfrow=c(1,2))
montello_2016_fc <- im.plotRGB(stack_2016, 4, 3, 2)
montello_2023_fc <- im.plotRGB(stack_2023, 4, 3, 2)

# Calculating Normalized Difference Vegetation Index for each year:
ndvi_2016 <- (bands_2016$B08 - bands_2016$B04) /
  (bands_2016$B08 + bands_2016$B04)

ndvi_2023 <- (bands_2023$B08 - bands_2023$B04) /
  (bands_2023$B08 + bands_2023$B04)

# 1) im.classify(): automatic grouping through k-means clustering.
classified2016 <- im.classify(ndvi_2016)
classified2023 <- im.classify(ndvi_2023)
# This method classifies the area in 3 main categories 
# (1-Water and Human settlements, 2-Stressed Vegetation, 3-Healthy Vegetation).

# 2) NDVI thresholds from literature:
class_matrix <- matrix(c(
  -Inf, 0.2, 1,       # "Water/Humans"
  0.2, 0.5, 2,        # "Grassland/Stressed vegetation"
  0.5, Inf, 3),       # "Healthy"
  ncol=3, byrow=TRUE)

ndvi_2016_class <- classify(ndvi_2016, rcl = class_matrix)
ndvi_2023_class <- classify(ndvi_2023, rcl = class_matrix)

# Plotting the classifications:
par(mfrow=c(2,2))
plot(classified2016, col=viridisc, main ="NDVI 2016 k-means")
plot(classified2023, col=viridisc, main ="NDVI 2023 k-means")
plot(ndvi_2016_class, col= viridisc, main="NDVI 2016")
plot(ndvi_2023_class, col=viridisc, main="NDVI 2023")

# Using the frequencies for each class, I create stacked barplots comparing how land use changed from 2016 to 2023:
freq_2016 <- freq(ndvi_2016_class)
percent_2016 <- freq_2016$count / sum(freq_2016$count) * 100

freq_2023 <- freq(ndvi_2023_class)
percent_2023 <- freq_2023$count / sum(freq_2023$count) * 100

print(data.frame(Class=freq_2016$value, Percent2016=percent_2016, Percent2023=percent_2023))

# Visualizing the change through the years:
class_names <- c("Water/Human", "Grassland/Stressed vegetation", "Healthy vegetation")

df <- data.frame(Class = rep(class_names, times = 2),
                 Percentage = c(percent_2016, percent_2023),
                 Year = rep(c("2016", "2023"), each = length(class_names)))

ggplot(df, aes(x = Year, y = Percentage, fill = Class, label = round(Percentage, 1))) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = cl_plots) +
  geom_text(position = position_stack(vjust = 0.5), size = 3, color = "white") +
  labs(title = "Vegetation Classification in the Montello Area",
       y = "Land Cover (%)", x = "") +
  theme_minimal()

###### 2) Summer 2022: severe drought - Grave di Ciano ######

# Area of interest: Grave di Ciano
# A protected Natura 2000 site hosting rare habitats and species of high conservation value.
# Located along the Piave River for about 940 hectares, it includes dry grasslands, riparian woodlands, and wet habitats.
# The area is currently under threat from a proposed flood retention basin project that would impact around 500 hectares of ecosystem.
                     
# First: visualizing the area (2024)
year2024lug <- "20240706T100601"
bands_2024lug <- lapply(bands, function(b) import_crop(year2024lug, b, ext_grave))
names(bands_2024lug) <- paste0("B", bands)
stack_2024lug <- c(bands_2024lug$B02, bands_2024lug$B03, 
                   bands_2024lug$B04, bands_2024lug$B08)
grave2024lug_rc <- im.plotRGB(stack_2024lug, 3, 2, 1)

# Plotting each band separately:
par(mfrow=c(2,2))
plot(stack_2024lug$T32TQR_20240706T100601_B02, col=clb)
plot(stack_2024lug$T32TQR_20240706T100601_B03, col=clg)
plot(stack_2024lug$T32TQR_20240706T100601_B04, col=clr)
plot(stack_2024lug$T32TQR_20240706T100601_B08, col=cln)
dev.off()

# In 2022 the Veneto region experienced, along with most of Italy, one of the most severe droughts in recent decades.

# Importing data from June and August 2022
# June 2022:
year2022jun <- "20220612T100559"
bands_2022jun <- lapply(bands_drought, function(b) import_crop(year2022jun, b, ext_grave))
names(bands_2022jun) <- paste0("B", bands_drought)

# Resampling of bands 8a, 11 and 12, which have resolution of 20m
bands_2022jun$B8A <- resample(disagg(bands_2022jun$B8A, 2), bands_2022jun$B02)
bands_2022jun$B11 <- resample(disagg(bands_2022jun$B11, 2), bands_2022jun$B02)
bands_2022jun$B12 <- resample(disagg(bands_2022jun$B12, 2), bands_2022jun$B02)

# Creating the stack with all bands:
stack_2022jun <- c(bands_2022jun$B02, bands_2022jun$B03, 
                   bands_2022jun$B04, bands_2022jun$B08, 
                   bands_2022jun$B8A, bands_2022jun$B11, bands_2022jun$B12)

# August 2022:
year2022ago <- "20220821T100559"
bands_2022ago <- lapply(bands_drought, function(b) import_crop(year2022ago, b, ext_grave))
names(bands_2022ago) <- paste0("B", bands_drought)

bands_2022ago$B8A <- resample(disagg(bands_2022ago$B8A, 2), bands_2022ago$B02)
bands_2022ago$B11 <- resample(disagg(bands_2022ago$B11, 2), bands_2022ago$B02)
bands_2022ago$B12 <- resample(disagg(bands_2022ago$B12, 2), bands_2022ago$B02)

stack_2022ago <- c(bands_2022ago$B02, bands_2022ago$B03, 
                   bands_2022ago$B04, bands_2022ago$B08, 
                   bands_2022ago$B8A, bands_2022ago$B11, bands_2022ago$B12)

# Importing data from June and August 2019 to compare
# June 2019:
bands_2019jun <- lapply(bands_drought, function(b) import_crop(year2019jun, b, ext_grave))
names(bands_2019jun) <- paste0("B", bands_drought)

bands_2019jun$B8A <- resample(disagg(bands_2019jun$B8A, 2), bands_2019jun$B02)
bands_2019jun$B11 <- resample(disagg(bands_2019jun$B11, 2), bands_2019jun$B02)
bands_2019jun$B12 <- resample(disagg(bands_2019jun$B12, 2), bands_2019jun$B02)

stack_2019jun <- c(bands_2019jun$B02, bands_2019jun$B03, 
                   bands_2019jun$B04, bands_2019jun$B08, 
                   bands_2019jun$B8A, bands_2019jun$B11, bands_2019jun$B12)

# August 2019:
year2019ago <- "20190827T101029"
bands_2019ago <- lapply(bands_drought, function(b) import_crop(year2019ago, b, ext_grave))
names(bands_2019ago) <- paste0("B", bands_drought)

bands_2019ago$B8A <- resample(disagg(bands_2019ago$B8A, 2), bands_2019ago$B02)
bands_2019ago$B11 <- resample(disagg(bands_2019ago$B11, 2), bands_2019ago$B02)
bands_2019ago$B12 <- resample(disagg(bands_2019ago$B12, 2), bands_2019ago$B02)

stack_2019ago <- c(bands_2019ago$B02, bands_2019ago$B03, 
                   bands_2019ago$B04, bands_2019ago$B08,
                   bands_2019ago$B8A, bands_2019ago$B11, bands_2019ago$B12)

# Real color visual analysis: summer 2022 compared to 2019
par(mfrow=c(2,2))
im.plotRGB(stack_2019jun, 3, 2, 1)
mtext("June ", side = 4, line = .2, col = "black", cex = 1.2)
im.plotRGB(stack_2019ago, 3, 2, 1)
im.plotRGB(stack_2022jun, 3, 2, 1)
mtext("August ", side = 4, line = .2, col = "black", cex = 1.2)
im.plotRGB(stack_2022ago, 3, 2, 1)

# To assess stress from drought: SWIR composite band:
# By stacking bands 8A (Strict Infra-Red), 11 (SWIR1) or 12 (SWIR2) and 4(Red)
# I obtain a false color image of water stress in June and August 2022:
comp_swir_2022ago <- c(bands_2022ago$B12, bands_2022ago$B8A, bands_2022ago$B04)
comp_swir_2022jun <- c(bands_2022jun$B12, bands_2022jun$B8A, bands_2022jun$B04)

par(mfrow=c(1,2))
im.plotRGB(comp_swir_2022jun, r=1, g=2, b=3)
im.plotRGB(comp_swir_2022ago, r=1, g=2, b=3) 
# The enhanced red color indicates high SWIR2 reflectance, typical of stressed vegetation

# The index I use for the drought assessment is Gao's NDWI, used to evaluate water
# content in the vegetation.
# To calculate NDWI, bands 8 and SWIR1 are used:

# For 2019
ndwi_2019jun <- (bands_2019jun$B08 - bands_2019jun$B11) / 
  (bands_2019jun$B08 + bands_2019jun$B11)
ndwi_2019ago <- (bands_2019ago$B08 - bands_2019ago$B11) / 
  (bands_2019ago$B08 + bands_2019ago$B11)

ndwi_delta_2019 <- ndwi_2019ago - ndwi_2019jun
plot(ndwi_delta_2019, main = "NDWI Delta (June-August 2019)")

ndwi_2022jun <- (bands_2022jun$B08 - bands_2022jun$B11) / 
  (bands_2022jun$B08 + bands_2022jun$B11)
ndwi_2022ago <- (bands_2022ago$B08 - bands_2022ago$B11) / 
  (bands_2022ago$B08 + bands_2022ago$B11)

ndwi_delta_2022 <- ndwi_2022ago - ndwi_2022jun
plot(ndwi_delta_2022, main = "Delta NDWI (June-August 2022)")
dev.off()

###### 3) Biodiversity analysis 2025- Grave di Ciano ######

# Importing the area of the Grave which excludes the river bed, in order for the variance values to not be altered.
# More specifically, this is the area threatened by the expansion project.                       
bands_2025veg <- lapply(bands, function(b) import_crop(year2025, b, ext_vegetation))
names(bands_2025veg) <- paste0("B", bands)
stack_2025veg <- c(bands_2025veg$B02, bands_2025veg$B03, 
                   bands_2025veg$B04, bands_2025veg$B08)

# I look at the correlation between the four bands considered:
pairs(stack_2025veg)

# Bands 2 (Blue), 3 (Green), and 4 (Red) show strong linear correlations (R ≈ 0.97),
# while Band 8 (NIR) shows much weaker association.
# The NIR band provides distinct spectral information, so I use it for the  heterogeneity analysis.

# Standard deviation through moving window (focal SD):
nir <- stack_2025veg$T32TQR_20250601T101041_B08

sd3 <- focal(nir, matrix(1/9, 3, 3), fun = sd)
plot(sd3, col=magma)

sd7 <- focal(nir, matrix(1/49, 7, 7), fun = sd)
plot(sd7, col=magma)

# Principal Component Analysis (PCA) for the whole stack:
pc_2025 <- im.pca2(stack_2025veg)
pc1_2025 <- pc_2025$PC1
plot(pc1_2025, col=mako)

pc1sd3 <- focal(pc1_2025, matrix(1/9, 3, 3), sd)
plot(pc1sd3, col=magma)

pc1sd7 <- focal(pc1_2025, matrix(1/49, 7, 7), sd)
plot(pc1sd7, col=magma)

# Plotting all sd together:
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col=viridisc)
# These plots highlight habitat edges and spatial heterogeneity.
# High values can be observed where land cover type changes.

# Printing mean and deviation for all four layers:
global(sdstack, fun = "mean", na.rm = TRUE)
global(sdstack, fun = "sd", na.rm = TRUE)

#             mean
# sd3    19.017903 - Relatively high deviation at smaller scale (3x3)
# sd7     4.892953
# pc1sd3 19.020162 - The PCA effectively captures the heterogeneity
# pc1sd7  5.018984   

#               sd
# sd3    11.808514
# sd7     2.414155
# pc1sd3 11.680534
# pc1sd7  2.437728
