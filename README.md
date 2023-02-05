
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bbd

<!-- badges: start -->

[![R-CMD-check](https://github.com/daviddalpiaz/bbd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/daviddalpiaz/bbd/actions)
<!-- badges: end -->

The `bbd` package is a [lightweight package](https://www.tinyverse.org/)
that contains functions to facilitate the collection of baseball data
from various sources online. **This package is currently experimental.**
All function interfaces are liable to change without notice.

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

The most basic usage of `bbd` is collecting [statcast
data](https://baseballsavant.mlb.com/statcast_search) for all games
played between two dates, inclusive.

``` r
library(bbd)
ws_2022 = statcast(start = "2022-10-28", end = "2022-11-05")
data.frame(names = names(ws_2022), types = sapply(ws_2022, typeof))
#>                              names     types
#> 1                       pitch_type character
#> 2                        game_date   integer
#> 3                    release_speed    double
#> 4                    release_pos_x    double
#> 5                    release_pos_z    double
#> 6                      player_name character
#> 7                           batter   integer
#> 8                          pitcher   integer
#> 9                           events character
#> 10                     description character
#> 11                        spin_dir   logical
#> 12            spin_rate_deprecated   logical
#> 13          break_angle_deprecated   logical
#> 14         break_length_deprecated   logical
#> 15                            zone   integer
#> 16                             des character
#> 17                       game_type character
#> 18                           stand character
#> 19                        p_throws character
#> 20                       home_team character
#> 21                       away_team character
#> 22                            type character
#> 23                    hit_location   integer
#> 24                         bb_type character
#> 25                           balls   integer
#> 26                         strikes   integer
#> 27                       game_year   integer
#> 28                           pfx_x    double
#> 29                           pfx_z    double
#> 30                         plate_x    double
#> 31                         plate_z    double
#> 32                           on_3b   integer
#> 33                           on_2b   integer
#> 34                           on_1b   integer
#> 35                    outs_when_up   integer
#> 36                          inning   integer
#> 37                   inning_topbot character
#> 38                            hc_x    double
#> 39                            hc_y    double
#> 40                  tfs_deprecated   logical
#> 41             tfs_zulu_deprecated   logical
#> 42                       fielder_2   integer
#> 43                          umpire   logical
#> 44                           sv_id character
#> 45                             vx0    double
#> 46                             vy0    double
#> 47                             vz0    double
#> 48                              ax    double
#> 49                              ay    double
#> 50                              az    double
#> 51                          sz_top    double
#> 52                          sz_bot    double
#> 53                 hit_distance_sc   integer
#> 54                    launch_speed    double
#> 55                    launch_angle   integer
#> 56                 effective_speed    double
#> 57               release_spin_rate   integer
#> 58               release_extension    double
#> 59                         game_pk   integer
#> 60                         pitcher   integer
#> 61                       fielder_2   integer
#> 62                       fielder_3   integer
#> 63                       fielder_4   integer
#> 64                       fielder_5   integer
#> 65                       fielder_6   integer
#> 66                       fielder_7   integer
#> 67                       fielder_8   integer
#> 68                       fielder_9   integer
#> 69                   release_pos_y    double
#> 70   estimated_ba_using_speedangle    double
#> 71 estimated_woba_using_speedangle    double
#> 72                      woba_value    double
#> 73                      woba_denom   integer
#> 74                     babip_value   integer
#> 75                       iso_value   integer
#> 76              launch_speed_angle   integer
#> 77                   at_bat_number   integer
#> 78                    pitch_number   integer
#> 79                      pitch_name character
#> 80                      home_score   integer
#> 81                      away_score   integer
#> 82                       bat_score   integer
#> 83                       fld_score   integer
#> 84                 post_away_score   integer
#> 85                 post_home_score   integer
#> 86                  post_bat_score   integer
#> 87                  post_fld_score   integer
#> 88           if_fielding_alignment character
#> 89           of_fielding_alignment character
#> 90                       spin_axis   integer
#> 91              delta_home_win_exp    double
#> 92                   delta_run_exp    double
```
