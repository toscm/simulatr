test_that("Checks dimension of the result", {
  expect_equal(dim(simulate_gse(10, 10, gse = "GSE3821")), c(10, 10))
})
test_that("Returns list", {
  expect_equal(typeof(simulate_gse(10, 10, gse = "GSE3821")), "list")
})
