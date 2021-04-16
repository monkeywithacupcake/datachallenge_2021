# download contract archives
# large files
# may take a long time
# recommend to do this and then to read from the csv on your machine as necessary

# source mydefaults.R
source("helpers/mydefaults.R")

# very large files, use caution!
for(i in seq(2010,2020)) {
  fname <- paste0("FY",i,"_archived_opportunities.csv")
  # do we already have it?
  if(!file.exists(paste0(data_dir, fname))) {
    df <- read_csv(paste0("https://beta.sam.gov/api/prod/fileextractservices/v1/api/download/Contract%20Opportunities/Archived%20Data/",fname))
    write_csv(df, paste0(data_dir, fname))
  }
}
