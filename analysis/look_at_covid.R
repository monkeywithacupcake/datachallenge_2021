# focus on covid

# source mydefaults.R
source("helpers/mydefaults.R")

# make sure the data are available
source("helpers/read_archives.R")

# let us read in 2020 data
fname <- paste0("FY",2020,"_archived_opportunities.csv")
df20 <- read_csv(paste0(data_dir, fname))

# experimentation with covid data

df20 <- df20 %>% mutate(pd = lubridate::date(PostedDate),
                                 ad = lubridate::date(AwardDate),
                                 mos = round(lubridate::time_length(as.numeric(ad-pd), unit="months"),0))

# handle encoding issue
df20$Title <- enc2utf8(df20$Title)
df20$Awardee <- enc2utf8(df20$Awardee)
df20 <- df20 %>%
  mutate(iscovid = grepl('covid', tolower(df20$Title)))
#df20[grepl('covid', tolower(df20$Title)), ]

table(df20$Type, df20$iscovid)

df20covid <- df20 %>%
  filter(iscovid == TRUE, Type == "Award Notice")

df20covid <- df20covid %>%
  mutate(awardee15 = substr(gsub("\x95 ","",toupper(Awardee)),1,15))

df20covid %>%
  group_by(awardee15, AwardNumber) %>%
  summarise(n = n(), .groups="drop")

df20covidawardeesum <- df20covid %>%
  group_by(awardee15, AwardNumber) %>%
  slice(which.max(PostedDate)) %>%
  summarise(dollars = sum(`Award$`), .groups="drop") %>%
  arrange(dollars) %>%
  mutate(dollars_group = cut_interval(dollars, 5))

#tmp <- df20covid %>% filter(awardee15 == "HAMILTON MEDICA") %>% select(NoticeId, Title, AwardNumber, AwardDate, `Award$`)
