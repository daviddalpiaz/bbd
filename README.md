
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bbd

<!-- badges: start -->

[![R-CMD-check](https://github.com/daviddalpiaz/bbd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/daviddalpiaz/bbd/actions)
<!-- badges: end -->

The `bbd` package contains functions that facilitating collecting
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
played on a particular day.

``` r
library(bbd)
get_statcast_day(date = "2021-11-02")[, 1:5]
#>        pitch_type  game_date release_speed release_pos_x release_pos_z
#>            <char>     <IDat>         <num>         <num>         <num>
#>     1:         CU 2022-08-07          72.8         -1.17          6.34
#>     2:         FF 2022-08-07          88.4         -1.30          6.25
#>     3:         CU 2022-08-07          72.4         -1.23          6.41
#>     4:         CU 2022-08-07          72.3         -1.26          6.39
#>     5:         FC 2022-08-07          83.8         -1.26          6.32
#>    ---                                                                
#> 39996:         FF 2022-07-29          86.5          2.62          6.16
#> 39997:         SL 2022-07-29          85.9         -2.44          5.25
#> 39998:         SI 2022-07-29          91.4         -4.27          3.81
#> 39999:         FF 2022-07-29          96.0          1.61          5.89
#> 40000:         CU 2022-07-29          78.0          2.24          5.68
```
