context("Check file creation works")

install_export_script(version = 3)
test_that("Script is copied successfully v3", {
  expect_equal(check_py_script("3"),
               "Python 3 exporter exists")
})

install_export_script(version = 2)
test_that("Script is copied successfulyl v2", {
  expect_equal(check_py_script("2"),
               "Python 2 exporter exists")
})

file.remove("lastexport.py")
file.remove("lastexport2.py")
