#' Get MLB active rosters
#'
#' @param team `[numeric]` MLB [`statsapi`](https://statsapi.mlb.com/) team ID
#'
#' @return An object with class `c("tbl_df", "tbl", "data.frame")`. Specifically,
#' a data frame with `40` rows and `11` columns:
#' \describe{
#'   \item{`JerseyNumber`}{`[character]` desc}
#'   \item{`TeamID`}{`[integer]` desc}
#'   \item{`PersonID`}{`[integer]` desc}
#'   \item{`FullName`}{`[character]` desc}
#'   \item{`PersonLink`}{`[character]` desc}
#'   \item{`PositionCode`}{`[character]` desc}
#'   \item{`PositionName`}{`[character]` desc}
#'   \item{`PositionType`}{`[character]` desc}
#'   \item{`PositionAbbreviation`}{`[character]` desc}
#'   \item{`StatusCode`}{`[character]` desc}
#'   \item{`StatusDescription`}{`[character]` desc}
#' }
#' @export
mlb_roster = function(team) {

  # create MLB statsapi URL
  # TODO: make lookup table or function
  url = paste("https://statsapi.mlb.com/api/v1/teams/", team, "/roster/", sep = "")

  # acquire JSON, extract roster, flatten, add nicer names
  # TODO: consider column types and NA or "" values
  data = jsonlite::fromJSON(url)$roster
  data = jsonlite::flatten(data)
  names(data) = c(
    "JerseyNumber",
    "TeamID",
    "PersonID",
    "FullName",
    "PersonLink",
    "PositionCode",
    "PositionName",
    "PositionType",
    "PositionAbbreviation",
    "StatusCode",
    "StatusDescription"
  )

  # set class for table object
  class(data) = table_class()

  # return roster
  return(data)

}
