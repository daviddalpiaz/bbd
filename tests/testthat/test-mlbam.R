# setup -------------------------------------------------------------------

# get data for testing
try({
  mets_currest_roster = mlb_roster(team = 121)
}, silent = TRUE)

# did we get the data?
got_data = all(
  exists("mets_currest_roster")
)

# asserts -----------------------------------------------------------------

test_that("mlb_roster returns a data frame", {
  expect_true(is.data.frame(mets_currest_roster))
})

test_that("mlb_roster returns a data frame with 40 rows", {
  expect_equal(nrow(mets_currest_roster), 40)
})
