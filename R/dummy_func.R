# Make sure R CMD check recognizes that we're actually using the memoise
# package.
dummy_func <- function() {
    f <- function() NULL
    g <- memoise::memoise(f)
    return(g)
}
