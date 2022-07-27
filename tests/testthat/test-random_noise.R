test_that("Returns result of a given dimension", {
  expect_equal(dim(random_noise(10, 10, list(sd = 1))), dim(c(10, 10)))
})
