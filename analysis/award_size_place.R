# take a look at some data

# source mydefaults.R
source("helpers/mydefaults.R")

# make sure the data are available
source("helpers/read_archives.R")

# look at 1970 and 2030 (first and last of archived opportunities)
# co1970 <- read_csv(paste0(data_dir,"FY1970_archived_opportunities.csv"))
# co2030 <- read_csv(paste0(data_dir,"FY2030_archived_opportunities.csv"))
# no dice

# let us read in all the ones between years
years <- seq(2017, 2020)
if(!exists("codata")){  # will only read in stuff if the list is empty
  codata <- list()      # create an empty list
  for(i in years) {     # for each year we put in years
    # construct the file name where it is (should match this if used read_arcives.R)
    fname <- paste0("FY",i,"_archived_opportunities.csv")
    codata[[i-min(years)+1]] <- read_csv(paste0(data_dir, fname)) # add to list
  }
  names(codata) <- paste0("co", years)  # name the list items
}

library(dlookr)
lapply(codata, function(x)dlookr::diagnose(x))

# what if we look at where the money is spent over time
#PopZip
#AwardDate
#Award$


df <- select(codata$co2017, PopZip, AwardDate, `Award$`) %>%
  bind_rows(select(codata$co2018, PopZip, AwardDate, `Award$`)) %>%
  bind_rows(select(codata$co2019, PopZip, AwardDate, `Award$`)) %>%
  mutate(`Award$` = as.double(gsub("[^0-9.-]","",`Award$`))) %>%
  bind_rows(select(codata$co2020, PopZip, AwardDate, `Award$`)) %>%
  mutate(PopZip = substr(as.character(gsub("[^0-9-]","",PopZip)), 1,5),
         ZipArea = substr(PopZip, 1,1),
         AwardDate = gsub("2190", "2019", AwardDate),
         AwardYear = lubridate::year(AwardDate)) %>%
         #AwardMonth = paste0(substr(AwardDate, 1, 7), "-01")) %>%
  filter(!is.na(AwardYear) & !is.na(PopZip) & !is.na(`Award$`)) %>%
  group_by(AwardYear, ZipArea) %>%
  summarize(Award = sum(`Award$`, na.rm=TRUE), .groups="drop")

ggplot(df, aes(x=AwardYear, y=ZipArea, size=Award, fill=ZipArea, color=ZipArea)) +
  geom_point(alpha=0.4) +
  theme_minimal() +
  theme(legend.position = "none")
#ggsave(paste0(discuss_dir,"AwardSize v Year and Zip.png"))



# end
