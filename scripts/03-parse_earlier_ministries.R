#### Preamble ####
# Purpose: Parse the ministers lists that were downloaded
# Date: 22 November 2020
# Contact: Rohan Alexander
# Email: rohan.alexander@utoronto.ca
# License: MIT
# Todo: 


#### Setup ####
library(lubridate)
library(rvest)
library(tidyverse)

raw <- read_csv('intermediates/earlier_ministries.csv', guess_max = 13968)

raw <- 
  raw %>% 
  select(-`2`, -`3`, -`4`, -`5`, -`11`, -`12`, -`13`, -`14`, -`15`, -`16`, -`17`, -`18`, -`19`, -`20`) %>% 
  janitor::clean_names() %>% 
  mutate(ministry_name = if_else(is.na(x1), x6, x1)) %>% 
  select(ministry_name, everything()) %>% 
  select(-x1, -x6)

raw <- 
  raw %>% 
  mutate(x9 = lead(x9, n = 1))


raw <- 
  raw %>% 
  mutate(is_a_date = str_detect(x8, "[:digit:]{1,2}\\.[:digit:]{1,2}\\.[:digit:]{4}"), # Looks for things like 12.10.1906 and 2.10.1906
         date = if_else(is_a_date == TRUE,
                        x8,
                        NA_character_),
         x8 = if_else(is_a_date == TRUE,
                      NA_character_,
                      x8),
         is_a_date = str_detect(x9, "[:digit:]{1,2}\\.[:digit:]{1,2}\\.[:digit:]{4}"),
         date = if_else(is_a_date == TRUE & is.na(date),
                        x9,
                        date),
         x9 = if_else(is_a_date == TRUE,
                      NA_character_,
                      x9)
  ) %>% 
  select(-is_a_date)





#### Split into whether they were before or after the change
# At this point we're going to split it into sections. Until 1956 everyone in the ministry was also in cabinet. 
raw <- 
  raw %>% 
  mutate(the_one = str_detect(ministry_name, "Menzies Ministry \\(LIB-CP Coalition\\) 11\\.1\\.1956 - 10\\.12\\.1958"),
         the_one = if_else(the_one == TRUE, 1, 0),
         the_one = replace_na(the_one, 0),
         the_one = cumsum(the_one)
  )

all_in_cabinet <- 
  raw %>% 
  filter(the_one == 0) %>% 
  select(-the_one)

not_all_in_cabinet <- 
  raw %>% 
  filter(the_one == 1) %>% 
  select(-the_one)

rm(raw)


#### Olden days ####
all_in_cabinet <- 
  all_in_cabinet %>% 
  select(-x7, -x10)

all_in_cabinet <- 
  all_in_cabinet %>% 
  mutate(ministry_name = str_replace(ministry_name, "Title", NA_character_))

all_in_cabinet <- 
  all_in_cabinet %>% 
  fill(ministry_name, .direction = "down")

all_in_cabinet <- 
  all_in_cabinet %>% 
  mutate(str_replace(x8,
                     "Minister in Charge of Scientific and Industrial Research",
                     "Minister in charge of Scientific and Industrial Research")
         ) %>% 
  rename(job = x8)

all_in_cabinet <- 
  all_in_cabinet %>% 
  mutate(x9 = str_replace(x9, "Assistant ministers/Parliamentary secretaries", NA_character_),
         x9 = str_replace(x9, "Minister", NA_character_))

hmmm <- 
  all_in_cabinet %>% 
  count(x9, sort = TRUE)

rm(hmmm)

"Assistant to the Treasurer"
"Assistant Treasurer"
"Treasurer"










raw <- 
  raw %>% 
  mutate(the_one = str_detect(ministry_name, "Rudd Ministry \\(ALP\\) 27\\.6\\.2013 - 18\\.9\\.2013"),
         the_one = if_else(the_one == TRUE, 1, 0),
         the_one = replace_na(the_one, 0),
         the_one = cumsum(the_one)
  )

raw <- 
  raw %>% 
  filter(the_one == 0) %>% 
  select(-the_one)


raw <- 
  raw %>% 
  select(-x10)












#### Debris ####




