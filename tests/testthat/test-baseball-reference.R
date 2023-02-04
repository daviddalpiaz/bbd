test_that("bref war functions always return a data frame", {
  expect_true(is.data.frame(bref_war_daily_batter()))
  expect_true(is.data.frame(bref_war_daily_pitcher()))
})

test_that("bref war functions return a non-empty data frame", {
  expect_true(nonempty_df(bref_war_daily_batter()))
  expect_true(nonempty_df(bref_war_daily_pitcher()))
})

# TODO: test for column names
# TODO: test for column types
