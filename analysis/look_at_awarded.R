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

table(awards[[1]]$action_date_fiscal_year)
#2001   2002   2003   2004   2005   2006   2007   2008   2009   2010   2011   2012   2013   2014   2015   2016
#116  33353  45399  41615   1702  31337  47568  45632  37075  42706  25149  29787  11430  19148  38841   4071
#2017   2018   2019   2020   2021
#5681   8079  31909  48901 450501

awards <- lapply(awards, function(x) filter(x, action_date_fiscal_year > 2009 & action_date_fiscal_year < 2021))

# based on this question
# https://usaspending-help.zendesk.com/hc/en-us/community/posts/360024930953-How-to-aggregate-contract-award-data
# spending field is federal_action_obligation
