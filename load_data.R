# Initialize ####

# Load Packages
list.of.packages <- c("sf","sp","rgdal","maptools","rgeos","raster","ggmap","leaflet","ggmap", #mapping
                      "readr","readxl", #data import
                      "lubridate","tidyr","plyr","dplyr","data.table", "forcats", #data wrangling
                      "ggplot2","scales","grid","gridExtra", #data viz
                      "viridis","RColorBrewer","ochRe", #colour palette
                      "xts","forecast","zoo", #time series
                      "R.utils","wrapr","here","devtools" #utility
                      )

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) { install.packages(new.packages) }
invisible(sapply(list.of.packages, require, character.only = T))
rm(new.packages,list.of.packages)

# Data Import
list.files(here("data")) #files in /data folder

