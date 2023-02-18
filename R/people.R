#' Create full Chadwick people table
#'
#' @return A table with class [table_class()] that contains all people data from
#' [`chadwickbureau/register`](https://github.com/chadwickbureau/register).
#' @export
people_chadwick = function() {

  # create URLs for relevant files in chadwickbureau/register
  chadwick_urls = paste0(
    "https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-",
    c(0:9, letters[1:6]),
    ".csv"
  )

  # download individual people datasets from chadwickbureau/register
  data = lapply(
    chadwick_urls,
    data.table::fread,
    data.table = FALSE,
    verbose = FALSE,
    showProgress = FALSE
  )

  # combine people datasets
  data = as.data.frame(data.table::rbindlist(data))

  # add table classes
  class(data) = c("tbl_df", "tbl", "data.table", "data.frame")

  # return data
  return(data)

}

#' Fuzzy lookup within [people] table
#'
#' @param x `[character]` A character string to be searched within the names in
#' the [people] table
#'
#' @return The [people] table subset to rows that fuzzy match `x`
#' @export
#'
#' @examples
#' people_search("Frank Thomas")
#' people_search("ichiro")
people_search = function(x) {
  idx = agrep(pattern = x, x = bbd::people$name, ignore.case = TRUE)
  bbd::people[idx, ]
}
