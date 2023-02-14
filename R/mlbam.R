#' Get MLB active rosters
#'
#' @param team A numeric MLB statsapi team ID.
#'
#' @return A data frame contain a team's active roster
#' @export
mlb_roster = function(team) {

  # create MLB statsapi URL
  # TODO: make lookup table or function
  url = paste("https://statsapi.mlb.com/api/v1/teams/", team, "/roster/", sep = "")

  # aquire JSON and extract roster
  # TODO: modify variable existence and names?
  out = jsonlite::fromJSON(url)$roster

  # attach tibble and data frames classes
  class(out) = c("tbl_df", "tbl", "data.frame")

  # return roster
  return(out)

}
