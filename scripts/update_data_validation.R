# COVID-19 Canada Open Data Working Group Data Update Validation Script #
# Author: Jean-Paul R. Soucy #

# Compare updated data files (from update_data.R) to the current version in the GitHub repository
# GitHub repository: https://github.com/ishaberry/Covid19Canada

# Note: This script assumes the working directory is set to the root directory of the project
# This is most easily achieved by using the provided Covid19Canada.Rproj in RStudio

# load libraries
library(dplyr) # data manipulation
library(stringr) # manipulate strings
library(compareDF) # compare data frames
library(crayon) # colourful output in console

# load functions
source("scripts/update_data_validation_funs.R")

# download current data from GitHub repository
download_current_data()

# load new data
load_new_data()

# convert all dates to ISO 8601
convert_dates()

# stop running script if old update time and new update time are the same
if (identical(old_update_time, update_time)) stop("Update times for old and new data are the same.")

## print today's cumulative numbers and daily changes
print_cumulative_today()

## check validity of health names in individual-level case and mortality data
check_hr("cases")
check_hr("mortality")

## check ages in individual-level case data
check_ages_cases()

## check Canadian time series
ts_canada()

## check provincial time series
ts_prov()

## check health region time series
ts_hr()