# don't run tests on ci
skip_on_ci()

# don't run tests on ci
skip_on_cran()

# skip all tests if cannot reach Baseball-Reference
skip_if_offline(host = "baseball-reference.com")

bref_bat = bref_war_daily_batter()
bref_pit = bref_war_daily_pitcher()

test_that("bref war functions always return a data frame", {
  expect_true(is.data.frame(bref_bat))
  expect_true(is.data.frame(bref_pit))
})

test_that("bref war functions return a non-empty data frame", {
  expect_true(nonempty_df(bref_bat))
  expect_true(nonempty_df(bref_pit))
})

# TODO: test for column names
# TODO: test for column types
