test_that("Returns matrix and array class", {
  expect_equal(class(get_gpl_data("GPL96")), c("matrix", "array"))
})
