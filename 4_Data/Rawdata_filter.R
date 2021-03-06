## Load the required package
library(tidyverse)
library(sylcount)
#if(!require(sylcount)){install.packages("sylcount");library(sylcount)}else{library(sylcount)}

## Switch to the raw data directory
## Change the directory by the data set to be analyzed
setwd("4_Data/Second_replication_2020Dec/")

## define the path to the data file
csv_file <- dir(pattern=".csv")

## import the data file
rawdata_df = read.csv(csv_file[1], encoding = "UTF-8") %>%
    ### select the variables for the analysis only
    select(prolific_participant_id,story_count,probe,probe_type,line,line_text,count_Question_board,Dimension, Foreshadow, Shift, Post_Topic, response, correct, response_time)
## Preview the rawdata set
head(rawdata_df)
tail(rawdata_df)

## import the prolific meta file
prolific_df = read.csv(csv_file[2], encoding = "UTF-8") %>%
    filter(status == "AWAITING REVIEW") %>%
    select(participant_id, age, Sex, First.Language, Fluent.languages)

## Inner join the approved participants' data
valid_rawdata <- inner_join(rawdata_df, 
                            prolific_df, 
                            by = c("prolific_participant_id"="participant_id"))

## Retrieve the valid participant ID
## Copy the ID to Prolific dashboard
valid_rawdata %>% pull(prolific_participant_id) %>% unique() %>% writeClipboard()

## Export cleaned rawdata to 4_data
write.csv(valid_rawdata,file="cleaned_raw_data.csv")



