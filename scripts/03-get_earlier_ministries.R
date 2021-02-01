#### Preamble ####
# Purpose: Parse the ministers lists that were downloaded in get_ministries_lists.R
# Date: 13 November 2020
# Contact: Rohan Alexander
# Email: rohan.alexander@utoronto.ca
# License: MIT
# Todo: Change the start date for Bob Carr to from 13 March 2012. See inputs/ministry_lists/2012-03-05-2012-10-28.html


#### Setup ####
library(lubridate)
library(rvest)
library(tidyverse)


a_html_file_location <- "https://parlinfo.aph.gov.au/parlInfo/search/display/display.w3p;db=HANDBOOK;id=handbook%2Fnewhandbook%2F2017-06-21%2F0059;query=Id%3A%22handbook%2Fnewhandbook%2F2017-06-21%2F0048%22"

raw_data <- read_html(a_html_file_location)


text <- 
  raw_data %>% 
  html_nodes(".cabinet-wrapper , .table-text, .table-rv") %>%
  html_text()

all <- tibble(raw = text)


text <- 
  raw_data %>% 
  html_nodes(".cabinet-wrapper") %>%
  html_text()

all <- tibble(raw = text)
all <- 
  all %>% 
  separate_rows(raw, sep = "\\n")

write_csv(all, "asdfas.csv")

all <- 
  all %>% 
  separate(col = raw, 
           into = c(1:20 %>% as.character()),
           sep = "\\t",
           fill = "right"
           ) 

write_csv(all, 'intermediates/earlier_ministries.csv')




  
  
  
  
  