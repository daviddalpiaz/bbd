
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bbd

<!-- badges: start -->

[![R-CMD-check](https://github.com/daviddalpiaz/bbd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/daviddalpiaz/bbd/actions)
<!-- badges: end -->

The `bbd` package is a [lightweight package](https://www.tinyverse.org/)
that contains functions to facilitate the collection of **b**ase**b**all
**d**ata from various sources online. **This package is currently
experimental.** All function interfaces are liable to change without
notice.

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

The most basic usage of `bbd` is collecting [Statcast
data](https://baseballsavant.mlb.com/statcast_search) for all games
played between two dates, inclusive.

``` r
library(bbd)
ws_2022 = statcast(start = "2022-10-28", end = "2022-11-05")
```

### Statcast Variables

By default, `bbd` attempts to be un-opinionated, and thus returns a data
frame containing the exact variables (to the extent possible) returned
by the Statcast API. Notice that `pitcher` and `fielder_2` variables are
duplicated.

| Variable Name                   | Variable Type |
|:--------------------------------|:--------------|
| pitch_type                      | character     |
| game_date                       | double        |
| release_speed                   | double        |
| release_pos_x                   | double        |
| release_pos_z                   | double        |
| player_name                     | character     |
| batter                          | integer       |
| pitcher                         | integer       |
| events                          | character     |
| description                     | character     |
| spin_dir                        | logical       |
| spin_rate_deprecated            | logical       |
| break_angle_deprecated          | logical       |
| break_length_deprecated         | logical       |
| zone                            | integer       |
| des                             | character     |
| game_type                       | character     |
| stand                           | character     |
| p_throws                        | character     |
| home_team                       | character     |
| away_team                       | character     |
| type                            | character     |
| hit_location                    | integer       |
| bb_type                         | character     |
| balls                           | integer       |
| strikes                         | integer       |
| game_year                       | integer       |
| pfx_x                           | double        |
| pfx_z                           | double        |
| plate_x                         | double        |
| plate_z                         | double        |
| on_3b                           | integer       |
| on_2b                           | integer       |
| on_1b                           | integer       |
| outs_when_up                    | integer       |
| inning                          | integer       |
| inning_topbot                   | character     |
| hc_x                            | double        |
| hc_y                            | double        |
| tfs_deprecated                  | logical       |
| tfs_zulu_deprecated             | logical       |
| fielder_2                       | integer       |
| umpire                          | logical       |
| sv_id                           | character     |
| vx0                             | double        |
| vy0                             | double        |
| vz0                             | double        |
| ax                              | double        |
| ay                              | double        |
| az                              | double        |
| sz_top                          | double        |
| sz_bot                          | double        |
| hit_distance_sc                 | integer       |
| launch_speed                    | double        |
| launch_angle                    | integer       |
| effective_speed                 | double        |
| release_spin_rate               | integer       |
| release_extension               | double        |
| game_pk                         | integer       |
| pitcher                         | integer       |
| fielder_2                       | integer       |
| fielder_3                       | integer       |
| fielder_4                       | integer       |
| fielder_5                       | integer       |
| fielder_6                       | integer       |
| fielder_7                       | integer       |
| fielder_8                       | integer       |
| fielder_9                       | integer       |
| release_pos_y                   | double        |
| estimated_ba_using_speedangle   | double        |
| estimated_woba_using_speedangle | double        |
| woba_value                      | double        |
| woba_denom                      | integer       |
| babip_value                     | integer       |
| iso_value                       | integer       |
| launch_speed_angle              | integer       |
| at_bat_number                   | integer       |
| pitch_number                    | integer       |
| pitch_name                      | character     |
| home_score                      | integer       |
| away_score                      | integer       |
| bat_score                       | integer       |
| fld_score                       | integer       |
| post_away_score                 | integer       |
| post_home_score                 | integer       |
| post_bat_score                  | integer       |
| post_fld_score                  | integer       |
| if_fielding_alignment           | character     |
| of_fielding_alignment           | character     |
| spin_axis                       | integer       |
| delta_home_win_exp              | double        |
| delta_run_exp                   | double        |

The `statcast()` function provides arguments that allow for some
opinionated processing. Check the documentation for details of this
processing. Most importantly, functionality to obtain both batter *and*
pitcher names is included.

``` r
ws_2022_processed = statcast(
  start = "2022-10-28",
  end = "2022-11-05",
  process = TRUE,
  names = TRUE
)
```

| Variable Name                   | Variable Type |
|:--------------------------------|:--------------|
| pitch_type                      | character     |
| game_date                       | double        |
| release_speed                   | double        |
| release_pos_x                   | double        |
| release_pos_z                   | double        |
| player_name                     | character     |
| batter                          | integer       |
| pitcher                         | integer       |
| events                          | character     |
| description                     | character     |
| spin_dir                        | logical       |
| spin_rate_deprecated            | logical       |
| break_angle_deprecated          | logical       |
| break_length_deprecated         | logical       |
| zone                            | integer       |
| des                             | character     |
| game_type                       | character     |
| stand                           | character     |
| p_throws                        | character     |
| home_team                       | character     |
| away_team                       | character     |
| type                            | character     |
| hit_location                    | integer       |
| bb_type                         | character     |
| balls                           | integer       |
| strikes                         | integer       |
| game_year                       | integer       |
| pfx_x                           | double        |
| pfx_z                           | double        |
| plate_x                         | double        |
| plate_z                         | double        |
| on_3b                           | integer       |
| on_2b                           | integer       |
| on_1b                           | integer       |
| outs_when_up                    | integer       |
| inning                          | integer       |
| inning_topbot                   | character     |
| hc_x                            | double        |
| hc_y                            | double        |
| tfs_deprecated                  | logical       |
| tfs_zulu_deprecated             | logical       |
| fielder_2                       | integer       |
| umpire                          | logical       |
| sv_id                           | character     |
| vx0                             | double        |
| vy0                             | double        |
| vz0                             | double        |
| ax                              | double        |
| ay                              | double        |
| az                              | double        |
| sz_top                          | double        |
| sz_bot                          | double        |
| hit_distance_sc                 | integer       |
| launch_speed                    | double        |
| launch_angle                    | integer       |
| effective_speed                 | double        |
| release_spin_rate               | integer       |
| release_extension               | double        |
| game_pk                         | integer       |
| pitcher                         | integer       |
| fielder_2                       | integer       |
| fielder_3                       | integer       |
| fielder_4                       | integer       |
| fielder_5                       | integer       |
| fielder_6                       | integer       |
| fielder_7                       | integer       |
| fielder_8                       | integer       |
| fielder_9                       | integer       |
| release_pos_y                   | double        |
| estimated_ba_using_speedangle   | double        |
| estimated_woba_using_speedangle | double        |
| woba_value                      | double        |
| woba_denom                      | integer       |
| babip_value                     | integer       |
| iso_value                       | integer       |
| launch_speed_angle              | integer       |
| at_bat_number                   | integer       |
| pitch_number                    | integer       |
| pitch_name                      | character     |
| home_score                      | integer       |
| away_score                      | integer       |
| bat_score                       | integer       |
| fld_score                       | integer       |
| post_away_score                 | integer       |
| post_home_score                 | integer       |
| post_bat_score                  | integer       |
| post_fld_score                  | integer       |
| if_fielding_alignment           | character     |
| of_fielding_alignment           | character     |
| spin_axis                       | integer       |
| delta_home_win_exp              | double        |
| delta_run_exp                   | double        |

This functionality is also provided by the opinionated `statcast_bbd()`
function for convenience. Use `?statcast` for details.
