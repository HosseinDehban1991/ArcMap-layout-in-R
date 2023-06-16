
library(raster)
library(rgdal)
library(devEMF)
library(extrafont)

r0 <- raster("raster.tif")
shp  <- readOGR("Basic shp", layer = "OstanOk")
shp2  <- readOGR("Basic shp", layer = "khazar_sea")
shp3  <- readOGR("Basic shp", layer = "Khalig_sea")
shp4  <- readOGR("Basic shp", layer = "World")

r <- disaggregate(r0,5, method="bilinear")

# Set up the breaks for the classified legend
breaks <- c(0, 5, 10, 25, 50, 75,100,150,1000)

# Set up the colors for each class
colors <- c("white", "#BEFCE8", "#73DFFF", "#00C5FF", "#0070FF","#3E3BFF","#8400A8","#73004C")
# Classify the raster based on the breaks
rc <- cut(r, breaks = breaks)
e <- extent(44,64,25,40)
# e <- extent(41,63.5,22,41)

# emf("Plot2.emf" )
emf("Plot2.emf" ,width = 10, height = 8 ,coordDPI = 200)

par(mar = c(2, 2, 2, 2)  ) # Set the margin on all sides to 2

plot(rc, col = colors, legend = FALSE ,interpolate=TRUE , ext=e )


plot(shp, add = TRUE, lwd = 1.5)
plot(shp4, col= "white" ,add = TRUE, lwd = 1.5)
plot(shp2, col= "white" ,add = TRUE , lwd = 1.5)
plot(shp3, col= "white" ,add = TRUE, lwd = 1.5)

box(col = "black",lwd = 2)

text(shp, shp$ostan_Fnam ,  cex=0.9, pos=3, font=2)  
text(shp2, shp2$name ,  cex=0.8, pos=3, font=2)  
text(shp3, shp3$NAME ,  cex=0.8, pos=c(4), font=2)  


legend("bottomleft", legend = c("0-5", "5-10", "10-25", "25-50", "50-75","75-100","100-150",">150"), 
       fill = colors,cex=1 ,title = "mm" ,bg="white",title.cex = 1.1)

dev.off()


