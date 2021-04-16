# take a look at some data

# source mydefaults.R
source("helpers/mydefaults.R")

# look at 1970 and 2030 (first and last of archived opportunities)
# have to manually download each csv because of click boxes

co1970 <- read_csv(paste0(data_dir,"FY1970_archived_opportunities.csv"))
co2030 <- read_csv(paste0(data_dir,"FY2030_archived_opportunities.csv"))
co2016 <- read_csv(paste0(data_dir,"FY2016_archived_opportunities.csv"))
# very large file, use caution!
co2020 <- read_csv("https://beta.sam.gov/api/prod/fileextractservices/v1/api/download/Contract%20Opportunities/Archived%20Data/FY2020_archived_opportunities.csv")

library(dlookr)

diagnose(co1970) # 2/3 unique
diagnose(co2030) # weird only one
diagnose(co2016) # 46 % missing department?
diagnose(co2020)
# might be a read error.
