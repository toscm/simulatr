test_that("Returns result of a given dimension", {
  expect_equal(dim(binomial_noise(
    10, 10,
    list(size = 50, prob = 0.5)
  )), dim(c(10, 10)))
})
