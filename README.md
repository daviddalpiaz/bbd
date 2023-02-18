
<!-- README.md is generated from README.Rmd. Please edit that file -->

# BaseBall Data

<!-- badges: start -->

[![R-CMD-check](https://github.com/daviddalpiaz/bbd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/daviddalpiaz/bbd/actions)
<!-- badges: end -->

The **`bbd`** (BaseBall Data) package is a [lightweight
package](https://www.tinyverse.org/) that contains functions to
facilitate the collection of baseball data from various sources online.

**This package is currently experimental.** All function interfaces are
liable to change without notice. For a mature and feature rich baseball
data package, consider
[`baseballr`](https://github.com/BillPetti/baseballr).

Current data sources include:

- [Statcast](https://baseballsavant.mlb.com/)
- [Baseball-Reference](https://www.baseball-reference.com/)
- [MLBAM](https://www.mlb.com/)
- [Chadwick Baseball Bureau
  Register](https://github.com/chadwickbureau/register)

More sources may be added in the future.

## Installation

You can install the development version of **`bbd`** from
[GitHub](https://github.com/daviddalpiaz/bbd) with:

``` r
# install.packages("devtools")
devtools::install_github("daviddalpiaz/bbd")
```

## Example

The most basic and common usage of **`bbd`** is collecting [Statcast
data](https://baseballsavant.mlb.com/statcast_search) for all games
played between two dates, inclusive.

``` r
library(bbd)
ws_2022 = statcast(start = "2022-10-28", end = "2022-11-05")
```

By default, `bbd` package attempts to be un-opinionated, and thus
returns a table containing the exact variables (to the extent possible)
returned by the Statcast API. The `statcast()` function provides
arguments that allow for some opinionated processing. Check the
documentation for details of this processing. Most importantly,
functionality to obtain both batter *and* pitcher names is included.
This functionality is also provided by default through the use of the
opinionated `statcast_bbd()` function for convenience.
