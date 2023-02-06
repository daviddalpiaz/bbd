# don't run tests on ci
skip_on_ci()

# don't run tests on ci
skip_on_cran()

# skip all tests if cannot reach Statcast search
skip_if_offline(host = "baseballsavant.mlb.com")

sc_col_names = c(
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

sc_col_types = c(
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

sc_na_vars = sort(c(11L, 12L, 13L, 14L, 40L, 41L, 43L))
sc_dupes = sort(c(60L, 42L))
sc_removed_vars = sort(c(sc_na_vars, sc_dupes))

sc_pitcher_dupes = c(8L, 60L)
sc_field_2_dupes = c(42L, 61L)

# helper function to check if the two columns of a two column data frame are identical
two_cols_identical = function(df) {
  all(df[, 1] == df[, 2])
}

# helper function to get column types of a data frame
# TODO: should this be in utils?
# TODO: is there a base R solution to this that I'm not aware of?
coltypes = function(x) {
  stopifnot(is.data.frame(x))
  return(unname(vapply(x, typeof, character(1))))
}

# get data for testing
sc_new_restday = statcast_day(date = "2022-01-01")
sc_new_gameday = statcast_day(date = "2022-04-07")
sc_old_restday = statcast_day(date = "2022-01-01")
sc_old_gameday = statcast_day(date = "2022-04-07")

test_that("statcast always returns a data frame", {
  expect_true(is.data.frame(sc_new_restday)) # date with no games
  expect_true(is.data.frame(sc_new_gameday)) # opening day 2022
})

test_that("statcast returns empty data frame on date with no games", {
  expect_true(is.data.frame(sc_new_restday))
  expect_true(!nonempty_df(sc_new_restday))
})

test_that("statcast returns non-empty data frame on date with games", {
  expect_true(is.data.frame(sc_new_gameday))
  expect_true(nonempty_df(sc_new_gameday))
})

test_that("statcast returns data with correct column names", {
  expect_identical(object = colnames(sc_new_restday), expected = sc_col_names)
  expect_identical(object = colnames(sc_new_gameday), expected = sc_col_names)
  expect_identical(object = colnames(sc_old_restday), expected = sc_col_names)
  expect_identical(object = colnames(sc_old_gameday), expected = sc_col_names)
})

test_that("statcast returns data with correct column types", {
  expect_identical(object = coltypes(sc_new_restday), expected = sc_col_types)
  expect_identical(object = coltypes(sc_new_gameday), expected = sc_col_types)
  expect_identical(object = coltypes(sc_old_restday), expected = sc_col_types)
  expect_identical(object = coltypes(sc_old_gameday), expected = sc_col_types)
})

test_that("statcast columns that may be removed are all NA", {
  expect_true(all_na(sc_new_restday[, sc_na_vars]))
  expect_true(all_na(sc_new_gameday[, sc_na_vars]))
  expect_true(all_na(sc_old_restday[, sc_na_vars]))
  expect_true(all_na(sc_old_gameday[, sc_na_vars]))
})

test_that("second statcast pitcher column is a duplicate that may be removed", {
  expect_true(two_cols_identical(sc_new_restday[, sc_pitcher_dupes]))
  expect_true(two_cols_identical(sc_new_gameday[, sc_pitcher_dupes]))
  expect_true(two_cols_identical(sc_old_restday[, sc_pitcher_dupes]))
  expect_true(two_cols_identical(sc_old_gameday[, sc_pitcher_dupes]))
})

test_that("second statcast fielder_2 column is a duplicate that may be removed", {
  expect_true(two_cols_identical(sc_new_restday[, sc_field_2_dupes]))
  expect_true(two_cols_identical(sc_new_gameday[, sc_field_2_dupes]))
  expect_true(two_cols_identical(sc_old_restday[, sc_field_2_dupes]))
  expect_true(two_cols_identical(sc_old_gameday[, sc_field_2_dupes]))
})

test_that("verbose arguement produces a message", {
  expect_message(statcast_day(verbose = TRUE))
  expect_message(statcast(verbose = TRUE))
})

# TODO: verify spring training games are returned
# TODO: verify postseason game are returned
# TODO: verify other game types (exhibition?) are returned
# TODO: verify correct returns with varying combinations NULL values in statcast() args
