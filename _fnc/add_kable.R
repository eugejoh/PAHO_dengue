add_kable <- function(input, ...) {
  input %>% kable(., digits = 2, ...) %>% 
    kable_styling(bootstrap_options = c("striped", "hover", "responsive"),
                  full_width = FALSE)
}