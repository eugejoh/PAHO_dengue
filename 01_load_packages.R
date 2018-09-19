# Load Libraries --------------------------------------------------------------------


install_packs <- function(pkg) {
  new_pkg <- pkg[!(pkg %in% installed.packages()[,"Package"])]
  if (length(new_pkg)) {
    install.packages(new_pkg, dependencies = TRUE)
  }
  sapply(pkg, require, character.only = TRUE)
}

foundation.packages <- c("haven","readr","here", #import
                         "dplyr","tidyr","purrr","data.table","janitor","magrittr", #process
                         "beepr","pryr","microbenchmark", #misc
                         "ggplot2","scales","forcats","ggfortify", #data viz
                         "grid","gridExtra")

spatial.packages <- c("rgdal","rgeos", #spatial data import
                      "sp","sf","raster","spatial.tools", #spatial data processing
                      "maps","maptools","ggmap","ggrepel") #spatial viz and other

db.packages <- c("dplyr","DBI","odbc","DBI","RPostgreSQL","dbplyr") #database connection

html.packages <- c("knitr","kableExtra","plotly","htmlwidgets","dygraphs","leaflet") #html interactive

spatial.PB.packages <- c("INLA","geostatsp","diseasemapping","spdep")

all.packages <- c("haven","readr","here","pryr","microbenchmark", #import
                  "rgdal","rgeos", #spatial data import
                  "sp","sf","raster","spatial.tools", #spatial data processing
                  "maps","maptools","ggmap","ggrepel", #spatial viz and other
                  "dplyr","tidyr","purrr","data.table","janitor","magrittr", #cleaning/processing
                  "beepr","corrplot","devtools","R.utils","utils", #misc
                  "lubridate","xts","forecast","zoo", #time series
                  "ggplot2","scales","forcats","ggfortify","ggrepel","ggridges","grid","gridExtra", #data viz
                  "ochRe","RColorBrewer","viridis", #palettes
                  "knitr","kableExtra","plotly","htmlwidgets","dygraphs","leaflet","DT") #html interactive

install_packs(all.packages)
rm(foundation.packages,spatial.packages,db.packages,html.packages,spatial.PB.packages)

# # Update Packages -------------------------------------------------------------------
# libLoc <- .libPaths()[1]
# update.packages(lib.loc = libLoc, instlib = libLoc, checkBuilt = TRUE, ask = FALSE)

