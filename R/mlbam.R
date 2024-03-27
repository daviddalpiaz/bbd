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
  url = paste("https://statsapi.mlb.com/api/v1/teams/", team, "/roster/40Man", sep = "")

  # acquire JSON, extract roster, flatten, add nicer names
  # TODO: consider column types and NA or "" values
  data = jsonlite::fromJSON(url)$roster
  data = jsonlite::flatten(data)
  if (ncol(data) == 12) {
    # TODO: instead of removing, add to all rosters, even if no notes exist?
    # TODO: what could/should notes be used for?
    data$note = NULL
  }
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




# 108 LAA Angels
# 109 ARI D-backs
# 110 BAL Orioles
# 111 BOS Red Sox
# 112 CHC Cubs
# 113 CIN Reds
# 114 CLE Indians
# 115 COL Rockies
# 116 DET Tigers
# 117 HOU Astros
# 118 KC Royals
# 119 LAD Dodgers
# 120 WSH Nationals
# 121 NYM Mets
# 133 OAK Athletics
# 134 PIT Pirates
# 135 SD Padres
# 136 SEA Mariners
# 137 SF Giants
# 138 STL Cardinals
# 139 TB Rays
# 140 TEX Rangers
# 141 TOR Blue Jays
# 142 MIN Twins
# 143 PHI Phillies
# 144 ATL Braves
# 145 CWS White Sox
# 146 MIA Marlins
# 147 NYY Yankees
# 158 MIL Brewers


