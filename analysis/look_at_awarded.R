# take a look at awards data
# source: https://www.usaspending.gov/download_center/award_data_archive
# i downloaded the zip all one, 8.2GB

# source mydefaults.R
source("helpers/mydefaults.R")

# let us read in all the ones between years

if(!exists("awards")){  # will only read in stuff if the list is empty
  awards <- list()      # create an empty list
  for(i in seq(1,4)) {     # for each year we put in years
    # construct the file name where it is (should match this if used read_arcives.R)
    fname <- paste0("FY(All)_All_Contracts_Delta_20210407/FY(All)_All_Contracts_Delta_20210407_",i,".csv")
    awards[[i]] <- read_csv(paste0(data_dir, fname)) # add to list
  }
}
# table 1 is many awarding agencies
# table 2,3,4 is only DOD
# only table 1 has solicitation dates

table(awards[[1]]$action_date_fiscal_year)
#2001   2002   2003   2004   2005   2006   2007   2008   2009   2010   2011   2012   2013   2014   2015   2016
#116  33353  45399  41615   1702  31337  47568  45632  37075  42706  25149  29787  11430  19148  38841   4071
#2017   2018   2019   2020   2021
#5681   8079  31909  48901 450501


awards <- lapply(awards, function(x) filter(x, action_date_fiscal_year > 2009 & action_date_fiscal_year < 2021))

table(awards[[1]]$action_date_fiscal_year, lubridate::month(awards[[1]]$solicitation_date))

# 1    2    3    4    5    6    7    8    9   10   11   12
# 2010    0    0    0    0    0    0    0    0    0    0    0    0
# 2011    0    0    0    0    0    0    0    0    0    0    0    0
# 2012    0    0    0    0    0    0    0    1    0    0    0    0
# 2013    0    0    0    0    0    0    0    0    0    0    0    0
# 2014    0    0    0    0    0    0    0    0    0    0    0    0
# 2015    0    0    0    0    0    0    0    0    0    0    0    0
# 2016    0    0    3    0    0    0    1    0    0    0    0    0
# 2017    1    0    0    1    1    0    1    0    0    4    0    1
# 2018    1    1    1    6   16    9   11    8    5    0    5    0
# 2019   23   19   43   64   78 1627  105  111  102    6   18    7
# 2020 2841  300  205  395  239  283  312  538 2497  147  351 1444

# based on this question
# https://usaspending-help.zendesk.com/hc/en-us/community/posts/360024930953-How-to-aggregate-contract-award-data
# spending field is federal_action_obligation
