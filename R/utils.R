#' Check for non-empty data frame
#'
#' @param x An R object.
#'
#' @return A logical vector
#' @export
#'
#' @examples
#' nonempty_df(data.frame())
#' nonempty_df(data.frame(1))
nonempty_df = function(x) {
  stopifnot(is.data.frame(x))
  return(nrow(x) != 0)
}

#' Check if each element of a vector is NA
#'
#' @param x A vector
#'
#' @return A logical vector
#' @export
#'
#' @examples
#' all_na(c(1, NA, 3))
#' all_na(c(NA, NA, NA, NA))
all_na = function(x) {
  return(all(is.na(x)))
}
