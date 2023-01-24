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
#' @param process Controls processing of data. Defaults to `FALSE`. If `TRUE`,
#' data is processed using the `statcast_min_process` function.
#' @param names Controls processing of names. Defaults to `FALSE`. If `TRUE`,
#' names are processed using the `statcast_names` function.
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
                    process = FALSE,
                    names = FALSE,
                    tibble = TRUE,
                    verbose = FALSE) {

  # TODO: defend against invalid dates?

  # TODO: repeat this code less, but save speedup
  if (identical(start, end) || is.null(end)) {
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
      data = statcast_names(data = data, tibble = tibble)
    }
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

  if (process) {
    data = statcast_min_process(data = data, tibble = tibble)
  }

  if (process && names) {
    data = statcast_names(data = data, tibble = tibble)
  }

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
#' @param tibble Controls class of object returned. Defaults to `TRUE` which
#' returns a `tibble`. When `FALSE`, returns a `data.frame`.
#'
#' @return A `data.frame` or `tibble`.
#' @export
statcast_min_process = function(data, tibble = TRUE) {

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

  data = data[, -c(dupes, na_vars)]

  if (tibble) {
    data = tibble::as_tibble(data)
  }

  return(data)

}

#' Add names to Statcast data
#'
#' @param data A `data.frame` or `tibble`.
#' @param tibble Controls class of object returned. Defaults to `TRUE` which
#' returns a `tibble`. When `FALSE`, returns a `data.frame`.
#'
#' @return A `data.frame` or `tibble`.
#' @export
statcast_names = function(data, tibble = TRUE) {

  remove = c(
    "name",
    "key_person",
    "key_uuid",
    "key_retro",
    "key_bbref",
    "key_bbref_minors",
    "key_fangraphs",
    "key_npb"
  )

  names = bbd::people

  # add batter name
  data = merge(
    x = data,
    y = names,
    by.x = "batter",
    by.y = "key_mlbam",
    all.x = TRUE
  )
  data$batter_name = data$name
  data[, remove] = NULL

  # add pitcher name
  data = merge(
    x = data,
    y = names,
    by.x = "pitcher",
    by.y = "key_mlbam",
    all.x = TRUE
  )
  data$pitcher_name = data$name
  data[, remove] = NULL

  col_order = c(
    "pitcher",
    "pitcher_name",
    "batter",
    "batter_name",
    "pitch_type",
    "game_date",
    "release_speed",
    "release_pos_x",
    "release_pos_z",
    "player_name",
    "events",
    "description",
    "zone",
    "des",
    "game_type",
    "stand",
    "p_throws",
    "home_team",
    "away_team",
    "type",
    "hit_location",
    "bb_type",
    "balls",
    "strikes",
    "game_year",
    "pfx_x",
    "pfx_z",
    "plate_x",
    "plate_z",
    "on_3b",
    "on_2b",
    "on_1b",
    "outs_when_up",
    "inning",
    "inning_topbot",
    "hc_x",
    "hc_y",
    "sv_id",
    "vx0",
    "vy0",
    "vz0",
    "ax",
    "ay",
    "az",
    "sz_top",
    "sz_bot",
    "hit_distance_sc",
    "launch_speed",
    "launch_angle",
    "effective_speed",
    "release_spin_rate",
    "release_extension",
    "game_pk",
    "fielder_2",
    "fielder_3",
    "fielder_4",
    "fielder_5",
    "fielder_6",
    "fielder_7",
    "fielder_8",
    "fielder_9",
    "release_pos_y",
    "estimated_ba_using_speedangle",
    "estimated_woba_using_speedangle",
    "woba_value",
    "woba_denom",
    "babip_value",
    "iso_value",
    "launch_speed_angle",
    "at_bat_number",
    "pitch_number",
    "pitch_name",
    "home_score",
    "away_score",
    "bat_score",
    "fld_score",
    "post_away_score",
    "post_home_score",
    "post_bat_score",
    "post_fld_score",
    "if_fielding_alignment",
    "of_fielding_alignment",
    "spin_axis",
    "delta_home_win_exp",
    "delta_run_exp"
  )

  data = data[, col_order]

  if (tibble) {
    data = tibble::as_tibble(data)
  }

  return(data)

}

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
