if(!require("googlesheets4")){install.packages("googlesheets4")}else{library("googlesheets4")}
library(tidyverse)
## import the data from google drive
PR2016_analytic_data <- read_sheet("https://docs.google.com/spreadsheets/d/1Ae-6mYXzx6-N5NVZqHRLxz00vh6AtorLWmDDbt-9eEY/edit?usp=sharing")
## Count unique IDs
PR2016_analytic_data$QualtricsID %>% unique() %>% length()
## Count the valid responses by conditions
reserved_ID <- PR2016_analytic_data %>% group_by(QualtricsID,Foreshadow, Shift) %>%
    summarise(items = n()) %>%
    group_by(QualtricsID) %>%
    summarise(responses_N = sum(items)) %>%
    filter(responses_N == 8) %>%
    pull(QualtricsID) ## Isolate the participants responded 8 stories

## According to the paper, Exp 3 employed 48 participants. 
## There are 64 valid participants' data in the data sheet.

## Reproduce the descriptive statistics of Table 5
PR2016_analytic_data %>% filter(QualtricsID %in% reserved_ID) %>%
    group_by(QualtricsID, Foreshadow, Shift) %>%
    summarise(C_RT = mean(ReadTime)) %>%
    group_by(Foreshadow, Shift) %>%
    summarise(N = n(), Mean = mean(C_RT), se = sd(C_RT)/sqrt(n()) )
