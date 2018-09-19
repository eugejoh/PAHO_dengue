# Exploratory Data Analysis ---------------------------------------------------------

if (!require(here)) install.packages("here")

if (!exists("install_packs")) source(here::here("01_load_packages.R"))

if (!exists("list_names")) source(here::here("02_data_import.R"))


# Data Types ------------------------------------------------------------------------

check_data_types <- function(list_names, input) {
  
  map_df(input[[list_names]], typeof) %>% 
    gather(key = "Variable", value = "Data_Type") %>% 
    left_join(
      map_df(input[[list_names]], 
             ~sum(is.na(.))) %>% gather(key = "Variable", value = "N_Missing"),
              by = "Variable") %>% 
    left_join(
      map_df(input[[list_names]],
             ~length(unique(.))) %>% gather(key = "Variable", value = "N_Unique"),
              by = "Variable") %>% 
    mutate(
      N_row = nrow(input[[list_names]]),
      Data_File = list_names,
      Variable = fct_inorder(Variable)
    )
  }

map_dfr(names(dlist), check_data_types, dlist) %>% 
  ggplot(aes(x = Variable, y = N_Missing, fill = Data_Type, colour = Data_Type)) +
  geom_bar(stat='identity') +
  coord_flip() +
  facet_wrap(~Data_File, scales = "free")

