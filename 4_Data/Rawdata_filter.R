## Load the required package
library(tidyverse)
library(sylcount)
#if(!require(sylcount)){install.packages("sylcount");library(sylcount)}else{library(sylcount)}

## Switch to the raw data directory
setwd("4_Data/")

## define the path to the data file
csv_file <- dir(pattern=".csv")

## import the data file
df = read.csv(csv_file[1], encoding = "UTF-8")
head(df)

## import the prolific meta file
prolific_df = read.csv(csv_file[2], encoding = "UTF-8") %>%
    filter(status == "APPROVED")

## Inner join the approved participants' data
valid_rawdata <- inner_join(df, prolific_df, by = c("prolific_participant_id"="participant_id"))

## Export cleaned rawdata to 5_report
write.csv(valid_rawdata,file="../5_Report/cleaned_data.csv")



