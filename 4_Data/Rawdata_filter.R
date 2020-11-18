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

## read the total elapsed time
(tail(df$time_Passage_board,1)/1000)/60

## Inner join the approved participants' data
valid_rawdata <- inner_join(df, prolific_df, by = c("prolific_participant_id"="participant_id"))

## Replace error rt with NA
valid_rawdata[valid_rawdata$correct==0,]$response_time_Probe_response = NA

## read verb probe response by participant
verb_responses_df <- valid_rawdata %>% filter(!is.na(count_count_board)) %>% ## filter warm-up trials
    filter(probe_type == "v") %>%  ## isolate the verb probe responses
##    filter(correct == 1) %>%
    group_by(prolific_participant_id, Dimension, Foreshadow, Shift) %>%
    summarise(Verb_rt = mean(response_time_Probe_response,na.rm = TRUE),Verb_acc = mean(correct)) %>% 
    as.data.frame()



## read filler probe response by participant
filler_responses_df <- valid_rawdata %>% filter(!is.na(count_count_board)) %>% ## filter warm-up trials
    filter(probe_type == "f") %>%  ## isolate the filler probe responses
    group_by(prolific_participant_id, Dimension, Foreshadow, Shift) %>%
    summarise(filler_rt = mean(response_time_Probe_response,na.rm = TRUE),  filler_acc = mean(correct)) %>%
    as.data.frame()

## read comprehension trials by participant
Comprehension_datatable <- valid_rawdata %>% filter(!is.na(count_count_board)) %>% ## filter warm-up trials
    filter(probe_type == "q") %>%  ## isolate the comprehension trials
    group_by(prolific_participant_id, Dimension, Foreshadow, Shift) %>%
    summarise(test_acc = mean(correct)) %>%
    as.data.frame()
