#' Check for non-empty data frame
#'
#' @param x An R object.
#'
#' @return A logical vector
nonempty_df = function(x) {
  stopifnot(is.data.frame(x))
  return(nrow(x) != 0)
}

#' Check if each element of a vector is NA
#'
#' @param x A vector
#'
#' @return A logical vector
all_na = function(x) {
  return(all(is.na(x)))
}

#' Obtain vector of classes to create a tibble
#'
#' @return A character vector
make_tibble_class = function() {
  return(c("tbl_df", "tbl", "data.frame"))
}
