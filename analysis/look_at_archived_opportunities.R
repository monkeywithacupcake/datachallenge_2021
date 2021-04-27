# what in opportunities

# the purpose of this file is just to get familiar with opportunities data

# source mydefaults.R
source("helpers/mydefaults.R")

# make sure the data are available
source("helpers/read_archives.R")

# let us read in all the ones between years
years <- seq(2015, 2020)
if(!exists("codata")){  # will only read in stuff if the list is empty
  codata <- list()      # create an empty list
  for(i in years) {     # for each year we put in years
    # construct the file name where it is (should match this if used read_arcives.R)
    fname <- paste0("FY",i,"_archived_opportunities.csv")
    codata[[i-min(years)+1]] <- read_csv(paste0(data_dir, fname)) # add to list
  }
  names(codata) <- paste0("co", years)  # name the list items
}

df <- codata$co2015 %>% mutate(pd = lubridate::date(PostedDate),
                               ad = lubridate::date(AwardDate),
                               mos = round(lubridate::time_length(as.numeric(ad-pd), unit="months"),0))

table(df$Type, df$mos, exclude = NULL) # this shows the ones not awarded

# 0   <NA>
#   Award Notice                                      83606     56
# Combined Synopsis/Solicitation                        0 128701
# Fair Opportunity / Limited Sources Justification   1456     16
# Foreign Government Standard                           0      1
# Intent to Bundle Requirements                         0      2
# Justification and Approval (J&A)                   9035    340
# Modification/Amendment/Cancel                         0     45
# Presolicitation                                       0  84269
# Sale of Surplus Property                              0    163
# Solicitation                                          0  23202
# Sources Sought                                        0  29080
# Special Notice                                        0  16821
# <NA>                                                  0    249

# note that this shows that the data include things not awarded and awarded
# key info is that not every row is the same kind of thing, repeats must exist
n_distinct(df$`Sol#`)
# [1] 186905
nrow(df)
# [1] 377042

df %>% group_by(`Department/Ind.Agency`, `Sol#`) %>%
  summarize(entries = n(),
            awards = n_distinct(AwardNumber))

# I think this is showing things that are awarded this year but might have been
# put out earlier
# create a test
df$datayear <- 2015
df2 <- codata$co2016 %>% mutate(pd = lubridate::date(PostedDate),
                               ad = lubridate::date(AwardDate),
                               mos = round(lubridate::time_length(as.numeric(ad-pd), unit="months"),0),
                               datayear = 2016)
df3 <- bind_rows(df, df2)

test <- df3 %>% group_by(`Department/Ind.Agency`, `Sol#`) %>%
  summarize(entries = n(),
            awards = n_distinct(AwardNumber),
            years = n_distinct(datayear), .groups="drop") %>%
  filter(years > 1)

nrow(test)
# [1] 12051

# could probably do the whole time series if we filtered codata first and then collapse
# to just one department
# then we would be able to tell what happens to each solicitation
