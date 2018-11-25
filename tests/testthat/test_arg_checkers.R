context("Test the low level arg checkers work")

# Most of these tests are repeated in 'test_fetch_errors'. These tests are designed to make
# sure the low level functions work as expected. The other file makes sure arguments are
# correctly parsed from fetch_tracks to the argument checkers

test_that("Non characters throw error", {
  expect_error(check_args_are_chr("one", "two", 12),
               regexp = "Arguments must be supplied as characters", fixed = TRUE)
  expect_error(check_args_are_chr(13, "two", 12),
               regexp = "Arguments must be*")
  expect_error(check_args_are_chr(13, 15, 12),
               regexp = "Arguments must be*")
  expect_error(check_args_are_chr("one", 15, 12),
               regexp = "Arguments must be*")
})

test_that("Characters do not throw errors", {
  expect_error(check_args_are_chr("one", "two", "three"), NA)
})


test_that("Missing start page does not throw error", {
  expect_error(check_args_are_chr("one", "two"), NA)
})
