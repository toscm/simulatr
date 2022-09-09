test_that("test the dimension of the data returned", {
  expect_equal(class(simulatr::simulate_glm_data(
    dat = simulatr::normal_data(5, 6)
  )), "data.frame")
})
