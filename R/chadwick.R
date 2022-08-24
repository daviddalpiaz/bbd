chadwick_people = function(tibble = TRUE) {
  url = "https://raw.githubusercontent.com/chadwickbureau/register/master/data/people.csv"
  data = data.table::fread(url, data.table = FALSE, verbose = FALSE, showProgress = FALSE)
  vars = c(
    "key_person",
    "key_uuid",
    "key_mlbam",
    "key_retro",
    "key_bbref",
    "key_bbref_minors",
    "key_fangraphs",
    "key_npb",
    "name_last",
    "name_first",
    "name_suffix"
  )
  data = data[, vars]

  data = data[!is.na(data$key_mlbam), ]

  names = paste(data$name_first, data$name_last)
  names = paste0(names, ifelse(data$name_suffix == "", "", paste0(" ", data$name_suffix)))
  data$name_first = NULL
  data$name_last = NULL
  data$name_suffix = NULL

  data = data.frame(name = names, data)

  if (tibble) {
    return(tibble::as_tibble(data))
  }

  return(data)
}
