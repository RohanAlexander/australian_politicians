#### Preamble ####
# Purpose: 
# Author: Rohan Alexander
# Email: rohan.alexander@utoronto.ca
# Last updated: 
# Prerequisites:
# Misc:


#### Set up workspace ####
library(tidyverse)


debris <- read_csv(file = "inputs/fix_me.csv")

debris <- 
  debris %>% 
  select(number, person, from, to) %>% 
  distinct()
  

debris <- 
  debris %>% 
  select(number, person, from, to) %>% 
  mutate(counter = 1:nrow(debris)) %>% 
  group_by(number, person) %>% 
  summarise(from = first(from), 
            to = last(to), 
            person = person,
            counter = counter) %>% 
  ungroup() %>% 
  arrange(counter) %>% 
  select(-counter) %>% 
  distinct() 


write_csv(x = debris, file = "intermediates/debris.csv")