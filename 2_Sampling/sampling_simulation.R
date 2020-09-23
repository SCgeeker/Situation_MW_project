## Import packages for simulation
if(!require("Superpower")){
    devtools::install_github("arcaldwell49/Superpower")    
} else {
    library("Superpower")
}

library(tidyverse)

## Insert the labelnames into ANOVA_design, return error messages
## Error in mvrnorm(n = n, mu = mu, Sigma = sigmatrix, empirical = FALSE) : 
## 'Sigma' is not positive definite
labelnames = c("Foreshadow",
               "No",
               "Yes",
               "Shift",
               "No_shift",
               "Shift")

## Replication of (Pettijohn & Radvansky, 2016)
### Reading times from Table 5
## Reading time/syllable(ms)

## Save the exact power of simulation data into the list
power_sim_reading_time <- list()

## Compute the exact powers of foreshadow, shift, and interaction by the correlations of variables
for( r in c(0.5,0.6,0.7,0.8,0.9)){
    power_sim_reading_time[[length(power_sim_reading_time)+1]] <- (ANOVA_design(design = "2w*2w",
                  n = 32,   ## Sample size 
                  mu = c(149, 162, 148, 147),  ## Means per condition
                  sd = c(14, 14, 12, 12),  ## standard error per condition
                  r = r, ## settings of correlation
                  plot = FALSE) %>%   ## supress the output of plot
         ANOVA_exact())$main_results$power
}

## List the powers of foreshadow, shift, and interaction
power_sim_reading_time

## Response time(ms)

## Save the exact power of simulation data into the list
power_sim_response_time <- list()

## Compute the exact powers of foreshadow, shift, and interaction by the correlations of variables
for( r in c(0.5,0.6,0.7,0.8,0.9)){
    power_sim_response_time[[length(power_sim_response_time)+1]] <- (ANOVA_design(design = "2w*2w",
                                                               n = 32,   ## Sample size 
                                                               mu = c(2853,3012,2894,3099),  ## Means per condition
                                                               sd = c(120,142,166,148),  ## standard error per condition
                                                               r = r, ## settings of correlation
                                                               plot = FALSE) %>%   ## supress the output of plot
                                ANOVA_exact())$main_results$power
}

## List the powers of foreshadow, shift, and interaction
power_sim_response_time


## Accuracy

## Save the exact power of simulation data into the list
power_sim_accuracy <- list()

## Compute the exact powers of foreshadow, shift, and interaction by the correlations of variables
for( r in c(0.5,0.6,0.7,0.8,0.9)){
    power_sim_accuracy[[length(power_sim_accuracy)+1]] <- (ANOVA_design(design = "2w*2w",
                                                                        n = 32,   ## Sample size 
                                                                        mu = c(0.836,0.801,0.801,0.781),  ## Means per condition
                                                                        sd = c(0.03,0.03,0.03,0.03),  ## standard error per condition
                                                                        r = r, ## settings of correlation
                                                                        plot = FALSE) %>%   ## supress the output of plot
                                                           ANOVA_exact())$main_results$power
}

## List the powers of foreshadow, shift, and interaction
power_sim_accuracy

## Summary
## 32 participants would be reasonable sample size if we do not concern the interaction of foreshadow and shift.
## Main effects of foreshadow and shift reached 100% power while r > 0.5
## Power of interaction have the different estimations based on response time and accuracy
## Accuracy showed a reliable estimation if we had .80 correlation
## Mind wandering study would be up to the estimation based on Accuracy data
