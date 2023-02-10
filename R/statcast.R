#' Download all Statcast data for a particular date
#'
#' @param date A date
#' @param batter Statcast player ID for batter of interest. Defaults to `NULL`.
#' @param pitcher Statcast player ID for pitcher of interest. Defaults to `NULL`.
#' @param verbose Controls messaging to the user. Defaults to `FALSE` which
#' provides no message. When `TRUE`, informs user when each `date` begins
#' downloading.
#'
#' @return A `data.frame` containing all Statcast events on `date`.
statcast_day = function(date = Sys.Date() - 1,
                        batter = NULL,
                        pitcher = NULL,
                        verbose = FALSE) {

  # TODO: defend against invalid dates?

  if (verbose) {
    message(paste0("Obtaining data for games on ", date, "."))
  }

  # setup variables for URL
  type = ""
  if (is.null(batter)) {
    batter = ""
    if (is.null(pitcher)) {
      pitcher = ""
      type = ""
    } else {
      type = "&player_type=pitcher"
      pitcher = paste0("&pitchers_lookup%5B%5D=", pitcher)
    }
  } else {
    batter = paste0("&batters_lookup%5B%5D=", batter)
    if (is.null(pitcher)) {
      type = "&player_type=batter"
    } else {
      pitcher = paste0("&pitchers_lookup%5B%5D=", pitcher)
    }
  }

  # create URL
  # TODO: does decreasing pasting improve speed?
  # TODO: consider row orders (currently matching baseballr)
  # TODO: possible to order rows by "time"
  url = paste0(
    "https://baseballsavant.mlb.com/statcast_search/csv?all=true",
    "&hfPT=",
    "&hfAB=",
    "&hfBBT=",
    "&hfPR=",
    "&hfZ=",
    "&stadium=",
    "&hfBBL=",
    "&hfNewZones=",
    "&hfGT=R%7CPO%7CS%7C&hfC",
    "hfSit=",
    "hfOuts=",
    "opponent=",
    "pitcher_throws=",
    "batter_stands=",
    "hfSA=",
    type,
    "&hfInfield=",
    "&team=",
    "&position=",
    "&hfOutfield=",
    "&hfRO=",
    "&home_road=",
    pitcher,
    batter,
    "&game_date_gt=", date,
    "&game_date_lt=", date,
    "&hfFlag=",
    "&hfPull=",
    "&metric_1=",
    "&hfInn=",
    "&min_pitches=0",
    "&min_results=0",
    "&group_by=name",
    "&sort_col=pitches",
    "&player_event_sort=h_launch_speed",
    "&sort_order=desc",
    "&min_abs=0",
    "&type=details"
  )

  # download data
  data = data.table::fread(
    url,
    showProgress = FALSE,
    data.table = FALSE,
    colClasses = statcast_get_col_types(),
    na.strings = ""
  )

  return(data)

}

#' Download all Statcast data within a range of dates
#'
#' @param start Start date of search.
#' @param end End data of search. Defaults to `NULL`, which stops search at`start` date.
#' @param batter Statcast player ID for batter of interest. Defaults to `NULL`.
#' @param pitcher Statcast player ID for pitcher of interest. Defaults to `NULL`.
#' @param process Controls processing of data. Defaults to `FALSE`. If `TRUE`,
#' data is processed using the `statcast_min_process` function.
#' @param names Controls processing of names. Defaults to `FALSE`. If `TRUE`,
#' names are processed using the `statcast_names` function.
#' @param verbose Controls messaging to the user. Defaults to `FALSE` which
#' provides no message. When `TRUE`, informs user when each `date` begins
#' downloading.
#'
#' @return An object with class `c("tbl_df", "tbl", "data.frame")` containing
#' all Statcast events between the `start` date and `end` date inclusive.
#' @export
statcast = function(start = Sys.Date() - 1,
                    end = NULL,
                    batter = NULL,
                    pitcher = NULL,
                    process = FALSE,
                    names = FALSE,
                    verbose = FALSE) {

  # TODO: defend against invalid dates?

  # TODO: repeat this code less, but save speedup
  if (is.null(end) || identical(start, end)) {
    data = statcast_day(
      date = start,
      batter = batter,
      pitcher = pitcher,
      verbose = verbose
    )
    if (process) {
      data = statcast_min_process(data = data)
    }
    if (process && names) {
      data = statcast_names(data = data)
    }
    class(data) = c("tbl_df", "tbl", "data.frame")
    return(data)
  }

  start = as.Date(start)
  end   = as.Date(end)

  dates = seq(from = start, to = end, by = "day")

  data = lapply(
    dates,
    statcast_day,
    batter = batter,
    pitcher = pitcher,
    verbose = verbose
  )
  data = data[vapply(data, nonempty_df, logical(1))]
  data = data.table::rbindlist(data)

  if (process) {
    data = statcast_min_process(data = data)
  }

  # TODO: why the AND here? is it necessary? if so, throw error, also see above
  if (process && names) {
    data = statcast_names(data = data)
  }

  class(data) = c("tbl_df", "tbl", "data.frame")

  return(data)

}

#' Download all Statcast data within a range of dates in the opinionated `bbd` style
#'
#' @param start Start date of search.
#' @param end End data of search. Defaults to `NULL`, which stops search at`start` date.
#' @param verbose Controls messaging to the user. Defaults to `FALSE` which
#' provides no message. When `TRUE`, informs user when each `date` begins
#' downloading.
#'
#' @return An object with class `c("tbl_df", "tbl", "data.frame")` containing
#' all Statcast events between the `start` date and `end` date inclusive.
#' @export
statcast_bbd = function(start = Sys.Date() - 1, end = NULL, verbose = FALSE) {
  statcast(
    start = start,
    end = end,
    batter = NULL,
    pitcher = NULL,
    process = TRUE,
    names = TRUE,
    verbose = verbose
  )
}
