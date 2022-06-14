library(testthat)

test_that("list_datasets returns a list", {
  expect_equal(typeof(list_datasets()), "list")
})
