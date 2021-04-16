# mydefaults.R

# this file holds default setup so that everything works consistently between users and systems.
# source defaults.R at the beginning of each R file

#--------------------------------------------
# packages
library(tidyverse)

#--------------------------------------------
# options
options(scipen = 999)  # avoid scientific notation
options(encoding = "UTF-8")

#--------------------------------------------
# paths  - declared here in case they are moved so we don't have to update all code
helpers_dir <- "helpers/"
outputs_dir <- "outputs/"
data_dir <- "data/"
analysis_dir <- "analysis/"

#--------------------------------------------
# static vars
challenge_path <- "https://beta.sam.gov/data-services"
# links look like
# https://beta.sam.gov/api/prod/fileextractservices/v1/api/download/Contract%20Opportunities/Archived%20Data/FY2020_archived_opportunities.csv

#--------------------------------------------
# simple functions
`%ni%` <- Negate(`%in%`)  # a not in function for quick filtering
