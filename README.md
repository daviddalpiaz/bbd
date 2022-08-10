
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bbd

<!-- badges: start -->

[![R-CMD-check](https://github.com/daviddalpiaz/bbd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/daviddalpiaz/bbd/actions)
<!-- badges: end -->

The `bbd` package contains functions that facilitate the collection of
baseball data from various sources online. **This packages is currently
experimental.** All function interfaces are liable to change.

For a mature and feature rich baseball data package, consider
[`baseballr`](https://github.com/BillPetti/baseballr).

## Installation

You can install the development version of `bbd` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("daviddalpiaz/bbd")
```

## Example

The most basic usage of **`bbd`** is collecting [statcast
data](https://baseballsavant.mlb.com/statcast_search) for all games
played between two dates, inclusive.

``` r
library(bbd)
statcast(start = "2021-10-26", end = "2021-11-02")[, c(1, 3, 4, 5, 8)]
#> # A tibble: 1,726 × 5
#>    pitch_type release_speed release_pos_x release_pos_z pitcher
#>    <chr>              <dbl>         <dbl>         <dbl>   <int>
#>  1 CH                  87.7          1.04          5.88  664285
#>  2 CH                  87.1          1.26          5.99  664285
#>  3 CU                  79.1          1.31          5.83  664285
#>  4 CU                  80.5          1.17          5.98  664285
#>  5 CU                  77.9          1.48          5.88  664285
#>  6 SI                  94.2          1.11          6.09  664285
#>  7 SI                  95.9          1.06          6.08  664285
#>  8 CU                  77            1.28          5.95  664285
#>  9 CU                  81.9          0.98          5.96  664285
#> 10 CU                  80.1         -1.95          5.4   450203
#> # … with 1,716 more rows
#> # ℹ Use `print(n = ...)` to see more rows
```
