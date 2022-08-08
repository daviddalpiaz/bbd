test_that("empty df retuns FALSE", {
  expect_equal(check_nonempty_df(data.frame()), FALSE)
})

test_that("non-empty df retuns TRUE", {
  expect_equal(check_nonempty_df(data.frame(1)), TRUE)
})

test_that("non-df triggers error", {
  expect_error(check_nonempty_df(1))
})
