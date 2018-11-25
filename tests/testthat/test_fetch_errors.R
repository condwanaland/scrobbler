context("Fetch_tracks error handling")

test_that("All arguments are treated as characters", {
  expect_error(fetch_tracks("one", "two", 12),
               regexp = "Arguments must be supplied as characters", fixed = TRUE)
  expect_error(fetch_tracks(13, "two", 12),
               regexp = "Arguments must be*")
  expect_error(fetch_tracks(13, 15, 12),
               regexp = "Arguments must be*")
  expect_error(fetch_tracks("one", 15, 12),
               regexp = "Arguments must be*")
})
