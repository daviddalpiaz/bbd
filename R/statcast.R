#' Download Statcast data within a range of dates
#'
#' @param start Start date of search.
#' @param end End data of search. Defaults to `NULL`, which stops search at `start` date.
#' @param batter Statcast player ID for batter of interest. Defaults to `NULL`.
#' @param pitcher Statcast player ID for pitcher of interest. Defaults to `NULL`.
#' @param process Controls processing of data. Defaults to `FALSE`. If `TRUE`,
#' data is processed using the [statcast_min_process()] function.
#' @param names Controls processing of names. Defaults to `FALSE`. If `TRUE`,
#' names are processed using the [statcast_add_names()] function.
#' @param verbose Controls messaging to the user. Defaults to `FALSE` which
#' provides no message. When `TRUE`, informs user when each `date` begins
#' downloading.
#'
#' @return An object with class [table_class()] containing all Statcast events
#' between the `start` date and `end` date inclusive.
#' @export
statcast = function(start = Sys.Date() - 1,
                    end = NULL,
                    batter = NULL,
                    pitcher = NULL,
                    process = FALSE,
                    names = FALSE,
                    verbose = FALSE) {

  # internal function to retrieve statcast data for single day
  statcast_day = function(date, batter, pitcher, verbose) {
    if (verbose) {
      message(paste0("Obtaining data for games on ", date, "."))
    }
    url = statcast_make_url(date = date, batter = batter, pitcher = pitcher)
    data = data.table::fread(
      url,
      showProgress = FALSE,
      data.table = FALSE,
      colClasses = statcast_get_colclasses(),
      na.strings = ""
    )
    return(data)
  }

  # setup date information
  if (is.null(end)) {
    end = start
  }
  start = make_date(start)
  end   = make_date(end)
  if (is.na(start) | length(start) != 1) {
    stop("start must be a length one character vector containing a date formatted as YYYY-MM-DD")
  }
  if (is.na(end) | length(end) != 1) {
    stop("end must be a length one character vector containing a date formatted as YYYY-MM-DD")
  }
  dates = seq(from = start, to = end, by = "day")

  # retrieve data for supplied dates
  data = lapply(
    dates,
    statcast_day,
    batter = batter,
    pitcher = pitcher,
    verbose = verbose
  )

  # remove days without games then combine all days into one table
  # data = data[vapply(data, nonempty_df, logical(1))]
  data = data.table::rbindlist(data)

  # apply processing and names
  if (process) {
    data = statcast_min_process(data = data)
  }
  if (!process && names) {
    warning("Currently, names can only be used for data processed with
            statcast_min_process(). No names will be added.")
  }
  if (process && names) {
    data = statcast_add_names(data = data)
  }

  # add table classes and return data
  class(data) = table_class()
  return(data)

}

#' @rdname statcast
#' @export
statcast_bbd = function(start = Sys.Date() - 1, end = NULL, verbose = FALSE) {
  statcast(
    start = start,
    end = end,
    batter = NULL,
    pitcher = NULL,
    process = TRUE,
    names = TRUE,
    verbose = verbose
  )
}
