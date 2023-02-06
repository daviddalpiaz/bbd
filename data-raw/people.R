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

# define variables of interest, mostly keys and names
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

# subset to variables of interest
data = data[, vars]

# remove non-MLB people
data = data[!is.na(data$key_mlbam), ]

# create "full" names
names = paste(data$name_first, data$name_last)

# deal with name suffixes
names = paste0(names, ifelse(data$name_suffix == "", "", paste0(" ", data$name_suffix)))

# remove name subparts
data$name_first = NULL
data$name_last = NULL
data$name_suffix = NULL

# add "full" name to dataset
people = data.frame(name = names, data)

# add to package
usethis::use_data(people, overwrite = TRUE, version = 3)
