#### Preamble ####
# Purpose: Parse the ministers lists that were downloaded in get_ministries_lists.R
# Date: 13 November 2020
# Contact: Rohan Alexander
# Email: rohan.alexander@utoronto.ca
# License: MIT
# Todo: Change the start date for Bob Carr to from 13 March 2012. See inputs/data/australia/ministry_lists/2012-03-05-2012-10-28.html
# Fix Jonathon Duniam in the main list. It's wrong.


#### Setup ####
library(lubridate)
library(rvest)
library(tidyverse)

# Get a list of all the files
all_html_files <- list.files(path = "inputs/data/australia/ministry_lists",
                             full.names = TRUE)


#### Parse data ####
read_and_parse <- function(a_html_file_location) {
  # a_html_file_location <- all_html_files[1]
  raw_data <- read_html(a_html_file_location)
  
  text <- 
    raw_data %>% 
    html_nodes("p, h2") %>%
    html_text()
  
  all <- tibble(raw = text,
                file = a_html_file_location)
  rm(raw_data, text)
  return(all)
}


raw_data <- purrr::map_dfr(all_html_files, read_and_parse)



#### Prepare data ####
# There are a bunch of splits that we don't want
raw_data <- 
  raw_data %>% 
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
                          "Assistant Ministers are designated as Parliamentary Secretaries under the Ministers of\nState Act 1952. "),
         raw = str_replace(raw,
                          "Minister for Disability ReformThe Hon Jenny Macklin, MPMinister for Sustainability, Environment, Water, Population and CommunitiesThe Hon Tony Burke, MP",
                          "Minister for Disability ReformThe Hon Jenny Macklin, MP \n Minister for Sustainability, Environment, Water, Population and CommunitiesThe Hon Tony Burke, MP"),
         raw = str_replace(raw,
                           "Minister\nfor ",
                           "Minister for "),
         raw = str_replace(raw,
                           "The\nHon",
                           "The Hon"),
         raw = str_replace(raw,
                           "Senator\nthe",
                           "Senator the"),
         raw = str_replace(raw,
                           "The Hon Dr\nDavid",
                           "The Hon Dr David"),
         raw = str_replace(raw,
                          "Minister\n  for",
                          "Minister for"),
         raw = str_replace(raw,
                           "Assistant\n  Minister",
                           "Assistant Minister"),
         raw = str_replace(raw,
                           "Minister\nAssisting",
                           "Minister Assisting"),
  )

raw_data$raw[1342]

# # 
# raw_data %>%
#   filter(file %in% c(
#     "inputs/data/australia/ministry_lists/2017-12-20-2018-02-26.html",
#     "inputs/data/australia/ministry_lists/2018-02-26-2018-03-05.html"
#   )
#   ) %>%
#   select(raw) %>%
#   mutate(the = str_detect(raw, "The Hon Dr")) %>% 
#   filter(the)
#   
#   slice(8)
# 
# 
# raw_data$raw[14]

# Sometimes two folks are in the one row
raw_data <- 
  raw_data %>% 
  separate_rows(raw, sep = "\\\n") 

# raw_data$raw[289]

# Split into the title and the person
raw_data <- 
  raw_data %>% 
  separate_rows(raw, sep = "\\\n") %>% 
  mutate(raw = str_replace(raw, "The  Hon", "The Hon")) %>%
  mutate(raw = str_replace(raw, "The Hon Senator", "Senator  the Hon")) %>% 
  separate(col = raw,
           into = c("title", "person"),
           sep = "(?=Senator)|(?=The Hon)",
           fill = "right") 

# Deal with the associated data such as the class of the ministry, date
raw_data <- 
  raw_data %>% 
  mutate(type = if_else(title %in% c("Cabinet", "Ministry", "Outer Ministry", "Parliamentary Secretaries"), title, NA_character_),
         type = lag(x = type, n = 1)
  ) %>% 
  filter(!title %in% c("Bills", "Committees", "Committees", "Get informed", 
                       "Get involved", "House of Representatives", "Parliamentary Departments", 
                       "Senate", "Visit Parliament", "Website features",
                       "Ministry", "Outer Ministry", "Parliamentary Secretaries") 
  ) %>% 
  mutate(date = if_else(str_detect(title, "201[:digit:]{1}"), title, NA_character_))


raw_data <- 
  raw_data %>% 
  fill(date, .direction = "down") %>% 
  fill(type, .direction = "down") %>%
  fill(person, .direction = "up")

raw_data <- 
  raw_data %>% 
  mutate(
    title = str_replace_all(title, " " , ""),
    title = trimws(title),
    title = str_replace_all(title, "\\\r" , ""),
    title = str_replace_all(title, "\\\n" , "")) %>% 
  filter(title != "")

raw_data <- 
  raw_data %>% 
  mutate(title = if_else(str_detect(title, "201[:digit:]{1}"), NA_character_, title)) %>% 
  filter(!title %in% c("The 43rd Parliament", "The 44th Parliament", "The 45th Parliament", "The 46th Parliament", "Cabinet")) %>% 
  filter(!title %in% c("The following members of Cabinet were sworn in on 27th June", 
                       "The full Ministry was announced and sworn in on 1st July", 
                       "The following members of Cabinet were sworn in on 18th September",
                       "Assistant Ministers are designated as Parliamentary Secretaries under the Ministers of State Act 1952.")) %>% 
  filter(!is.na(title))

rm(read_and_parse, all_html_files)

prepared_data <- raw_data


#### Clean the data ####
#Something weird happened with the senators titles
prepared_data <- 
  prepared_data %>% 
  mutate(person = str_squish(person),
         person = str_replace(person, "The Hon(?=[:upper:]{1})", "The Hon "),
         person = str_replace(person, ", MP", " MP"),
         person = str_remove(person, " CSC$"),
         person = str_remove(person, " QC$"),
         person = str_remove(person, ", QC"),
         person = str_remove(person, " AO$"),
         person = str_remove(person, " AO "),
         person = str_remove(person, ", AM"),
         person = str_remove(person, " AM "),
         person = str_replace(person, " Dr ", " "),
         person = str_replace(person, "The Hon Craig Laundy$", "The Hon Craig Laundy MP"),
         person = str_replace(person, "The Hon Melissa Parke$", "The Hon Melissa Parke MP"),
         person = str_replace(person, "The Hon Gary Gray,MP", "The Hon Gary Gray MP"),
         person = str_replace(person, "Hon\\. ", "Hon "),
         person = str_replace(person, "The Hon Luke Hartsuker MP", "The Hon Luke Hartsuyker MP"), # lol, there's always a typo
         person = str_replace(person, "Senator the Hon Bob Carr \\(from 13 March 2012\\)", "Senator the Hon Bob Carr"), #TODO change the date
         person = str_replace(person, "The Hon Andrew RobbMP", "The Hon Andrew Robb MP"), #TODO There's some error that I've introduce here and the next
         person = str_replace(person, "The Hon Ken WyattMP", "The Hon Ken Wyatt MP"),
         person = str_replace(person, "The Hon Kelly O’Dwyer MP", "The Hon Kelly O'Dwyer MP"),
         person = str_replace(person, "The Hon Richard Marles$", "The Hon Richard Marles MP"),
         person = str_replace(person, "The Hon Mark Coulton$", "The Hon Mark Coulton MP"),

  )


list_of_names <- 
    prepared_data %>% 
    count(person, sort = TRUE)
  
rm(list_of_names)

prepared_data <- 
  prepared_data %>% 
  mutate(title = str_squish(title))

prepared_data <- 
  prepared_data %>% 
  mutate(title = str_replace(title, "Ministerfor Sport", "Minister for Sport"))


#### Match to AustralianPoliticians ####
# Now need to create column that matches the uniqueID
all <- AustralianPoliticians::all
mps <- AustralianPoliticians::by_division_mps
senators <- AustralianPoliticians::by_state_senators

# First we just need to filter to those who were in parliament at the time.
all <- 
  all %>% 
  filter(year(deathDate) >= 2010 | is.na(deathDate)) %>% 
  select(uniqueID, surname, allOtherNames, firstName, commonName,
         member, senator, wasPrimeMinister)
mps <- 
  mps %>% 
  select(uniqueID, mpFrom, mpTo) %>% 
  filter(year(mpTo) >= 2010 | is.na(mpTo)) %>% 
  left_join(all) %>% 
  select(-mpFrom, -mpTo)
senators <- 
  senators %>% 
  select(uniqueID, senatorFrom, senatorTo) %>% 
  filter(year(senatorTo) >= 2010 | is.na(senatorTo)) %>% 
  left_join(all) %>% 
  select(-senatorFrom, -senatorTo)
both <- rbind(mps, senators)
rm(all, mps, senators)

# We need to match the names as closely as we can to that which is in the list of ministers
list_of_names <- 
  prepared_data %>% 
  count(person, sort = TRUE)


both <- 
  both %>% 
  distinct() %>% 
  mutate(person = if_else(member == 1, "The Hon ", "Senator the Hon "),
         try_first_name = if_else(is.na(commonName), firstName, commonName),
         person = paste0(person, try_first_name, " ", surname),
         person = if_else(member == 1, 
                          paste0(person, " MP"),
                          person)
         ) %>% 
  mutate(person = str_replace(person, "Connie", "Concetta")) %>%
  mutate(person = str_replace(person, "Jonathan Duniam", "Jonathon Duniam")) %>%
  mutate(person = str_replace(person, "The Hon David Fawcett MP", "Senator the Hon David Fawcett")) %>%
  mutate(person = str_replace(person, "The Hon David Feeney MP", "Senator the Hon David Feeney")) %>%
  mutate(person = str_replace(person, "The Hon Matt Thistlethwaite MP", "Senator the Hon Matt Thistlethwaite")) %>%
  mutate(person = str_replace(person, "Senator the Hon Matt Canavan", "Senator the Hon Matthew Canavan")) %>%
  mutate(person = str_replace(person, "The Hon Michael Ronaldson MP", "Senator the Hon Michael Ronaldson")) %>%
  mutate(person = str_replace(person, "The Hon Kevin Drum MP", "The Hon Damian Drum MP")) %>%
  mutate(person = str_replace(person, "The Hon Dan Tehan MP", "The Hon Daniel Tehan MP")) %>%
  mutate(person = str_replace(person, "Joe Ludwig", "Joseph Ludwig")) %>% 
  mutate(person = str_replace(person, "The Hon Steve Ciobo MP", "The Hon Steven Ciobo MP")) %>% 
  select(person, uniqueID)

prepared_data <- 
  prepared_data %>% 
  left_join(both)


#### Clean up ####
prepared_data %>% 
  count(title)

prepared_data <- 
  prepared_data %>% 
  mutate(title = str_remove(title, "\\("),
         title = str_remove(title, "\\)"))





  
write_csv(prepared_data, "outputs/data/australia/data/ministries.csv")
