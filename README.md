# simulatr <img src="inst/logo/simulatr.png" align="right" width="100" />

<!-- badges: start -->
[![R-CMD-check](https://github.com/toscm/simulatr/workflows/R-CMD-check/badge.svg)](https://github.com/toscm/simulatr/actions)
[![Codecov test
coverage](https://codecov.io/gh/toscm/simulatr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/toscm/simulatr?branch=main)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/simulatr)](https://cran.r-project.org/package=simulatr)
<!-- badges: end -->

An R package for simulating omics datasets either from scratch or from existing,
publicly available datasets. Configurable parameters are correlation structure,
biases, noise and the relationship between predictors and outcome variable.

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Purpose](#purpose)
- [Next Steps](#next-steps)
- [Installation](#installation)
- [Usage](#usage)
  - [Simulate a dataset](#simulate-a-dataset)
  - [List of the platforms](#list-of-the-platforms)
  - [Retrieve data for a given platform](#retrieve-data-for-a-given-platform)
  - [List of the datasets](#list-of-the-datasets)
- [Contributing](#contributing)
- [Related Work](#related-work)
  - [Summary](#summary)
  - [Links](#links)

## Purpose

Evaluation of statistical methods is best done with datasets where all relevant
parameters can be controlled. Parameters of interest are e.g. the number of
observations/features, the correlation structure between samples/features, the
relationship between features and outcome and the amount of noise and/or biases
within the data. As this is rarely possible with real-world datasets, it often
makes sense to not only evaluate methods on real-world datasets, but also on
simulated datasets. The goal of this package is therefore, to make simulation of
such datasets as easy as possible.

## Next Steps

- [x] Remove `gse` parameter
- [x] Fix indentation of examples in README
- [x] Fix simplest bias example in README
- [x] Replace `*.csv` files with one big `.rda` or `.rds` file (see function
  `saveRDS`)
- [x] Read `*.rds` file only once  (see e.g. package `memoise`)
- [x] Add a changelog to the package (from now on, every pull request should
  increase the package version. See <https://keepachangelog.com/en/1.0.0/> and
  <https://semver.org/>.
- [x] Make `list_datasets` return all available Metadata (not just title title,
  type, platform_id and data_row_count)
- [x] Document package usage either in a
  [vignette](https://r-pkgs.org/vignettes.html) or in chapter [Usage](#usage).
- [x] Write tests for all functions. See <https://r-pkgs.org/tests.html> for
  details on how to write testcases for R functions.
- [ ] Implement `cor_func` / `cor_func_args` argument: be creative
- [ ] Make sure all functions are thoroughly documented. See
  <https://r-pkgs.org/man.html> for details on how to write documentation for R
  functions.
- [ ] Improve literature research results.
- [ ] Publish the package to CRAN.
- [x] Optional: speed up `list_datasets` by retrieving the metadata without
  actually downloading the expression matrix (maybe by querying the NCBI
  website)

## Installation

```R
# From Github (development version)
devtools::install_github("toscm/simulatr")
# From CRAN (stable version)
install.packages("simulatr") # not yet available
```

## Usage

### Simulate a dataset

#### The simplest one

Generates a (5,5) dataframe with random data.

```R
simulatr::simulate_dataset()

#result:

# $Raw_data
#           X1          X2          X3         X4          X5
# 1  0.1762176 -0.31198363  0.32223354 -0.2343050 -0.05572341
# 2  1.1550628  1.99176568  1.13742129 -0.2090538  0.80900189
# 3  1.7199090  0.06935324  1.09140363  0.7656588 -0.36169380
# 4 -1.5826347 -0.78319329 -1.48307500  0.3422295  0.87223922
# 5 -1.9270000 -0.64069114  0.02274371 -1.0025085  1.26573656

# $Noise_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    0    0    0    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    0    0    0    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Final_data
#           X1          X2          X3         X4          X5
# 1  0.1762176 -0.31198363  0.32223354 -0.2343050 -0.05572341
# 2  1.1550628  1.99176568  1.13742129 -0.2090538  0.80900189
# 3  1.7199090  0.06935324  1.09140363  0.7656588 -0.36169380
# 4 -1.5826347 -0.78319329 -1.48307500  0.3422295  0.87223922
# 5 -1.9270000 -0.64069114  0.02274371 -1.0025085  1.26573656

```

#### With given dimension

The users can define the dimension of the simulated data. `n` is the number of
samples and `p` is the number of features (e.g. genes).

```R
simulatr::simulate_dataset(n = 2, p = 3)

# result :

# $Raw_data
#          X1        X2         X3
# 1 0.9534753 1.5397671  1.3401822
# 2 1.1404721 0.4871656 -0.5003632

# $Noise_matrix
#      [,1] [,2] [,3]
# [1,]    0    0    0
# [2,]    0    0    0

# $Bias_matrix       
#      [,1] [,2] [,3]
# [1,]    0    0    0
# [2,]    0    0    0

# $Final_data
#          X1        X2         X3
# 1 0.9534753 1.5397671  1.3401822
# 2 1.1404721 0.4871656 -0.5003632

```

#### With given data

The users can provide a dataframe from which they want to derive the simulated
data.

The following simulated data is derived from normal distribution.

```R
simulatr::simulate_dataset(n = 5, 
                           p = 5, 
                           base = data.frame(matrix(stats::rnorm(6 * 6), 6, 6)))

# result :

#           X4         X5         X1          X2         X6
# 5  0.1256898 -0.3160537 0.04232887  1.18364610 0.02548396
# 3 -0.6574073  0.2382905 1.80930896 -0.80482068 1.40157078
# 1  1.9728739 -0.5976392 0.14674887 -1.29226331 0.48473688
# 6 -2.1417302  0.5517731 1.76103325 -0.22870073 0.66565249
# 4  0.2322724 -2.5704606 0.96798778  0.03665393 2.24897548

```

The user can get simulated data derived by generalised linear model using the
following function.

```R
simulatr::simulate_dataset(n = 5,
                           p = 6,
                           base = simulate_glm_data(dat = as.data.frame(simulatr::get_dataset(
                                             gse = "GSE3821"
                           ))))

# result :  

# $Raw_data
#             GSM87675   GSM87673     GSM87662     GSM87665   GSM87663      GSM87668
# 6417_at    0.4946612  -11.16338    0.5856437    3.0071917   28.81056   -0.69561632
# 5828_at   59.3605483   54.34398  121.6307257  120.9315708  158.00851   72.94667034
# 2909_at    0.3321056  -11.19807    1.6905615    0.5061987   28.47222    0.03810145
# 7983_at  300.2944299  284.08063  564.7004732  745.5949269  872.47721  299.40028589
# 6154_at 1525.4323096 1541.10006 2848.4504152 1795.9567249 3083.38419 1617.09406563

# $Noise_matrix
#      [,1] [,2] [,3] [,4] [,5] [,6]
# [1,]    0    0    0    0    0    0
# [2,]    0    0    0    0    0    0
# [3,]    0    0    0    0    0    0
# [4,]    0    0    0    0    0    0
# [5,]    0    0    0    0    0    0

# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5] [,6]
# [1,]    0    0    0    0    0    0
# [2,]    0    0    0    0    0    0
# [3,]    0    0    0    0    0    0
# [4,]    0    0    0    0    0    0
# [5,]    0    0    0    0    0    0

# $Final_data
#             GSM87675   GSM87673     GSM87662     GSM87665   GSM87663      GSM87668
# 6417_at    0.4946612  -11.16338    0.5856437    3.0071917   28.81056   -0.69561632
# 5828_at   59.3605483   54.34398  121.6307257  120.9315708  158.00851   72.94667034
# 2909_at    0.3321056  -11.19807    1.6905615    0.5061987   28.47222    0.03810145
# 7983_at  300.2944299  284.08063  564.7004732  745.5949269  872.47721  299.40028589
# 6154_at 1525.4323096 1541.10006 2848.4504152 1795.9567249 3083.38419 1617.09406563

```

#### Computing y with given beta

`beta` is a (q*p) matrix to denote the effect of each feature. `y` is the
response variable derived from the predictor variable `base`.

Suppose, we throw a ball. Here `y` is the height at time `base`. `beta` (for
this example, beta[1] is the initial velocity and beta[2] is the gravity) is
derived from the observed data `base` with the help of regression.

```R
simulate_dataset(
  n = 5,
  p = 5,
  base = data.frame(matrix(rnorm(5*5), 5, 5)),
  beta = matrix(1, 1, 5),
  noise_func = uniform_noise,
  noise_func_args = list(min = 0, max = 0.5),
  bias_func = constant_batch_effect,
  bias_func_args = list(
    b = 2,
    f = 3,
    s = c(2, 3)
  )
)

# result :

# $Raw_data
#           X1          X2          X3         X4          X5
# 1 -0.5631143 -1.25772826 -2.88727732  2.0029593  1.07202852
# 2  0.7342713 -0.22725993  0.49327326 -0.2374921  0.90956033
# 3 -0.6018707  0.04448858  0.39703575 -0.1720591 -0.23891208
# 4 -1.5804805 -0.45933286 -0.62823990  0.8727630  0.01172443
# 5 -0.1881927  0.03466649  0.04679791 -1.8362100  0.60073192

# $y
#            [,1]
# [1,] -1.6331320
# [2,]  1.6723528
# [3,] -0.5713176
# [4,] -1.7835658
# [5,] -1.3422064

# $Noise_matrix
#            [,1]       [,2]       [,3]        [,4]       [,5]
# [1,] 0.20522398 0.19019955 0.44916230 0.449675806 0.18695505
# [2,] 0.15800413 0.05544260 0.12167595 0.365121750 0.13632798
# [3,] 0.06898693 0.26681824 0.46568979 0.164445931 0.47057208
# [4,] 0.38260321 0.05597352 0.30260381 0.019969805 0.04433646
# [5,] 0.41993020 0.48683033 0.03221877 0.008465517 0.06728425

# $Bias_arguments
# $Bias_arguments$b
# [1] 1 2 2 2 1

# $Bias_arguments$f
# [1] 3

# $Bias_arguments$s
# [1] 2 3


# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    2    2    0    2    0
# [2,]    3    3    0    3    0
# [3,]    3    3    0    3    0
# [4,]    3    3    0    3    0
# [5,]    2    2    0    2    0

# $Features_affected
# [1] 1 2 4

# $Final_data
#         X1        X2          X3        X4         X5
# 1 1.642110 0.9324713 -2.43811502 4.4526351 1.25898356
# 2 3.892275 2.8281827  0.61494921 3.1276296 1.04588830
# 3 2.467116 3.3113068  0.86272554 2.9923868 0.23166000
# 4 1.802123 2.5966407 -0.32563608 3.8927328 0.05606089
# 5 2.231737 2.5214968  0.07901668 0.1722555 0.66801617

```

#### With given gse

The users can use simulate_gse function as base. In that case, the users will
get simulated data related to that specific `gse` number.

```R
simulatr::simulate_dataset(n = 5, 
                           p = 5, 
                           base = simulatr::simulate_gse(n = 10, p = 10, "GSE3821"))

# result :

# $Raw_data
#            GSM87674 GSM87666 GSM87669 GSM87661 GSM87671
# 10858_s_at      4.6    368.7    317.8    132.2      0.9
# 6278_at        43.1    203.8     59.9      4.9     21.5
# 5267_at         3.5   1567.8   1635.4    110.1    162.1
# 3937_g_at      24.0     18.2    711.9      5.9     12.8
# 9673_at        65.2      2.8    129.3    107.7     88.7

# $Noise_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    0    0    0    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    0    0    0    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Final_data
#            GSM87674 GSM87666 GSM87669 GSM87661 GSM87671
# 10858_s_at      4.6    368.7    317.8    132.2      0.9
# 6278_at        43.1    203.8     59.9      4.9     21.5
# 5267_at         3.5   1567.8   1635.4    110.1    162.1
# 3937_g_at      24.0     18.2    711.9      5.9     12.8
# 9673_at        65.2      2.8    129.3    107.7     88.7

```

#### With given noise

The users can choose the type of noise they want to add to their simulated data.
They can either provide their own noise (a n*p dimensional matrix) or
choose from the given noise functions. If they choose the given noise function,
they have to provide arguments for the chosen one. We provide noise function
with gaussian, poisson, exponential, binomial and uniform distribution.

##### Gaussian/normal noise function

Here argument `sd` is the standard deviation of the noise.

```R
simulatr::simulate_dataset(n = 5, 
                           p = 5, 
                           noise_func = random_noise, 
                           noise_func_args = list(sd = 1))

# result :

# $Raw_data
#           X1          X2         X3         X4           X5
# 1  2.2311449  0.03653275 -0.5661968 -1.3128648  1.904511959
# 2 -1.1314648  0.45451584  0.6629861  0.3385688 -0.308275629
# 3 -0.4960574 -0.66998209 -0.8543475 -0.1887187 -0.395712112
# 4  0.4143783  2.02210645 -0.6322548 -0.3483600  0.990630383
# 5 -0.3332484 -1.57109667 -1.6374831  0.4433273  0.007154562

# $Noise_matrix
#            [,1]       [,2]      [,3]       [,4]       [,5]
# [1,] 0.90979703  2.0057072 1.4083337  1.1825010 -0.6467732
# [2,] 0.79984495 -0.3275907 0.6731386  1.6362032  1.6661878
# [3,] 1.94676034 -0.6974455 2.2211487 -0.3635689  1.1419819
# [4,] 0.88901690  1.9337181 2.7419242  0.3615179 -0.1667313
# [5,] 0.05061772 -1.0825537 1.9258480  0.1851097  1.3866912

# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    0    0    0    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Final_data
#           X1         X2        X3          X4        X5
# 1  3.1409419  2.0422400 0.8421368 -0.13036382 1.2577387
# 2 -0.3316198  0.1269251 1.3361247  1.97477198 1.3579122
# 3  1.4507030 -1.3674276 1.3668012 -0.55228759 0.7462698
# 4  1.3033952  3.9558245 2.1096693  0.01315786 0.8238991
# 5 -0.2826306 -2.6536504 0.2883648  0.62843704 1.3938458

```

##### Poisson noise

Here `lambda` is the argument of poisson noise.

```R
simulatr::simulate_dataset(n = 5, 
                           p = 5, 
                           noise_func = poisson_noise, 
                           noise_func_args = list(lambda = 1))

# result :

# $Raw_data
#            X1          X2         X3         X4         X5
# 1 -0.05811362  1.09581610  0.1266713 -0.1083199  0.5128394
# 2 -0.92454146  1.38474517  0.4271527  0.3935762  0.7285983
# 3 -0.54955544 -0.94320261 -0.4588501  1.7493039  0.3129103
# 4  0.14519516 -0.07714980  0.9755154  0.2408752 -2.7976624
# 5  0.65178727  0.09877979 -0.2932061 -1.0808705 -0.7367765

# $Noise_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    1    0    2    2
# [2,]    2    0    1    1    1
# [3,]    0    2    2    1    0
# [4,]    0    0    0    3    1
# [5,]    0    3    0    1    2

# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    0    0    0    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Final_data
#            X1         X2         X3          X4         X5
# 1 -0.05811362  2.0958161  0.1266713  1.89168008  2.5128394
# 2  1.07545854  1.3847452  1.4271527  1.39357615  1.7285983
# 3 -0.54955544  1.0567974  1.5411499  2.74930391  0.3129103
# 4  0.14519516 -0.0771498  0.9755154  3.24087522 -1.7976624
# 5  0.65178727  3.0987798 -0.2932061 -0.08087049  1.2632235
```

##### Uniform noise

Here `min` and `max` are the function arguments of uniform noise. `min` and
`max` define the range of the noise.

```R
simulatr::simulate_dataset(n = 5, 
                           p = 5, 
                           noise_func = uniform_noise, 
                           noise_func_args = list(min = 1, max = 2))

# result :

# $Raw_data
#           X1           X2          X3         X4         X5
# 1 -0.7797268 -0.996224433  0.36576369 -1.4733228  0.3948879
# 2 -1.4080089  0.105231072  1.52907588  0.2473507 -1.4453939
# 3 -0.3974147  0.002860514 -0.44420052  1.1363579 -0.6719359
# 4 -0.7413664  1.093064653  0.05801465 -1.1002725 -0.1508035
# 5 -0.3506015 -0.608807304 -0.93857778 -0.4832457  0.2615543

# $Noise_matrix
#          [,1]     [,2]     [,3]     [,4]     [,5]
# [1,] 1.434359 1.453844 1.398531 1.733971 1.032687
# [2,] 1.562779 1.130768 1.363593 1.813566 1.528254
# [3,] 1.852378 1.208463 1.883415 1.395400 1.042114
# [4,] 1.471074 1.652778 1.102623 1.084424 1.153834
# [5,] 1.118819 1.485851 1.683057 1.599802 1.846646

# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    0    0    0    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Final_data
#          X1        X2        X3          X4         X5
# 1 0.6546318 0.4576194 1.7642946  0.26064842 1.42757512
# 2 0.1547698 1.2359988 2.8926688  2.06091677 0.08285979
# 3 1.4549628 1.2113237 1.4392149  2.53175808 0.37017818
# 4 0.7297077 2.7458426 1.1606372 -0.01584851 1.00303089
# 5 0.7682178 0.8770436 0.7444793  1.11655609 2.10819990

```

##### Binomial noise

Here `size` and `prob` are the function arguments. `size` defines the number of
trials and `prob` defines the probability of success on each trial.

```R
simulatr::simulate_dataset(n = 5, 
                           p = 5, 
                           noise_func = binomial_noise, 
                           noise_func_args = list(size = 10, prob = 0.5))

# result :

# $Raw_data
#            X1          X2          X3         X4         X5
# 1 -0.99022351 -1.33748943 -1.06756227  2.1751393  1.2303136
# 2 -1.15137820  0.62407057 -0.70550466  0.4030568 -0.9331593
# 3  1.24113048 -0.05228867  0.06352701  1.5743568 -0.2792377
# 4  0.05258765  1.01758132  0.34715785  0.9336842 -0.6732322
# 5 -1.14486335 -0.84741043 -0.65201094 -1.1267899  2.0442877

# $Noise_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    6    5    4    7    7
# [2,]    4    5    6    4    4
# [3,]    3    5    6    4    3
# [4,]    6    5    4    7    7
# [5,]    5    5    5    4    5

# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    0    0    0    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Final_data
#         X1       X2       X3       X4       X5
# 1 5.009776 3.662511 2.932438 9.175139 8.230314
# 2 2.848622 5.624071 5.294495 4.403057 3.066841
# 3 4.241130 4.947711 6.063527 5.574357 2.720762
# 4 6.052588 6.017581 4.347158 7.933684 6.326768
# 5 3.855137 4.152590 4.347989 2.873210 7.044288

```

##### Exponential noise

Here `rate` is the function argument.

```R
simulatr::simulate_dataset(n = 5, 
                           p = 5, 
                           noise_func = exponential_noise, 
                           noise_func_args = list(rate = 1))

result :

# $Raw_data
#           X1         X2         X3          X4           X5
# 1  3.2065101 -0.2331106  0.6306909 -0.35517021 -2.148703085
# 2 -0.4406006 -1.5307214  1.0642876  0.08821547 -0.006447875
# 3 -0.4372114  0.6441982  0.4472678 -0.75549948  0.993803546
# 4 -0.0399572  1.0041989  1.9846562  0.59763520 -0.351116026
# 5  0.1363504  1.4931482 -0.9035270 -0.61957924  2.240344761

# $Noise_matrix
#           [,1]      [,2]      [,3]      [,4]      [,5]
# [1,] 0.5215023 1.6726942 1.2906344 0.9334373 1.4485531
# [2,] 0.8820923 0.5529964 0.6026034 0.5573415 0.3227387
# [3,] 0.7423318 0.6685330 0.3841618 1.1635156 0.5389766
# [4,] 2.5077895 0.5618750 1.4173889 0.1483538 3.1860982
# [5,] 0.3218608 4.7494683 0.3427328 0.2197831 0.7695381

# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    0    0    0    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Final_data
#          X1        X2         X3         X4         X5
# 1 3.7280124  1.439584  1.9213253  0.5782671 -0.7001499
# 2 0.4414917 -0.977725  1.6668909  0.6455570  0.3162909
# 3 0.3051204  1.312731  0.8314296  0.4080161  1.5327801
# 4 2.4678323  1.566074  3.4020451  0.7459890  2.8349822
# 5 0.4582112  6.242617 -0.5607942 -0.3997961  3.0098829

```

#### With given bias

The users can choose the type of bias they want to add to their simulated data.
They can either provide their own bias (a (n, p) dimensional matrix) or
choose from the given bias functions. If they choose the given bias function,
they have to provide arguments for the chosen one. We provide bias function
named `constant_batch_effect`.

##### Constant batch effect

`n` and `p` denotes the number of samples and features respectively.

`b` denotes the batch each sample belongs to. Suppose, the samples come from 3
different places. The users can define which sample belongs to which place. If
*b = c(1,2,1,2,3,3,2)*, that means sample1 belongs to batch 1, sample 2 belongs
to batch 2, sample 3 belongs to batch 1, sample 5 belongs to batch 3 and so on.

`f` denotes the number of features to be affected. If the user chooses *f = 4*,
then 4 features will be randomly selected.

*s = c(1,2,1)* means batch 1, 2 and 3 will be affected by 1, 2 and 1
respectively. `s` denotes the strength of the batch effect, i.e., how much the
feature values within a batch are changed through the batch effect. Here, sample
2 and 5 belong to batch 1 and other samples belong to batch 2. Samples in batch
1 have their feature values increased by `s = 1` whereas samples in batch 2 have
their feature values increased by `s = 2`. Features 1,3,4 and 5 are affected by
the batch effects.

Here is an example :

</br>
<img src = "../inst/Pictures/const_batch_effect1.jpg" width
= 50% height = 50% >
</br>
</br>

```R
simulatr::simulate_dataset( n = 7,
                            p = 8,
                            base = data.frame(matrix(0, 7, 8)),
                            bias_func = constant_batch_effect,
                            bias_func_args = (list(b = c(1,2,1,2,3,3,2),
                            f = 4,
                            s = c(1,2,1))))

# result :

# $Raw_data
#   X1 X2 X3 X4 X5 X6 X7 X8
# 1  0  0  0  0  0  0  0  0
# 2  0  0  0  0  0  0  0  0
# 3  0  0  0  0  0  0  0  0
# 4  0  0  0  0  0  0  0  0
# 5  0  0  0  0  0  0  0  0
# 6  0  0  0  0  0  0  0  0
# 7  0  0  0  0  0  0  0  0

# $Noise_matrix
#      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
# [1,]    0    0    0    0    0    0    0    0
# [2,]    0    0    0    0    0    0    0    0
# [3,]    0    0    0    0    0    0    0    0
# [4,]    0    0    0    0    0    0    0    0
# [5,]    0    0    0    0    0    0    0    0
# [6,]    0    0    0    0    0    0    0    0
# [7,]    0    0    0    0    0    0    0    0

# $Bias_arguments
# $Bias_arguments$b
# [1] 1 2 1 2 3 3 2

# $Bias_arguments$f
# [1] 4

# $Bias_arguments$s
# [1] 1 2 1


# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
# [1,]    1    0    0    1    1    1    0    0
# [2,]    2    0    0    2    2    2    0    0
# [3,]    1    0    0    1    1    1    0    0
# [4,]    2    0    0    2    2    2    0    0
# [5,]    1    0    0    1    1    1    0    0
# [6,]    1    0    0    1    1    1    0    0
# [7,]    2    0    0    2    2    2    0    0

# $Features_affected
# [1] 4 1 6 5

# $Final_data
#   X1 X2 X3 X4 X5 X6 X7 X8
# 1  1  0  0  1  1  1  0  0
# 2  2  0  0  2  2  2  0  0
# 3  1  0  0  1  1  1  0  0
# 4  2  0  0  2  2  2  0  0
# 5  1  0  0  1  1  1  0  0
# 6  1  0  0  1  1  1  0  0
# 7  2  0  0  2  2  2  0  0

````

The users can call a simplified version of constant_batch_effect. If users
define `b = 2`, then samples will be randomly assigned to 2 different batches.

```R
simulatr::simulate_dataset( n = 5,
                            p = 5,
                            base = data.frame(matrix(0, 5, 5)),
                            bias_func = constant_batch_effect,
                            bias_func_args = (list(b = 2, f = 4, s = c(1, 2))))

# result :

# $Raw_data       
#   X1 X2 X3 X4 X5
# 1  0  0  0  0  0
# 2  0  0  0  0  0
# 3  0  0  0  0  0
# 4  0  0  0  0  0
# 5  0  0  0  0  0

# $Noise_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    0    0    0    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Bias_arguments
# $Bias_arguments$b
# [1] 1 1 2 2 2

# $Bias_arguments$f
# [1] 4

# $Bias_arguments$s
# [1] 1 2


# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    1    1    1    1
# [2,]    0    1    1    1    1
# [3,]    0    2    2    2    2
# [4,]    0    2    2    2    2
# [5,]    0    2    2    2    2

# $Features_affected
# [1] 4 3 2 5

# $Final_data
#   X1 X2 X3 X4 X5
# 1  0  1  1  1  1
# 2  0  1  1  1  1
# 3  0  2  2  2  2
# 4  0  2  2  2  2
# 5  0  2  2  2  2

```

Here, sample 1 and sample 2 belongs to batch 1 and other samples belong to batch
2. Batch 1 is increased by 1 wheras batch 2 is increased by 2.Four featues,
feature 2, feature 3, feature 4 and feature 5, are randomly selected for the
effect.

In a more simplified version, if the first batch is affected by 0, then user can
skip that.

```R
simulatr::simulate_dataset(n = 5,
                           p = 5,
                           base = data.frame(matrix(0, 5, 5)),
                           bias_func = constant_batch_effect,
                           bias_func_args = (list(b = 2, f = 2, s = 1)))

# result :

# $Raw_data       
#   X1 X2 X3 X4 X5
# 1  0  0  0  0  0
# 2  0  0  0  0  0
# 3  0  0  0  0  0
# 4  0  0  0  0  0
# 5  0  0  0  0  0

# $Noise_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    0    0    0    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Bias_arguments
# $Bias_arguments$b
# [1] 2 1 1 1 1

# $Bias_arguments$f
# [1] 2

# $Bias_arguments$s
# [1] 0 1


# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    1    0    1    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Features_affected
# [1] 4 2

# $Final_data
#   X1 X2 X3 X4 X5
# 1  0  1  0  1  0
# 2  0  0  0  0  0
# 3  0  0  0  0  0
# 4  0  0  0  0  0
# 5  0  0  0  0  0
```

Here, feature 2 and 4 are affected. Sample 1 belongs to batch 2. Other
samples belong to batch 1. Batch 1 is increased by 0 and batch 2 is increased by
1.

#### Some more examples

```R
simulatr::simulate_dataset( n = 5,
                            p = 5,
                            base = simulate_gse(5, 5, gse = "GSE461"),
                            bias_func = constant_batch_effect,
                            bias_func_args = (list(b = 2, f = 4, s = c(1, 2))))

# Result:

# $Raw_data
#           GSM7495 GSM7491 GSM7490 GSM7492 GSM7494
# 8207_at      27.3     7.0   243.9  3945.1    11.8
# 8293_at      69.7    58.6     4.2   165.4     6.1
# 3025_s_at  2696.5    11.1    15.6   257.3    15.0
# 2556_at      23.4   738.0     3.0     4.6    53.4
# 10137_at     10.5    39.3   280.6    60.9   250.0

# $Noise_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    0    0    0    0    0
# [2,]    0    0    0    0    0
# [3,]    0    0    0    0    0
# [4,]    0    0    0    0    0
# [5,]    0    0    0    0    0

# $Bias_arguments
# $Bias_arguments$b
# [1] 2 2 2 1 1

# $Bias_arguments$f
# [1] 4

# $Bias_arguments$s
# [1] 1 2


# $Bias_matrix
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    2    2    0    2    2
# [2,]    2    2    0    2    2
# [3,]    2    2    0    2    2
# [4,]    1    1    0    1    1
# [5,]    1    1    0    1    1

# $Features_affected
# [1] 2 4 5 1

# $Final_data
#           GSM7495 GSM7491 GSM7490 GSM7492 GSM7494
# 8207_at      29.3     9.0   243.9  3947.1    13.8
# 8293_at      71.7    60.6     4.2   167.4     8.1
# 3025_s_at  2698.5    13.1    15.6   259.3    17.0
# 2556_at      24.4   739.0     3.0     5.6    54.4
# 10137_at     11.5    40.3   280.6    61.9   251.0 

```

```R
simulatr::simulate_dataset( n = 20,
                            p = 4,
                            base = get_dataset(gse = "GSE461"),
                            bias_func = constant_batch_effect,
                            bias_func_args = (list(b = 2, f = 4, s = c(1,2))))

# Result:

# $Raw_data
#           GSM7494 GSM7492 GSM7491 GSM7490
# 5141_at    5082.8  5417.0  6886.8  5634.4
# 7689_at     130.3   406.9   423.9   309.4
# 11223_at     60.2   100.6    91.8    64.3
# 8922_at     406.1   593.3   748.8   709.5
# 6530_at      43.1    70.0    57.5    50.5
# 3490_f_at     1.5     1.5     0.3     0.4
# 4225_at     100.0   253.6   269.8   203.1
# 7545_at     504.0   211.2   193.1   204.4
# 2299_at       2.1    16.4     0.9     2.1
# 7578_at      82.4    87.4    85.8    58.6
# 4623_at     732.8   797.7   799.6  1157.6
# 2407_at      31.0    40.5    45.2    52.1
# 2917_s_at     4.4     1.7     1.2     0.7
# 5694_at     929.5   353.1   399.2   387.4
# 9308_at     569.5   468.3   493.5   443.0
# 2701_g_at     1.6    22.5    13.9    11.7
# 6527_at      67.5    36.8   101.5    56.4
# 10824_at      8.9    31.5    60.4     2.8
# 7287_at      13.6     1.1    14.6    18.0
# 4453_at    1048.7   824.4   880.3   851.1

# $Noise_matrix
#       [,1] [,2] [,3] [,4]
#  [1,]    0    0    0    0
#  [2,]    0    0    0    0
#  [3,]    0    0    0    0
#  [4,]    0    0    0    0
#  [5,]    0    0    0    0
#  [6,]    0    0    0    0
#  [7,]    0    0    0    0
#  [8,]    0    0    0    0
#  [9,]    0    0    0    0
# [10,]    0    0    0    0
# [11,]    0    0    0    0
# [12,]    0    0    0    0
# [13,]    0    0    0    0
# [14,]    0    0    0    0
# [15,]    0    0    0    0
# [16,]    0    0    0    0
# [17,]    0    0    0    0
# [18,]    0    0    0    0
# [19,]    0    0    0    0
# [20,]    0    0    0    0

# $Bias_arguments
# $Bias_arguments$b
#  [1] 1 1 2 1 1 2 2 1 2 2 2 1 1 1 2 2 1 2 2 2

# $Bias_arguments$f
# [1] 4

# $Bias_arguments$s
# [1] 1 2


# $Bias_matrix
#       [,1] [,2] [,3] [,4]
#  [1,]    1    1    1    1
#  [2,]    1    1    1    1
#  [3,]    2    2    2    2
#  [4,]    1    1    1    1
#  [5,]    1    1    1    1
#  [6,]    2    2    2    2
#  [7,]    2    2    2    2
#  [8,]    1    1    1    1
#  [9,]    2    2    2    2
# [10,]    2    2    2    2
# [11,]    2    2    2    2
# [12,]    1    1    1    1
# [13,]    1    1    1    1
# [14,]    1    1    1    1
# [15,]    2    2    2    2
# [16,]    2    2    2    2
# [17,]    1    1    1    1
# [18,]    2    2    2    2
# [19,]    2    2    2    2
# [20,]    2    2    2    2

# $Features_affected
# [1] 4 2 3 1

# $Final_data
#           GSM7494 GSM7492 GSM7491 GSM7490
# 5141_at    5083.8  5418.0  6887.8  5635.4
# 7689_at     131.3   407.9   424.9   310.4
# 11223_at     62.2   102.6    93.8    66.3
# 8922_at     407.1   594.3   749.8   710.5
# 6530_at      44.1    71.0    58.5    51.5
# 3490_f_at     3.5     3.5     2.3     2.4
# 4225_at     102.0   255.6   271.8   205.1
# 7545_at     505.0   212.2   194.1   205.4
# 2299_at       4.1    18.4     2.9     4.1
# 7578_at      84.4    89.4    87.8    60.6
# 4623_at     734.8   799.7   801.6  1159.6
# 2407_at      32.0    41.5    46.2    53.1
# 2917_s_at     5.4     2.7     2.2     1.7
# 5694_at     930.5   354.1   400.2   388.4
# 9308_at     571.5   470.3   495.5   445.0
# 2701_g_at     3.6    24.5    15.9    13.7
# 6527_at      68.5    37.8   102.5    57.4
# 10824_at     10.9    33.5    62.4     4.8
# 7287_at      15.6     3.1    16.6    20.0
# 4453_at    1050.7   826.4   882.3   853.1
```

```R
simulatr::simulate_dataset( n = 10,
                            p = 4,
                            base = get_dataset(gse = "GSE461"),
                            noise_func = uniform_noise,
                            noise_func_args = list(min = 1, max = 2),
                            bias_func = constant_batch_effect,
                            bias_func_args = list(b = 2, f = 4, s = c(1, 2)))

# Result :
# $Raw_data
#           GSM7491 GSM7496 GSM7490 GSM7493
# 4074_at    1056.4  2843.4  1245.3  2154.8
# 6770_i_at    35.4    76.0    40.9    56.2
# 2429_at      18.5     3.6     0.9     8.6
# 6699_at     160.6   100.4   175.4   109.5
# 7968_at      74.7    79.2    38.6    47.4
# 6252_at      10.8     0.3     0.9     0.7
# 8457_at     205.0   161.1   143.7   110.8
# 10683_at     67.2    58.2    74.8    69.9
# 8966_at    1749.2   550.7   950.9   461.6
# 5457_at      19.2    10.0     9.9    12.7

# $Noise_matrix
#           [,1]     [,2]     [,3]     [,4]
#  [1,] 1.522539 1.901949 1.548870 1.656620
#  [2,] 1.938405 1.542918 1.228166 1.194903
#  [3,] 1.570219 1.756231 1.451785 1.755073
#  [4,] 1.333608 1.053543 1.935255 1.254156
#  [5,] 1.504847 1.937689 1.619417 1.198369
#  [6,] 1.644201 1.900440 1.313804 1.614920
#  [7,] 1.609227 1.218666 1.731578 1.509764
#  [8,] 1.374577 1.677683 1.062348 1.729263
#  [9,] 1.014870 1.190122 1.528480 1.356725
# [10,] 1.137060 1.782335 1.922753 1.919021

# $Bias_arguments
# $Bias_arguments$b
#  [1] 1 2 1 1 2 1 2 1 1 1

# $Bias_arguments$f
# [1] 4

# $Bias_arguments$s
# [1] 1 2


# $Bias_matrix
#       [,1] [,2] [,3] [,4]
#  [1,]    1    1    1    1
#  [2,]    2    2    2    2
#  [3,]    1    1    1    1
#  [4,]    1    1    1    1
#  [5,]    2    2    2    2
#  [6,]    1    1    1    1
#  [7,]    2    2    2    2
#  [8,]    1    1    1    1
#  [9,]    1    1    1    1
# [10,]    1    1    1    1

# $Features_affected
# [1] 2 1 3 4

# $Final_data
#              GSM7491     GSM7496     GSM7490    GSM7493
# 4074_at   1058.92254 2846.301949 1247.848870 2157.45662
# 6770_i_at   39.33840   79.542918   44.128166   59.39490
# 2429_at     21.07022    6.356231    3.351785   11.35507
# 6699_at    162.93361  102.453543  178.335255  111.75416
# 7968_at     78.20485   83.137689   42.219417   50.59837
# 6252_at     13.44420    3.200440    3.213804    3.31492
# 8457_at    208.60923  164.318666  147.431578  114.30976
# 10683_at    69.57458   60.877683   76.862348   72.62926
# 8966_at   1751.21487  552.890122  953.428480  463.95672
# 5457_at     21.33706   12.782335   12.822753   15.61902
```

```R
simulatr::simulate_dataset( n = 8,
                            p = 4,
                            base = simulate_gse(15, 15, "GSE803"),
                            noise_func = uniform_noise,
                            noise_func_args = list(min = 1, max = 2),
                            bias_func = constant_batch_effect,
                            bias_func_args = list(b = 2, f = 4, s = c(1, 2)))

# Result:

# $Raw_data
#            GSM12688 GSM12654 GSM12713 GSM12733
# 1535_at       148.6    101.8     97.0     62.2
# 34373_at       39.7   1077.1    141.0     26.7
# 35203_at       27.7    314.2    533.1     75.4
# 41605_at      458.4     14.6     23.9   2195.2
# 39982_r_at     16.3      3.6     48.6     12.8
# 40126_at      164.1      2.4      9.0    226.4
# 593_s_at        0.9    333.1   2935.4     67.2
# 37360_at        8.2     71.1    178.8      5.4

# $Noise_matrix
#          [,1]     [,2]     [,3]     [,4]
# [1,] 1.180408 1.047588 1.495384 1.380375
# [2,] 1.678990 1.515200 1.524956 1.400341
# [3,] 1.382764 1.362757 1.499169 1.422813
# [4,] 1.021458 1.766467 1.304031 1.707219
# [5,] 1.708883 1.326419 1.201463 1.118473
# [6,] 1.406368 1.381837 1.985364 1.383387
# [7,] 1.227164 1.538599 1.979325 1.590795
# [8,] 1.780569 1.495484 1.055557 1.602012

# $Bias_arguments
# $Bias_arguments$b
# [1] 2 2 1 2 1 1 1 2

# $Bias_arguments$f
# [1] 4

# $Bias_arguments$s
# [1] 1 2


# $Bias_matrix
#      [,1] [,2] [,3] [,4]
# [1,]    2    2    2    2
# [2,]    2    2    2    2
# [3,]    1    1    1    1
# [4,]    2    2    2    2
# [5,]    1    1    1    1
# [6,]    1    1    1    1
# [7,]    1    1    1    1
# [8,]    2    2    2    2

# $Features_affected
# [1] 2 3 1 4

# $Final_data
#              GSM12688    GSM12654   GSM12713    GSM12733
# 1535_at    151.780408  104.847588  100.49538   65.580375
# 34373_at    43.378990 1080.615200  144.52496   30.100341
# 35203_at    30.082764  316.562757  535.59917   77.822813
# 41605_at   461.421458   18.366467   27.20403 2198.907219
# 39982_r_at  19.008883    5.926419   50.80146   14.918473
# 40126_at   166.506368    4.781837   11.98536  228.783387
# 593_s_at     3.127164  335.638599 2938.37933   69.790795
# 37360_at    11.980569   74.595484  181.85556    9.002012 
```

The users can provide their own noise or bias matrix if they want.

```R
# simulatr::simulate_dataset( n = 4,
#                             p = 4,
#                             base = simulate_gse(15, 15, "GSE803"),
#                             noise_func = matrix(1, 4, 4),
#                             bias_func = matrix(2, 4, 4))

# # Result : 

# $Raw_data
#          GSM12738 GSM12733 GSM12698 GSM12688
# 40881_at    143.8     88.0     46.8   1324.0
# 32539_at    418.8    188.6     44.0    202.9
# 37466_at    810.9   1303.3    886.9     97.8
# 36708_at     67.4    616.8    553.6    127.8

# $Noise_matrix
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1

# $Bias_matrix
#      [,1] [,2] [,3] [,4]
# [1,]    2    2    2    2
# [2,]    2    2    2    2
# [3,]    2    2    2    2
# [4,]    2    2    2    2

# $Final_data
#          GSM12738 GSM12733 GSM12698 GSM12688
# 40881_at    146.8     91.0     49.8   1327.0
# 32539_at    421.8    191.6     47.0    205.9
# 37466_at    813.9   1306.3    889.9    100.8
# 36708_at     70.4    619.8    556.6    130.8

```

### List of the platforms

Provides list of all the platforms(e.g. GPL97) available in NCBI.

```R
utils::head(simulatr::list_platforms(),3)

# A part of the result that can be retrieved by this function :

# Accession                                                                     Title    
# 1  GPL25897                             Illumina HiSeq 4000 (Fagopyrum hailuogouense)    
# 2  GPL25881 Qiagen Mouse Inflammatory Response and Autoimmunity PCR Array (PAMM-077Z)    
# 3  GPL25892                                               HiSeq X Ten (Rattus rattus)    
#                   Technology                Taxonomy Data.Rows Samples.Count Series.Count
# 1 high-throughput sequencing Fagopyrum hailuogouense         0             6            1
# 2                     RT-PCR            Mus musculus        96            34            1
# 3 high-throughput sequencing           Rattus rattus         0             8            1
#             Contact Release.Date
# 1               GEO Dec 05, 2018
# 2 Patricia Silveyra Dec 04, 2018
# 3               GEO Dec 04, 2018

```

### Retrieve data for a given platform

The users can retrieve data for a specific platform (e.g. GPL97)

```R
simulatr::get_gpl_data("GPL96")

# # result :
#  GEO Accession Title                                            Technology                Organism
# a "GPL96"       "[HG-U133A] Affymetrix Human Genome U133A Array" "in situ oligonucleotide" "Homo sapiens"   
#   Status
# a "Public on Mar 11 2002"

```

### List of the datasets

Provides information about all series (e.g. GSE465) related to a specific
platform (e.g. GPL95)

```R
simulatr::list_datasets(platform = "GPL95")

# # result :
#       Accession                                                                                      Title
# 20365     GSE465                                           Expression profiling in the muscular dystrophies
# 151738    GSE762                                                                            CCFAlmasan_CaP1
# 32434     GSE803                                                     GeneNote-Gene Normal tissue Expression
# 74830    GSE1007 Molecular profiles(HG-U95B,C,D,E) of dystrophin-deficient and normal human skeletal muscle
# 147372   GSE1302                                                                  primary trophoblast study
# 20322    GSE2508                                         Expression profiling in adipocytes of obese humans
# 164705   GSE5949       Comparison between cell lines from 9 different cancer tissue (NCI-60) (U95 platform)
# 16539   GSE51625                          Expression data from human abdominal, subcutaneous adipose tissue
#                          Series.Type     Taxonomy Sample.Count
# 20365  Expression profiling by array Homo sapiens           57
# 151738 Expression profiling by array Homo sapiens           25
# 32434  Expression profiling by array Homo sapiens          120
# 74830  Expression profiling by array Homo sapiens           86
# 147372 Expression profiling by array Homo sapiens           75
# 20322  Expression profiling by array Homo sapiens          195
# 164705 Expression profiling by array Homo sapiens          300
# 16539  Expression profiling by array Homo sapiens          120
#                                               Datasets Supplementary.Types
# 20365               GDS214;GDS262;GDS264;GDS265;GDS270                 CEL
# 151738              GDS719;GDS720;GDS721;GDS722;GDS723
# 32434               GDS422;GDS423;GDS424;GDS425;GDS426
# 74830                      GDS609;GDS610;GDS611;GDS612         CEL;EXP;RPT
# 147372
# 20322  GDS1495;GDS1496;GDS1497;GDS1498;GDS3601;GDS3602
# 164705                                                             CEL;EXP
# 16539                                                                  CEL
#                                                  Supplementary.Links                  PubMed.ID SRA.Accession
# 20365      ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSEnnn/GSE465/suppl                   11121445

# 151738

# 32434                                                                                  15388519

# 74830    ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE1nnn/GSE1007/suppl                   12698323

# 147372                                                                                 15161964

# 20322                                                                         16059715;18424589

# 164705   ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE5nnn/GSE5949/suppl 20053763;26048278;25003721

# 16539  ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE51nnn/GSE51625/suppl                   24103848

#                     Contact Release.Date
# 20365        Eric P Hoffman Jul 16, 2003
# 151738 John Gilmary Hissong Jun 01, 2004
# 32434          Orit Shmueli Nov 19, 2003
# 74830        Judith Haslett Feb 04, 2004
# 147372          Brig Mecham Apr 13, 2004
# 20322           Yong-Ho Lee Jan 01, 2006
# 164705    Uma T Shankavaram Aug 06, 2007
# 16539       Carol Shoulders Oct 29, 2013
```

## Contributing

1. Create a new feature branch
2. Commit your changes
3. Push your changes
4. Create a pull request
5. Wait until all tests have completed
6. Merge the pull request

To publish a version to CRAN, run the following commands in an active R session:

```R
devtools::document() # Update documentation
rcmdcheck::rcmdcheck( # Run `R CMD check` for this package
    args=c("--no-manual", "--as-cran"),
    build_args=c("--no-manual"),
    check_dir="check"
)
devtools::revdep() # Run `R CMD check` for all dependencies
devtools::spell_check() # Check spelling of package
devtools::release() # Builds, tests and submits the package to CRAN.
# Manual submission can be done at: https://cran.r-project.org/submit.html
```

Source: <https://r-pkgs.org/release.html>

## Related Work

### Summary

|                                                               | MOSim | MadSim | Simulatr |      |
| :------------------------------------------------------------ | :---- | :----- | :------- | :--- |
| number of features can be specified                           | x     | x      | x        |      |
| percentage of differentially expressed genes can be specified | x     | x      | x        |      |
| correlation structure can be specified                        |       | x      | x        |      |
| type of data (RNAseq/DNAseq)  can be specified                | x     |        | x        |      |
| platform (HGU133a, ...)  can be specified                     |       |        | x        |      |
| standard deviation or noise can be specified                  |       | x      | x        |      |
| ability to work with base dataset                             | x     | x      | x        |      |
| upper and lower limit can be specified                        |       | x      | x        |      |
| easy to read instruction                                      |       |        | x        |      |

- x means yes

### Links

- Omics Simla <https://omicssimla.sourceforge.io/>
- micro array data simulation
  <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5003477/>
