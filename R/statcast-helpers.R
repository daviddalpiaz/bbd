#' Minimally process Statcast data
#'
#' @param data A `data.frame`.
#'
#' @return A `data.frame`.
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

  data = data[, -c(dupes, na_vars)]

  class(data) = c("tbl_df", "tbl", "data.frame")

  return(data)

}

#' Add names to Statcast data
#'
#' @param data A `data.frame`.
#'
#' @return An object with class `c("tbl_df", "tbl", "data.frame")`
#' @export
statcast_names = function(data) {

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

  class(data) = c("tbl_df", "tbl", "data.frame")

  return(data)

}





#' Obtain vector of expected Statcast column types
#'
#' @return A character vector of the expected Statcast column types
#' @export
statcast_get_col_types = function() {
  c(
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
}
