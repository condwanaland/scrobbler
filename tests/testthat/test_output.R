library(httptest)

with_mock_api(
  {
    test_that("Output is producted correctly", {
      expect_snapshot_value(
        download_scrobbles("condwanaland", "mocked", .limit1 = TRUE),
        style = "deparse")
    })
  }
)
