#### Preamble ####
# Purpose: We need to add a flag for whether a minister was in cabinet.
# Date: 19 November 2020
# Contact: Rohan Alexander
# Email: rohan.alexander@utoronto.ca
# License: MIT
# Todo: Change the start date for Bob Carr to from 13 March 2012. See inputs/ministry_lists/2012-03-05-2012-10-28.html


#### Setup ####
library(lubridate)
library(tidyverse)

# Load the data
new_ministries <- read_csv("intermediates/recent_ministries.csv")
existing_ministries <- read_csv("outputs/australian_politicians-ministries.csv", guess_max = 2500)


#### Parse data ####
new_ministries <- 
  new_ministries %>% 
  # slice(1726:nrow(new_ministries)) %>% 
  separate(col = date, into = c("from", "to"), sep = " - ") %>% 
  mutate(from = dmy(from),
         to = dmy(to))

# The issue is that each job is repeated even if the person didn't change.
# Thanks https://stackoverflow.com/questions/49343891/for-each-id-find-if-dates-overlap-and-then-create-new-dates-and-remove-rows
new_ministries <- 
  new_ministries %>% 
  mutate(counter = 1:nrow(new_ministries)) %>% 
  arrange(uniqueID, title, from) %>% 
  group_by(uniqueID, title) %>% 
  summarise(from = first(from), 
            to = last(to), 
            person = person,
            type = type, 
            counter = counter) %>% 
  ungroup() %>% 
  arrange(counter) %>% 
  select(-counter) %>% 
  distinct() 



new_ministries <- 
  new_ministries %>% 
  mutate(ministry = "Morrison",
         ministry_party = "LIB-NP Coalition",
         ministry_number = if_else(from <= "2019-05-29", 2, 1),
         ministry_comment = NA_character_
         ) %>% 
  rename(ministry_title = title,
         ministry_name = person,
         ministry_from = from,
         ministry_to = to,
         ) %>% 
  select(ministry, ministry_number, ministry_party,
         ministry_title, uniqueID, ministry_name,
         ministry_from, ministry_to, type, ministry_comment)

existing_ministries <- 
  existing_ministries %>% 
  rename(type = ministry_assistant_minister_or_parliamentary_secretary)


existing_ministries <- 
  rbind(existing_ministries,
        new_ministries)


write_csv()
