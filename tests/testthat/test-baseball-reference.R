# setup -------------------------------------------------------------------

# get data for testing
try({
  bref_bat = bref_war_daily_batter()
  bref_pit = bref_war_daily_pitcher()
}, silent = TRUE)

# did we get the data?
got_data = all(
  exists("bref_bat"),
  exists("bref_pit")
)

# expected column names and types
bref_bat_names = c("name_common", "age", "mlb_ID", "player_ID", "year_ID",
  "team_ID", "stint_ID", "lg_ID", "PA", "G", "Inn", "runs_bat", "runs_br",
  "runs_dp", "runs_field", "runs_infield", "runs_outfield", "runs_catcher",
  "runs_good_plays", "runs_defense", "runs_position", "runs_position_p",
  "runs_replacement", "runs_above_rep", "runs_above_avg", "runs_above_avg_off",
  "runs_above_avg_def", "WAA", "WAA_off", "WAA_def", "WAR", "WAR_def",
  "WAR_off", "WAR_rep", "salary", "pitcher", "teamRpG", "oppRpG",
  "oppRpPA_rep", "oppRpG_rep", "pyth_exponent", "pyth_exponent_rep",
  "waa_win_perc", "waa_win_perc_off", "waa_win_perc_def", "waa_win_perc_rep",
  "OPS_plus", "TOB_lg", "TB_lg"
)
bref_bat_coltypes = c("character", "integer", "integer", "character", "integer",
  "character", "integer", "character", "integer", "integer", "double",
  "double", "double", "double", "double", "double", "double", "double",
  "double", "double", "double", "double", "double", "double", "double",
  "double", "double", "double", "double", "double", "double", "double",
  "double", "double", "integer", "character", "double", "double",
  "double", "double", "double", "double", "double", "double", "double",
  "double", "double", "double", "double"
)
bref_pit_names = c("name_common", "age", "mlb_ID", "player_ID", "year_ID",
  "team_ID","stint_ID", "lg_ID", "G", "GS", "IPouts", "IPouts_start",
  "IPouts_relief", "RA", "xRA", "xRA_sprp_adj", "xRA_extras_adj", "xRA_def_pitcher",
  "PPF", "PPF_custom", "xRA_final", "BIP", "BIP_perc", "RS_def_total",
  "runs_above_avg", "runs_above_avg_adj", "runs_above_rep", "RpO_replacement",
  "GR_leverage_index_avg", "WAR", "salary", "teamRpG", "oppRpG",
  "pyth_exponent", "waa_win_perc", "WAA", "WAA_adj", "oppRpG_rep",
  "pyth_exponent_rep", "waa_win_perc_rep", "WAR_rep", "ERA_plus", "ER_lg"
)
bref_pit_coltypes = c("character", "integer", "integer", "character", "integer",
  "character", "integer", "character", "integer", "integer", "integer",
  "integer", "integer", "integer", "double", "double", "double",
  "double", "integer", "double", "double", "integer", "double",
  "double", "double", "double", "double", "double", "double", "double",
  "integer", "double", "double", "double", "double", "double",
  "double", "double", "double", "double", "double", "double", "double"
)

# asserts -----------------------------------------------------------------

test_that("bref war functions always return a data frame", {
  skip_if_not(got_data)
  expect_true(is.data.frame(bref_bat))
  expect_true(is.data.frame(bref_pit))
})

test_that("bref war functions return a non-empty data frame", {
  skip_if_not(got_data)
  expect_true(nonempty_df(bref_bat))
  expect_true(nonempty_df(bref_pit))
})

test_that("bref war functions return data frame with correct names", {
  skip_if_not(got_data)
  expect_equal(names(bref_bat), bref_bat_names)
  expect_equal(names(bref_pit), bref_pit_names)
})

test_that("bref war functions return data frame with correct types", {
  skip_if_not(got_data)
  expect_equal(coltypes(bref_bat), bref_bat_coltypes)
  expect_equal(coltypes(bref_pit), bref_pit_coltypes)
})
