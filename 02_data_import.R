# Data Import -----------------------------------------------------------------------

if (!require(here)) install.packages("here")
source(here::here("01_load_packages.R"))

list.files(here::here('data'),pattern = "\\.csv$") #show all .csv files in /data folder
list.files(here::here('data'), pattern = 'INIT\\.csv$') #show all downloaded files in /data folder

list.files(here::here('data'), pattern = 'FINAL\\.csv$') #show all modified files (due to multi-byte data import issues) in /data folder

import_files <- list.files(here::here('data'), pattern = 'FINAL\\.csv$')

# import 'FINAL' files into list ----------------------------------------------------
dlist <- lapply(seq_along(import_files), function(i) {
      readr::read_csv(here::here('data', import_files[i]))
      })

# merge common data -----------------------------------------------------------------
# merge the Epi Week data files (1-51 and 52) together

if (identical(names(dlist[[3]]),names(dlist[[4]]))) {
  d_epiwk <- rbind(dlist[[3]],dlist[[4]]) }


# update list -----------------------------------------------------------------------
dlist <- list(dlist[[1]], dlist[[2]], d_epiwk)

names(dlist) <- c("d_fat", "d_mort", "d_epiwk") #rename data frames (mortality, fatality, epi week)
