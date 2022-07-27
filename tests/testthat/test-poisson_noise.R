test_that("Returns result of a given dimension", {
  expect_equal(dim(poisson_noise(10, 10, list(lambda = 1))), dim(c(10, 10)))
})
