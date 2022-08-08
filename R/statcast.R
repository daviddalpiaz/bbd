#' Download all Statcast data for a given date
#'
#' @param date A date
#' @param verbose Controls messaging to user
#'
#' @return A `data.table`
#' @export
get_statcast_day = function(date = Sys.Date() - 1, verbose = FALSE) {

  # TODO: defend against invalid dates

  if (verbose) {
    message(paste0("Obtaining data for games on ", date, "."))
  }

  url = paste0(
    "https://baseballsavant.mlb.com/statcast_search/csv?all=true&game_date_gt=",
    date,
    "&type=details"
  )

  return(data.table::fread(url, showProgress = FALSE))

}

#' Download all Statcast data within a range of dates
#'
#' @param start Start date of search
#' @param end End data of search
#' @param ... Additional arguments passed to `get_statcast_day`
#'
#' @return A `data.table`
#' @export
get_statcast = function(start = Sys.Date() - 8, end = Sys.Date() - 1, ...) {

  # TODO: defend against invalid dates

  start = as.Date(start)
  end   = as.Date(end)
  dates = seq(from = start, to = end, by = "day")

  statcast_data = lapply(dates, get_statcast_day, ...)
  # TODO: change to vapply
  statcast_data = statcast_data[sapply(statcast_data, check_nonempty_df)]

  return(data.table::rbindlist(statcast_data))

}
