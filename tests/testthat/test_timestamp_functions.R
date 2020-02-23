context("Timestamp helpers")

test_that("last_timestamp throws errors", {
  expect_error(get_last_timestamp(c("Yes", "No")),
               regexp = "`scrobbles_df`` must be a dataframe")
})
