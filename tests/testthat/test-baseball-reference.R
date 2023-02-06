# setup -------------------------------------------------------------------

# get data for testing
try({
  bref_bat = bref_war_daily_batter()
  bref_pit = bref_war_daily_pitcher()
}, silent = TRUE)

# did we get the data?
got_data = exists("bref_bat") && exists("bref_pit")

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

# TODOs -------------------------------------------------------------------

# TODO: test for column names
# TODO: test for column types
