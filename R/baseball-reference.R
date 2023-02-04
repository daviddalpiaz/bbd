#' Download daily updated WAR data for batters from Baseball-Reference
#'
#' @return An object with class `c("tbl_df", "tbl", "data.frame")` containing
#' batter WAR data.
#' @export
#'
#' @examples
#' \dontrun{
#' bref_war_daily_batter()
#' }
bref_war_daily_batter = function() {
  url = "https://www.baseball-reference.com/data/war_daily_bat.txt"
  data = data.table::fread(
    url,
    showProgress = FALSE,
    data.table = FALSE,
    na.strings = c("", "NULL")
  )
  class(data) = c("tbl_df", "tbl", "data.frame")
  return(data)
}

#' Download daily updated WAR data for pitchers from Baseball-Reference
#'
#' @return An object with class `c("tbl_df", "tbl", "data.frame")` containing
#' pitcher WAR data.
#' @export
#'
#' @examples
#' \dontrun{
#' bref_war_daily_pitcher()
#' }
bref_war_daily_pitcher = function() {
  url = "https://www.baseball-reference.com/data/war_daily_pitch.txt"
  data = data.table::fread(
    url,
    showProgress = FALSE,
    data.table = FALSE,
    na.strings = c("", "NULL")
  )
  class(data) = c("tbl_df", "tbl", "data.frame")
  return(data)
}

# https://www.baseball-reference.com/about/war_explained.shtml
