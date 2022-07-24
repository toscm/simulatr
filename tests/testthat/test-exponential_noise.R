test_that("Returns result of a given dimension", {
  expect_equal(dim(exponential_noise(10, 10, list(rate = 1))), dim(c(10, 10)))
})
