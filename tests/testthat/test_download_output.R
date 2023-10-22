library(httptest)

with_mock_api(
  {
    test_that("Output is producted correctly", {
      expect_snapshot_value(
        download_scrobbles("condwanaland", "mocked", max_per_page = 3, max_pages = 3),
        style = "deparse")
    })
  }
)
