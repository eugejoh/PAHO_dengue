#########################################################################################
# Initialize ####
#########################################################################################
# Eugene Joh, MPH
# April 8th 2018


#########################################################################################
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

#########################################################################################
# Data Import ####
#########################################################################################
list.files(here('data'),pattern = "\\.csv$") #show all .csv files in /data folder
list.files(here('data'), pattern = 'INIT\\.csv$') #show all downloaded files in /data folder

# data import issues due to multibyte .csv encoding (UTF-16), the downloaded .csv were manually converted to singlebyte format
list.files(here('data'), pattern = 'FINAL\\.csv$') #show all modified files (due to multi-byte data import issues) in /data folder

# import 'FINAL' files into list ###
d.list <- lapply(seq_along(list.files(here('data'),pattern = 'FINAL\\.csv$')),
                    function(i) { #use readr read_csv()
                      readr::read_csv(here('data',list.files(here('data'),pattern = 'FINAL\\.csv$')[i]))
                    })
# add names to list import
names(d.list) <- list.files(here('data'), pattern = 'FINAL\\.csv$')

#########################################################################################
# merge the Epi Week data files (1-51 and 52) together
glimpse(d.list$`Epi_week_1-51_FINAL.csv`)
glimpse(d.list$Epi_week_52_FINAL.csv)
# check column names first
identical(names(d.list[[3]]),names(d.list[[4]])) #column names are the same

# merge the data together by usingbase::rbind()
d_epiwk <- rbind(d.list[[3]],d.list[[4]])

#########################################################################################
# assign names for mortality and case fatality
d_mort <- d.list[[1]] #mortality data
d_fat <- d.list[[2]] #case fatality data

rm(d.list)
