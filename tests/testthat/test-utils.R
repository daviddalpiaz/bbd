test_that("empty df retuns FALSE", {
  expect_false(nonempty_df(data.frame()))
})

test_that("non-empty df retuns TRUE", {
  expect_true(nonempty_df(data.frame(1)))
})

test_that("non-df triggers error", {
  expect_error(nonempty_df(1))
})

test_that("vector with some non-NA values returns FALSE", {
  expect_false(all_na(c(6, NA)))
})

test_that("vector with some only NA values returns TRUE", {
  expect_true(all_na(c(NA, NA, NA)))
})
