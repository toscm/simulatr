library(testthat)

test_that("list_platforms returns somje GPL IDs", {
  expect_true(c("GPL30510", "GPL31292", "GPL32302") %in% list_platforms()$Accession)
})
