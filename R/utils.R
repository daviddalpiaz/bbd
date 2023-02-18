#' Check for non-empty data frame
#'
#' @param x An R object.
#'
#' @return A logical vector
nonempty_df = function(x) {
  stopifnot(is.data.frame(x))
  nrow(x) != 0
}

#' Check if each element of a vector is NA
#'
#' @param x A vector
#'
#' @return A logical vector
all_na = function(x) {
  all(is.na(x))
}

#' Check if two columns of a data frame are identical
#'
#' @param df A data frame
#' @param col_1 The index or name of a column
#' @param col_2 The index or name of a column
#'
#' @return A logical vector
two_cols_identical = function(df, col_1 = 1, col_2 = 2) {
  stopifnot(is.data.frame(df))
  identical(df[[col_1]], df[[col_2]])
}

#' Get the type of each column of a data frame
#'
#' @param df A data frame
#'
#' @return A character vector
coltypes = function(df) {
  stopifnot(is.data.frame(df))
  unname(vapply(df, typeof, character(1)))
}

#' Return vector of table classes
#'
#' @return The vector `c("tbl_df", "tbl", "data.frame")`
table_class = function() {
  c("tbl_df", "tbl", "data.table", "data.frame")
}

#' Format character input as a Date
#'
#' @param x `[character]` A string of the form `"YYYY-MM-DD"`
#'
#' @return A object with class `"Date"`
make_date = function(x) {
  x = as.character(x)
  as.Date(x, format = "%Y-%m-%d")
}
