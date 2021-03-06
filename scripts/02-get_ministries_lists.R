#### Preamble ####
# Purpose: Grabs the ministers lists. The parliament website makes the ministers 
# data available for each period. This script downloads them.
# Date: 13 November 2020
# Contact: Rohan Alexander
# Email: rohan.alexander@utoronto.ca
# License: MIT
# Related: parse_ministries_lists.R
# Todo: -


#### Setup ####
library(lubridate)
library(rvest)
library(tidyverse)


#### Download data ####
# The current page is here:
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
  mutate(save_name = paste0("inputs/ministry_lists/", save_name))



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




# Um, lol, I forgot to get the current one:
raw_page <- read_html("https://www.aph.gov.au/About_Parliament/Parliamentary_Departments/Parliamentary_Library/Parliamentary_Handbook/Current_Ministry_List")
# Save it locally
write_html(raw_page, "inputs/ministry_lists/2020-02-06-current.html")

