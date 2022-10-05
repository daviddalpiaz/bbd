#' Download daily updated WAR data for batters from Baseball-Reference
#'
#' @param tibble Controls class of object returned. Defaults to `TRUE` which
#' returns a `tibble`. When `FALSE`, returns a `data.frame`.
#'
#' @return A `data.frame` or `tibble` containing batter WAR data.
#' @export
#'
#' @examples
#' \dontrun{
#' bref_war_daily_batter()
#' }
bref_war_daily_batter = function(tibble = TRUE) {
  url = "https://www.baseball-reference.com/data/war_daily_bat.txt"
  data = data.table::fread(
    url,
    showProgress = FALSE,
    data.table = FALSE,
    na.strings = c("", "NULL")
  )
  if (tibble) {
    data = tibble::as_tibble(data)
  }
  return(data)
}

#' Download daily updated WAR data for pitchers from Baseball-Reference
#'
#' @param tibble Controls class of object returned. Defaults to `TRUE` which
#' returns a `tibble`. When `FALSE`, returns a `data.frame`.
#'
#' @return A `data.frame` or `tibble` containing pitcher WAR data.
#' @export
#'
#' @examples
#' \dontrun{
#' bref_war_daily_pitcher()
#' }
bref_war_daily_pitcher = function(tibble = TRUE) {
  url = "https://www.baseball-reference.com/data/war_daily_pitch.txt"
  data = data.table::fread(
    url,
    showProgress = FALSE,
    data.table = FALSE,
    na.strings = c("", "NULL")
  )
  if (tibble) {
    data = tibble::as_tibble(data)
  }
  return(data)
}

# https://www.baseball-reference.com/about/war_explained.shtml
