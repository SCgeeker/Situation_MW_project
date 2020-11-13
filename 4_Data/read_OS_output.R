## Load the required package
library(tidyverse)
library(sylcount)
#if(!require(sylcount)){install.packages("sylcount");library(sylcount)}else{library(sylcount)}

## define the path to the data file
csv_file <- dir(pattern=".csv")

## import the data file
df = read.csv(csv_file, encoding = "UTF-8")
head(df)

## read the total elapsed time
(tail(df$time_Passage_board,1)/1000)/60

## read verb probe response by participant
df %>% filter(!is.na(count_count_board)) %>% ## filter warm-up trials
    filter(probe_type == "v") %>%  ## isolate the verb probe responses
    filter(correct == 1) %>%
    group_by(prolific_participant_id, Dimension, Foreshadow, Shift) %>%
    summarise(Verb_rt = mean(response_time_Probe_response), Verb_acc = sum(correct)) %>% 
    as.data.frame()

## read filler probe response by participant
df %>% filter(!is.na(count_count_board)) %>% ## filter warm-up trials
    filter(probe_type == "f") %>%  ## isolate the filler probe responses
    group_by(prolific_participant_id, Dimension, Foreshadow, Shift) %>%
    summarise(filler_rt = mean(response_time_Probe_response),  filler_acc = sum(correct)) %>%
    as.data.frame()

## read comprehension trials by participant
df %>% filter(!is.na(count_count_board)) %>% ## filter warm-up trials
    filter(probe_type == "q") %>%  ## isolate the comprehension trials
    group_by(prolific_participant_id, Dimension, Foreshadow, Shift) %>%
    summarise(test_acc = mean(correct))

## Add syllable counts to the data frame
df = bind_cols(df, syl_n = (df$line_text %>% readability(nthreads = 1))$sylls )
## Summarize syllable reading times by participant
df %>% filter(!is.na(count_count_board)) %>% ## filter warm-up trials
    filter(probe_type == "n") %>%  ## isolate the text sentences
    filter(Dimension != "Filler") %>%  ## filter the filler stories
    mutate(syl_rt = response_time_Passage_response/syl_n) %>%
    group_by(prolific_participant_id, Dimension, Foreshadow, Shift,passage) %>%
    summarise(reading_rt = mean(syl_rt)) %>%
    as.data.frame()

## Retrieve post study survey data
subset(df, !is.na(count_post_study_trial)) %>% select(prolific_participant_id, Post_Topic, response)
