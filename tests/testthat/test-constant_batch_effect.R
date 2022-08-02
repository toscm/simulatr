test_that("function works", {
  observed1 <- constant_batch_effect(
    n = 10,
    p = 10,
    bias_func_args = list(b = 2, f = 2, s = 1)
  )
  observed2 <- constant_batch_effect(
    n = 10,
    p = 10,
    bias_func_args = list(b = 2, f = 4, s = c(0, 1))
  )
  observed3 <- constant_batch_effect(
    n = 10,
    p = 10,
    bias_func_args = list(
      b = c(1, 1, 1, 2, 2, 2, 3, 3, 4, 4),
      f = 4,
      s = c(0, 1, 2)
    )
  )

  expected <- matrix(0, 10, 10)
  testthat::expect_equal(dim(observed1), dim(expected))
  testthat::expect_equal(dim(observed2), dim(expected))
  testthat::expect_equal(dim(observed3), dim(expected))

})