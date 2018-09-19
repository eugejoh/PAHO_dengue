
#' Wrapper for HTML datatable
#'
#' This is a wrapper function on the `datatable()` function found in the `DT` package.
#' It can be used to shorten syntax for HTML markdown files
#'
#' @param input a `data frame` object
#' @param ... other arguments that specified for `datatable()`
#'
#' @return a `datatable` html interactive output
#' @export
#'
#' @examples
#' 
#' mtcars %>% add_DT(caption = "the mtcars output")
#' 
add_DT <- function(input, ...) {
  DT::datatable(data = input, rownames = FALSE, extensions = 'Buttons', ...,
                options = list(
                  autoWidth = TRUE,
                  pageLength = 20,
                  lengthMenu = c(5, 10, 15, 20),
                  buttons = c("csv", "excel", "pdf")
                ))
}