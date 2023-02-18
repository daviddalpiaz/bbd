# create URLs for relevant files in chadwickbureau/register
chadwick_urls = paste0(
  "https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-",
  c(0:9, letters[1:6]),
  ".csv"
)

# download individual people datasets from chadwickbureau/register
data = lapply(
  chadwick_urls,
  data.table::fread,
  data.table = FALSE,
  verbose = FALSE,
  showProgress = FALSE
)

# combine people datasets
data = as.data.frame(data.table::rbindlist(data))

# remove non-MLB people
data = data[!is.na(data$key_mlbam), ]

# create "full" names
names = paste(data$name_first, data$name_last)

# deal with name suffixes
names = paste0(names, ifelse(data$name_suffix == "", "", paste0(" ", data$name_suffix)))

# add "full" name to dataset
people = data.frame(name = names, data)

# subset to name and keys currently used in package
# TODO: create download and lookup functions to help users re-create "full" people data
people = people[, c("name", "birth_year", "key_mlbam", "key_bbref", "key_fangraphs")]

# add table classes
class(people) = c("tbl_df", "tbl", "data.table", "data.frame")

# add to package
usethis::use_data(people, overwrite = TRUE, version = 3)
