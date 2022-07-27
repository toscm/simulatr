test_that("Returns matrix and array class", {
  expect_equal(class(get_dataset("GSE3821")), c("matrix", "array"))
})
