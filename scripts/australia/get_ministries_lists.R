#### Preamble ####
# Purpose: Grabs the ministers lists. The parliament website makes the ministers 
# data available for each period. This script downloads them.
# Date: 13 November 2020
# Contact: Rohan Alexander
# Email: rohan.alexander@utoronto.ca
# License: MIT
# Todo: 


#### Setup ####
library(lubridate)
library(rvest)
library(tidyverse)


#### Download data ####
# The first page is here:
# https://www.aph.gov.au/About_Parliament/Parliamentary_Departments/Parliamentary_Library/Parliamentary_Handbook/Current_Ministry_List/Ministry_26_November_2018_to_18_December_2018
current <- 
  read_html("https://www.aph.gov.au/About_Parliament/Parliamentary_Departments/Parliamentary_Library/Parliamentary_Handbook/Current_Ministry_List")


#### Parse data ####
# We are looking for the links
all_links <- 
  current %>% 
  html_nodes(".links a") %>% 
  html_attr("href")
# Make into a tibble
links_and_savenames <- 
  tibble(address = all_links)
# Add a savename
links_and_savenames <- 
  links_and_savenames %>% 
  mutate(
    address = str_remove(address,
                         "https://www.aph.gov.au"),
    address = str_remove(address,
                         "http://www.aph.gov.au"),
    save_name = address,
    save_name = str_replace(save_name,
                           "%20",
                           "_"),
    save_name = str_remove(save_name, 
                           "/About_Parliament/Parliamentary_Departments/Parliamentary_Library/Parliamentary_Handbook/Current_Ministry_List/Ministry_"),
    save_name = str_replace(save_name, "_-_", "_to_")
  ) %>% 
  separate(save_name, into = c("from", "to"), sep = "_to_") %>% 
  mutate(
    from = dmy(from),
    to = dmy(to),
    save_name = paste0(from, "-", to, ".html")
  ) %>% 
  select(-from, -to) %>% 
  mutate(save_name = paste0("inputs/data/australia/ministry_lists/", save_name))



#### Download and save data ####
# Write a function that we'll use
download_ministries_pages <- function(address_to_download, save_location){
  full_address <- paste0("https://www.aph.gov.au", address_to_download)
  # Get the page
  raw_page <- read_html(full_address)
  # Save it locally
  write_html(raw_page, save_location)
  # Print to the console so the user knows what's happening
  message <- paste0("Done with ", save_location, " at ", Sys.time())
  print(message)
  rm(full_address, raw_page)
  # Pause to be polite
  Sys.sleep(sample(x = c(5:10), size = 1))
}

# Apply the function to the dataset that we created earlier
# links_and_savenames <- links_and_savenames[1:2,] # Just for testing
# This will take a while
# Commented to prevent accidentally running
walk2(links_and_savenames$address, links_and_savenames$save_name, download_ministries_pages)











#### Sample that works

Ministry_26_November_2018_to_18_December_2018 <- 
  read_html("https://www.aph.gov.au/About_Parliament/Parliamentary_Departments/Parliamentary_Library/Parliamentary_Handbook/Current_Ministry_List/Ministry_26_November_2018_to_18_December_2018")
# Come back and add the others





#### Process data ####
#  What we need is to create start and end periods for each role
text <- 
  Ministry_26_November_2018_to_18_December_2018 %>% 
  html_nodes("p, h2") %>%
  # html_nodes(":not(a)") %>% 
  html_text()


all <- tibble(raw = text)

all[30:40,]


all <- 
  all %>% 
  mutate(raw = str_replace(raw,
                           "Prime\nMinister",
                           "Prime Minister"),
         raw = str_replace(raw,
                           "Deputy\nPrime Minister",
                           "Deputy Prime Minister"),
         raw = str_replace(raw,
                           "The Hon\n",
                           "The Hon"),
         raw = str_replace(raw,
                           "Minister\nfor Foreign Affairs",
                           "Minister for Foreign Affairs"),
         raw = str_replace(raw,
                           "Minister\nfor Trade",
                           "Minister for Trade"),
         raw = str_replace(raw,
                           "Parliamentary\nSecretaries",
                           "Parliamentary Secretaries"),
         raw = str_replace(raw,
                           "Assistant\nMinister",
                           "Assistant Minister"),
         raw = str_remove(raw,
                          "Assistant Ministers are designated as Parliamentary Secretaries under the Ministers of\nState Act 1952. ")
  ) %>% 
  separate_rows(raw, sep = "\\\n") %>% 
  separate(col = raw,
           into = c("title", "person"),
           sep = "(?=Senator)|(?=The Hon)",
           fill = "right") %>% 
  mutate(type = if_else(title %in% c("Ministry", "Outer Ministry", "Parliamentary Secretaries"), title, NA_character_),
         type = lag(x = type, n = 1)
  ) %>% 
  filter(!title %in% c("Bills", "Committees", "Committees", "Get informed", 
                       "Get involved", "House of Representatives", "Parliamentary Departments", 
                       "Senate", "Visit Parliament", "Website features",
                       "Ministry", "Outer Ministry", "Parliamentary Secretaries") 
  ) %>% 
  mutate(date = if_else(str_detect(title, "201[:digit:]{1}"), title, NA_character_))


all <- 
  all %>% 
  fill(date, .direction = "down") %>% 
  fill(type, .direction = "down") %>%
  fill(person, .direction = "up")

all <- 
  all %>% 
  mutate(
    title = str_replace_all(title, " " , ""),
    title = trimws(title),
    title = str_replace_all(title, "\\\r" , ""),
    title = str_replace_all(title, "\\\n" , "")) %>% 
  filter(title != "")

first_pm_row <- which(all$title == "Prime Minister")

all <- 
  all %>% 
  slice(first_pm_row:nrow(all))



