# download individual people datasets from chadwickbureau/register
data = list(
  p0 = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-0.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  p1 = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-1.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  p2 = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-2.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  p3 = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-3.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  p4 = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-4.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  p5 = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-5.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  p6 = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-6.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  p7 = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-7.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  p8 = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-8.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  p9 = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-9.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  pa = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-a.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  pb = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-b.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  pc = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-c.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  pd = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-d.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  pe = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-e.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE),
  pf = data.table::fread("https://raw.githubusercontent.com/chadwickbureau/register/master/data/people-f.csv", data.table = FALSE, verbose = FALSE, showProgress = FALSE)
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
