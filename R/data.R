#' People Information from the Chadwick Baseball Bureau Register
#'
#' A dataset containing baseball player names and unique identifiers used by
#' various sources. Original data source and documentation:
#' [`chadwickbureau/register`](https://github.com/chadwickbureau/register)
#'
#' @format A data frame with `r nrow(people)` rows and `r ncol(people)` columns:
#' \describe{
#'   \item{`name`}{`[character]` Player's full name listed as: Given Family Suffix}
#'   \item{`birth_year`}{`[integer]` Player's birth year}
#'   \item{`key_mlbam`}{`[integer]` Player's MLB Advanced Media (MLBAM) identifer}
#'   \item{`key_bbref`}{`[character]` Player's [Baseball-Reference](https://www.baseball-reference.com/) identifer}
#'   \item{`key_fangraphs`}{`[integer]` Player's [FanGraphs](https://www.fangraphs.com/) identifer}
#' }
"people"
