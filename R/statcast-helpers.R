#' Minimally process Statcast data
#'
#' @param data A `data.frame` with columns that match the return of `statcast_get_col_types()`.
#'
#' @return A `data.frame` containing minimally processed Statcast data
#' @export
statcast_min_process = function(data) {

  # verify that supplied data has expected columns
  if (!identical(names(data), statcast_get_colnames())) {
    stop("Supplied data does not have expected columns.")
  }

  # find duplicated columns (statcast returns duplicated column names)
  # choose which to remove based on where they appear in the data
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

  # find column numbers for na_vars
  na_vars = which(names(data) %in% na_var_names)

  # removes dupes and na_vars
  data = data[, -c(dupes, na_vars)]

  # return data
  return(data)

}

#' Add names to Statcast data
#'
#' @param data A `data.frame`.
#'
#' @return An object with class `c("tbl_df", "tbl", "data.frame")`
#' @export
statcast_add_names = function(data) {

  # TODO: is this still needed?
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
  # TODO: switch to data.table::merge if there is a speedup
  data = merge(
    x = data,
    y = names,
    by.x = "batter",
    by.y = "key_mlbam",
    all.x = TRUE
  )
  data$batter_name = data$name
  # TODO: is this still needed?
  data[, remove] = NULL

  # add pitcher name
  # TODO: switch to data.table::merge if there is a speedup
  data = merge(
    x = data,
    y = names,
    by.x = "pitcher",
    by.y = "key_mlbam",
    all.x = TRUE
  )
  data$pitcher_name = data$name
  # TODO: is this still needed?
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

  return(data)

}

#' Make Statcast URL
#'
#' @param date Game date
#' @param batter Statcast player ID for batter of interest. Defaults to `NULL`.
#' @param pitcher Statcast player ID for pitcher of interest. Defaults to `NULL`.
#'
#' @return A length one chracter vector contain a Statcast URL
statcast_make_url = function(date, batter, pitcher) {

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
  # TODO: consider row orders (see notes below)
  # TODO: possible to order rows by "time" (probably not possible, create helper function?)
  url = paste0(
    "https://baseballsavant.mlb.com/statcast_search/csv?all=true",
    "&hfPT=",
    "&hfAB=",
    "&hfBBT=",
    "&hfPR=",
    "&hfZ=",
    "&stadium=", # TODO: can this be used to acquire milb data?
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
    "&group_by=name", # TODO: change this? (statcast search gives some hints)
    "&sort_col=pitches", # TODO: change this?
    "&player_event_sort=h_launch_speed", # TODO: change this?
    "&sort_order=desc", # TODO: change this?
    "&min_abs=0",
    "&type=details"
  )

  return(url)

}

#' Obtain vector of expected Statcast column classes
#'
#' @return A character vector of the expected Statcast column classes
statcast_get_colclasses = function() {
  c(
    "character",
    "Date",
    "numeric",
    "numeric",
    "numeric",
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
    "numeric",
    "numeric",
    "numeric",
    "numeric",
    "integer",
    "integer",
    "integer",
    "integer",
    "integer",
    "character",
    "numeric",
    "numeric",
    "logical",
    "logical",
    "integer",
    "logical",
    "character",
    "numeric",
    "numeric",
    "numeric",
    "numeric",
    "numeric",
    "numeric",
    "numeric",
    "numeric",
    "integer",
    "numeric",
    "integer",
    "numeric",
    "integer",
    "numeric",
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
    "numeric",
    "numeric",
    "numeric",
    "numeric",
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
    "numeric",
    "numeric"
  )
}

#' Obtain vector of expected Statcast column names
#'
#' @return A character vector of the expected Statcast column names
statcast_get_colnames = function() {
  c(
    "pitch_type",
    "game_date",
    "release_speed",
    "release_pos_x",
    "release_pos_z",
    "player_name",
    "batter",
    "pitcher",
    "events",
    "description",
    "spin_dir",
    "spin_rate_deprecated",
    "break_angle_deprecated",
    "break_length_deprecated",
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
    "tfs_deprecated",
    "tfs_zulu_deprecated",
    "fielder_2",
    "umpire",
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
    "pitcher",
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
}
