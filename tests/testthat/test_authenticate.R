context("Testing authentication")

Sys.setenv(LASTFM_API_USERNAME = 'test_name')
Sys.setenv(LASTFM_API_KEY = 'test_key')

test_that("get_creds does not throw error", {
  expect_equal(get_lastfm_credentials(env = 'username'), 'test_name')
  expect_equal(get_lastfm_credentials(env = 'key'), 'test_key')
  expect_equal(check_env_vars(), TRUE)
})

Sys.unsetenv('LASTFM_API_USERNAME')
Sys.unsetenv('LASTFM_API_KEY')


test_that("env vars check throws error", {
  expect_error(check_env_vars(), "LASTFM_API_USERNAME' and/or 'LASTFM_API_KEY")
  expect_error(get_lastfm_credentials(env = "myenv"), "env must be one of")
})
