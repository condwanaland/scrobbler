context("Test API response columns are renamed correctly")

unnamed_data <- read.table(system.file("extdata", "example_api_data_unnamed.txt", package = "scrobbler"), header = TRUE)

test_renamed_data <- rename_api_response(unnamed_data)

verified_renamed_data <- read.table(system.file("extdata", "example_api_data_renamed.txt", package = "scrobbler"), header = TRUE)

test_that("Rename API table is successful", {
  expect_equal(test_renamed_data, verified_renamed_data)
})
