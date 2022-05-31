test_that("simulate_dataset returns a matrix", {
  expect_equal(class(simulate_dataset(2, 3)), c("matrix", "array"))
})

test_that("simulate_dataset returns a matrix of the correct dimensions", {
  expect_equal(dim(simulate_dataset(2, 3)), c(2, 3))
})
