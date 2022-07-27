test_that("test the dimension of the data returned", {
  expect_equal(class(normal_data(10, 10)), "data.frame")
})
