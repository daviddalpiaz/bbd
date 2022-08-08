#' Check for non-empty data frame
#'
#' @param x An R object.
#'
#' @return A logical vector
#' @export
#'
#' @examples
#' check_nonempty_df(data.frame())
#' check_nonempty_df(data.frame(1))
check_nonempty_df = function(x) {
  stopifnot(is.data.frame(x))
  return(nrow(x) != 0)
}




