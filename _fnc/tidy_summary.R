#' Tidy Summary Statistics
#' 
#' This function outputs a tidy data frame of summary statistics, utilizing the base summary functions
#' `mean`, `median`, `min`, `max`, `quantile`, `sd`. This function selects only columns that `is.numeric = TRUE`.
#' This function ignores missing values `na.rm = TRUE`.
#'
#' @param input a `data.frame` object
#'
#' @return a `data.frame` object with input variables as the first column and respective summary statistics are columns
#' @export
#'
#' @examples
#' 
#' data(airquality)
#' tidy_summary(airquality)
#' 
tidy_summary <- function(input) {
  input %>% select_if(is.numeric) %>% 
    summarise_all(funs(
      min = min(., na.rm = TRUE),
      q25 = quantile(., 0.25, na.rm = TRUE),
      mean = mean(., na.rm = TRUE),
      median = median(., na.rm = TRUE),
      q75 = quantile(., 0.75, na.rm = TRUE),
      max = max(., na.rm = TRUE),
      sd = sd(., na.rm = TRUE),
      missing = sum(is.na(.))
    )) %>% 
    gather(stat, val) %>% 
    separate(stat, into = c("var", "stat"), sep = "_") %>% 
    spread(stat, val) %>% 
    select(variable = var, min, q25, mean, median, q75, max, sd, missing)
}
