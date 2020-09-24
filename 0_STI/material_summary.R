## import tidyverse and fetch readxl
library(tidyverse)
library(afex)

## check the sheets in the file
materials_sheets <- readxl::excel_sheets("Exp3 materials.xlsx")

## Load and merge the data sheets
materials_table <- readxl::read_excel("Exp3 materials.xlsx", sheet = materials_sheets[1]) %>%
    bind_rows( readxl::read_excel("Exp3 materials.xlsx", sheet = materials_sheets[3]) ) %>%
    bind_rows( readxl::read_excel("Exp3 materials.xlsx", sheet = materials_sheets[5]) ) %>%
    bind_rows( readxl::read_excel("Exp3 materials.xlsx", sheet = materials_sheets[7]) ) %>%
    bind_rows( readxl::read_excel("Exp3 materials.xlsx", sheet = materials_sheets[9]) )


## Summarize the word counts of each text
passages_words_N <- materials_table %>% filter(probe == "n") %>%
    group_by(Dimension, Foreshadow, Shift, passage) %>%
    summarise(words_N = sum(word_counts))

## Clean data table for summarize the reading ease score
materials_table_tidy <- subset(materials_table, !is.na(`Flesch Kincaid Reading Ease`))

## Summarize the reading ease scores of each text
materials_sum <- materials_table_tidy %>% group_by(Dimension, Foreshadow, Shift) %>%
    summarise(ease_score = mean(`Flesch Kincaid Reading Ease`),
              ease_grade = mean(`Flesch Kincaid Grade Level`),
              sentences_N = mean(`No. of sentences`),
              words_N = mean(`No. of words`))

## Verify the materials summary
materials_sum %>% data.frame()
passages_words_N %>% group_by(Dimension, Foreshadow, Shift) %>%
    summarise(mean(words_N))

## Analyze the differences among IVs
materials_table_analysis <- materials_table_tidy %>% filter(Dimension != "Filler") %>% select(Dimension, passage) %>% unite("id",Dimension:passage) %>% 
    bind_cols(materials_table_tidy %>% filter(Dimension != "Filler"))

### About "Flesch Kincaid Reading Ease"
aov_ez("id","Flesch Kincaid Reading Ease", materials_table_analysis, between=c("Dimension"), within = c("Foreshadow", "Shift"))
### About "Flesch Kincaid Reading Grade"
aov_ez("id","Flesch Kincaid Grade Level", materials_table_analysis, between=c("Dimension"), within = c( "Foreshadow", "Shift"))
### About "No. of sentences"
aov_ez("id","No. of sentences", materials_table_analysis, between=c("Dimension"), within = c( "Foreshadow", "Shift"))
### About "No. of words"
aov_ez("id","No. of words", materials_table_analysis, between=c("Dimension"), within = c( "Foreshadow", "Shift"))
