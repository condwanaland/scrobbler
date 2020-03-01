context("Timestamp helpers")

test_that("last_timestamp throws errors", {
  expect_error(get_last_timestamp(c("Yes", "No")),
               regexp = "`scrobbles_df`` must be a dataframe")
})


timestamp_data <- read.table(system.file("extdata",
                                         "timestamp_data.txt",
                                         package = "scrobbler"),
                             header = TRUE)
test_that("last timestamp is correctly returned", {
  expect_equal(get_last_timestamp(timestamp_data, "date_unix"), 1582531414)
})

rm(timestamp_data)
