test_that("function works", {
  observed <- constant_batch_effect(n = 10, p = 10, const_func_args = list(
    n = 2, p = 2, s = 1)
  )
  expected <- matrix(0, 10, 10)
  expected[1:5, 2] <- 1
  testthat::expect_equal(dim(observed), dim(expected))
  testthat::expect_equal(sum(observed), sum(expected))

  # constant_batch_effect(n = 10, p = 10, const_func_args = list(b = 2, p = 2, s = c(0, 1)))
  # constant_batch_effect(n = 10, p = 10, const_func_args = list(b = 2, p = 4, s = c(0, 1, 1, 2)))
  # constant_batch_effect(n = 10, p = 10, const_func_args = list(
  #   n = c(1, 1, 1, 2, 2, 2, 3, 3, 4, 4), p = 4, s = c(0, 1, 1, 2)
  # ))
  # expect_equal(2 * 2, 4)
})
