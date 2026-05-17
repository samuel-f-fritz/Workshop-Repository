## This code is an interactive simulation
## Intended to show the generative process for a zero-inflated distribution

## Call packages
library(tidyverse)

## Create master variables
P <- 0.5 # Set the binomial probability
Lambda <- 5## Lambda for rpois
n_total <- 500 ## total number of desired observations.

## Draw binomial probabilities
Zero_Sims <- data.frame(Binomial_hurdle = rbinom(n_total, 1, P))

## Now draw poisson only for the sucessful binomial trials
Zero_Sims$Count <- ifelse(Zero_Sims$Binomial_hurdle > 0, rpois(Zero_Sims$Binomial_hurdle, Lambda), 0)

## Now create a character for underlying process
Zero_Sims <- Zero_Sims %>%
  mutate(Type = case_when(
    Binomial_hurdle == 0 ~ "Extra Zero",
    Binomial_hurdle == 1 ~ "Poisson count"
  ))

## Graph it without color coding
ggplot(data = Zero_Sims, aes(x = Count))+
  geom_histogram()

## Graph with color coding
ggplot(data = Zero_Sims, aes(x = Count, fill = Type))+
  geom_histogram()
fill()