library("testthat")

# test_that("`predict(lamis_signature, lamis_test1)`` works", {
#     m <- "lamis_signature"
#     for (d in c("lamis_test1")) {
#         p <- getdata(m, typ="model", pkg="simulatr")
#         X <- getdata(d, typ="dataset", pkg="simulatr")
#         X2 <- rename(X, globals$FEATURE_MAPPINGS[[d]])
#         y <- safely(predict)(p, X2)
#         expect_null(y$error)
#     }
# })
