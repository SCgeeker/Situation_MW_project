---
title: "Raw data processing"
author: "Sau-Chin Chen"
date: "2020/11/12"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

### Data sets 

- 2020 Nov First replication of Pettijohn and Radvansky (2016)
> `jatos_results_20201113143306.txt`, `jatos_results_20201115223512.csv`

- 2020 Dec Second replication of Pettijohn and Radvansky (2016)
> `jatos_results_20201209202930.csv`, `jatos_results_20201209202930.txt`

### Pre-processing workflow

1. Export data file (.json) from JATOS server.

![](./img/00.jpg)

2. Save the data file (.json) in `4_Data`.

![](./img/01.jpg)

3. Transfer the format of data file in OpenSesame.

![](./img/02.jpg)

4. Make sure the data file format is .csv.

![](./img/03.jpg)

5. Run `Rawdata_filter.R`. This scirpt will export the cleaned raw data and the valid participant ID.

![](./img/06.png)

6. Paste the id to Prolific dashboard and export the participants meta data.

<!---
5. Run `read_OS_output.R` and retrieve the participant id(s) who complete the study.

![](./img/04.jpg)

6. Paste the id to Prolific dashboard and export the participants meta data.

![](./img/05.png)

7. Run `Rawdata_filter.R` and export the valid rawdata for the analysis.

![](./img/06.png)
--->