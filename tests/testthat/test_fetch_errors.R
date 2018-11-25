context("Fetch_tracks error handling")

test_that("All arguments are treated as characters", {
  expect_error(fetch_tracks("one", "two", 12),
               regexp = "Arguments must be*")
})
