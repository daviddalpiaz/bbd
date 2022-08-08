# TODO: document
get_statcast_day = function(date = Sys.Date() - 1, verbose = FALSE) {

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
