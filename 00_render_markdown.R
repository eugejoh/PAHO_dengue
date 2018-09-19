# Script for Rendering Markdown Files -------------------------------------

if (!require(here)) install.packages("here")

source(here::here('01_load_packages.R'))

source(here::here('02_data_import.R'))



# Loop Data Frames in List ------------------------------------------------

for (i in seq_along(dlist)[1]) {
  rmarkdown::render(
    input = here::here("_markdown","01_explore_paho.Rmd"),
    output_format = NULL, 
    output_file = here::here("_reports", paste0(names(dlist)[i],".html")),
    output_dir = here::here("_reports"),
    clean = TRUE, 
    quiet = FALSE,
    params = list(
      i_seq = i,
      i_names = names(dlist)[i],
      i_data = dlist[[i]]
    ))
}


for (i in seq_along(dlist)) {
  print(i)
  print(names(dlist)[i])
  print(dlist[[i]])
}
