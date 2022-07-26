# Introduction to Spatial Data in R

# tmap package is one of the current strongest packages to build thematic maps
# in R. It has a syntax similar to ggplot and works with sf objects.

library(sf)
library(tmap)
library(dplyr)

# Loading data -----------------------------------------------------------------
data("World")
World # checking data
View(World)


# Exploring --------------------------------------------------------------------
# package tmap has a syntax similar to ggplot. The functions start all with tm_
tm_shape(World) +
  tm_borders()

# Simple examination of the characteristics of object World
head(World)
names(World) # column names
class(World) # "sf"         "data.frame"
dplyr::glimpse(World)
class(World$name)
class(World$area)


# Exploring plotting
plot(World) # map for each attribute
# Warning message:
# plotting the first 9 out of 15 attributes; use max.plot = 15 to plot all
plot(World, max.plot = 15)
plot(World[1])  # plotting for the first attribute: iso_a3
plot(World[4])  # plotting for the 4th attribute: continent
plot(World[,1]) # plot the column: iso_a3
plot(World[,4]) # plot the column: continent

plot(World[1,]) # plot a line (1 country)
# Warning message:
# plotting the first 10 out of 15 attributes; use max.plot = 15 to plot all
plot(World[1,], max.plot = 15)
World[1,] # checking the country in question

plot(World["pop_est"])
plot(World["inequality"])

# A key difference between data frames and sf objects is the presence of
# geometry, that looks like a column when printing the summary of any sf object
World$geometry #geometry is an object in itself
head(sf::st_coordinates(World))
no_geom <- sf::st_drop_geometry(World)
class(no_geom)

#bounding boxes
st_bbox(World)

# Manipulating sf objects ------------------------------------------------------
names(World)
unique(World$continent)

World %>%       # logical_clause
  filter(continent == "South America") %>%
  tm_shape() +
  tm_borders()

World %>%       # logical_clause
  filter(continent == "South America" || continent == "Africa") %>%
  tm_shape() +
  tm_borders()

World %>%                     # (logical_clause, T, F)
  mutate(our_countries = if_else(iso_a3 %in% c("COL","BRA", "MEX", "ARG"), "red", "gray")) %>%
  tm_shape() +
  tm_borders() +
  tm_fill(col = "our_countries") +
  tm_add_legend("fill",
                "Countries",
                col = "red")


# Loading, plotting, and saving a shapefile from the disk -----------------------
#install.packages("rnaturalearth")
#install.packages("remotes")
#remotes::install_github("ropensci/rnaturalearthhires")
library(rnaturalearth)
library(rnaturalearthhires)
bra <- ne_states(country = "brazil", returnclass = "sf")
plot(bra)
# Warning message:
# plotting the first 10 out of 83 attributes; use max.plot = 83 to plot all
plot(bra, max.plot = 6)

dir.create("data/shapefiles", recursive = TRUE)
st_write(obj = bra,
         dsn = "data/shapefiles/bra.shp",
         delete_layer = TRUE)
# Check the files that are created: .shp, .shx, .dbf, .cpg, prj.

# To read again this shapefile, you would execute:
bra2 <- read_sf("data/shapefiles/bra.shp")
class(bra)
class(bra2)

plot(bra)
plot(bra2)


# Loading, plotting, and saving a raster from the disk -------------------------
library(raster)
dir.create(path = "data/raster/", recursive = TRUE)
tmax_data <- getData(name = "worldclim", var = "tmax", res = 10, path = "data/raster/")
plot(tmax_data)
