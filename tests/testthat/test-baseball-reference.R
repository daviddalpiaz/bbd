test_that("bref war functions always return a data frame", {
  expect_true(is.data.frame(bref_war_daily_batter()))
  expect_true(is.data.frame(bref_war_daily_pitcher()))
  expect_true(is.data.frame(bref_war_daily_batter(tibble = FALSE)))
  expect_true(is.data.frame(bref_war_daily_pitcher(tibble = FALSE)))
})

test_that("bref war functions return a non-empty data frame", {
  expect_true(nonempty_df(bref_war_daily_batter()))
  expect_true(nonempty_df(bref_war_daily_pitcher()))
})

test_that("bref war functions do not return a tibble when tibble = FALSE", {
  expect_false(tibble::is_tibble(bref_war_daily_batter(tibble = FALSE)))
  expect_false(tibble::is_tibble(bref_war_daily_pitcher(tibble = FALSE)))
})

test_that("bref war functions return a tibble when tibble = TRUE", {
  expect_true(tibble::is_tibble(bref_war_daily_batter(tibble = TRUE)))
  expect_true(tibble::is_tibble(bref_war_daily_pitcher(tibble = TRUE)))
})

test_that("bref war functions return a tibble by deafult", {
  expect_true(tibble::is_tibble(bref_war_daily_batter()))
  expect_true(tibble::is_tibble(bref_war_daily_pitcher()))
})

# TODO: test for column names
# TODO: test for column types
