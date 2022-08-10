# TODO: move to a "data" file? what is "fastest" method to do so?
.sc_col_types = c(
  "character",
  "integer",
  "double",
  "double",
  "double",
  "character",
  "integer",
  "integer",
  "character",
  "character",
  "logical",
  "logical",
  "logical",
  "logical",
  "integer",
  "character",
  "character",
  "character",
  "character",
  "character",
  "character",
  "character",
  "integer",
  "character",
  "integer",
  "integer",
  "integer",
  "double",
  "double",
  "double",
  "double",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "character",
  "double",
  "double",
  "logical",
  "logical",
  "integer",
  "logical",
  "character",
  "double",
  "double",
  "double",
  "double",
  "double",
  "double",
  "double",
  "double",
  "integer",
  "double",
  "integer",
  "double",
  "integer",
  "double",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "double",
  "double",
  "double",
  "double",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "character",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "integer",
  "character",
  "character",
  "integer",
  "double",
  "double"
)

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
  if (is.null(batter)){
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
    colClasses = .sc_col_types,
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
#' @param tibble Controls class of object returned. Defaults to `TRUE` which
#' returns a `tibble`. When `FALSE`, returns a `data.frame`.
#' @param verbose Controls messaging to the user. Defaults to `FALSE` which
#' provides no message. When `TRUE`, informs user when each `date` begins
#' downloading.
#'
#' @return A `data.frame` or `tibble` containing all Statcast events between the
#'  `start` date and `end` date inclusive.
#' @export
statcast = function(start = Sys.Date() - 1,
                    end = NULL,
                    batter = NULL,
                    pitcher = NULL,
                    tibble = TRUE,
                    verbose = FALSE) {

  # TODO: defend against invalid dates?

  if (identical(start, end) || is.null(end)) {
    data = statcast_day(
      date = start,
      batter = batter,
      pitcher = pitcher,
      verbose = verbose
    )
    if (tibble) {
      return(tibble::as_tibble(data, .name_repair = "minimal"))
    } else {
      return(data)
    }
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

  # TODO: make tibble only a suggests?
  # TODO: create package options for tibble vs df vs dt?
  # TODO: don't import tibble but add class tbl_df and tbl?
  if (tibble) {
    data = tibble::as_tibble(data, .name_repair = "minimal")
  }

  return(data)

}

#' Minimally process Statcast data
#'
#' @param data A `data.frame` or `tibble`.
#'
#' @return A `data.frame` or `tibble`.
#' @export
statcast_min_process = function(data) {

  # TODO: verify supplied data has all necessary columns

  # find duplicated columns (statcast returns duplicated column names)
  dupes = c(
    which(names(data) == "pitcher")[2],
    which(names(data) == "fielder_2")[1]
  )

  # variables that are "known" to contain only NA
  na_var_names = c(
    "spin_dir",
    "spin_rate_deprecated",
    "break_angle_deprecated",
    "break_length_deprecated",
    "tfs_deprecated",
    "tfs_zulu_deprecated",
    "umpire"
  )
  na_vars = which(names(data) %in% na_var_names)

  return(data[, -c(dupes, na_vars)])

}
