library(testthat)

test_that("list_platforms returns some GPL IDs", {
  expect_true(
    c("GPL32302") %in% list_platforms()$Accession
  )
})
test_that("list_platforms returns some GPL IDs", {
  expect_true(
    c("GPL31292") %in% list_platforms()$Accession
  )
})
