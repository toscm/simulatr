test_that("simulate_dataset returns a data frame", {
  expect_equal(class(simulate_dataset(2, 3)), c("data.frame"))
})

test_that("simulate_dataset returns a matrix of the correct dimensions", {
  expect_equal(dim(simulate_dataset(2, 3)), c(2, 3))
})
