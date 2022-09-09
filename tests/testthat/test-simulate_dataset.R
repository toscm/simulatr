test_that("simulate_dataset returns a data frame", {
  expect_equal(class(simulate_dataset(2, 3)), c("list"))
})

test_that("simulate_dataset returns a matri of the correct dimensions", {
  expect_equal(dim(simulate_dataset(2, 3)$Final_data), c(2, 3))
})
