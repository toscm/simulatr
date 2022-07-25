test_that("list_datasets returns a list", {
  expect_equal(typeof(list_datasets("GPL95")), "list")
})
test_that("class of list_datasets is dataframe", {
  expect_equal(class(list_datasets("GPL95")), "data.frame")
})
