test_that("statcast returns data", {
  skip_on_cran()
  skip_on_ci()
  expect_equal(is.data.frame(get_statcast_day()), TRUE)
})
