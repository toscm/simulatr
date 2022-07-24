test_that("Returns result of a given dimension", {
  expect_equal(dim(uniform_noise(
    10, 10,
    list(min = 1, max = 10)
  )), dim(c(10, 10)))
})
