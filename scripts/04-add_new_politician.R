#### Preamble ####
# Purpose: 
# Date: 31 January 2021
# Contact: Rohan Alexander
# Email: rohan.alexander@utoronto.ca
# License: MIT
# Todo: 


#### Setup ####
library(lubridate)
library(tidyverse)


#### Garth Hamilton
all <- read_csv("data/australian_politicians-all.csv", 
                guess_max = 2500)

new_politician <- 
  tibble(
    uniqueID = "Hamilton1979",
    surname = "Hamilton",
    allOtherNames = "Garth Russell",
    firstName = "Garth",
    commonName = NA_character_,
    displayName = "Hamilton, Garth",
    earlierOrLaterNames = NA_character_,
    title = NA_character_,
    gender = "male",
    birthDate = ymd("1979-03-05"),
    birthYear = 1979,
    birthPlace = NA_character_,
    deathDate = NA_Date_,
    member = "1",
    senator = "0",
    wasPrimeMinister = NA_character_,
    wikidataID = "Q102420453",
    wikipedia = "https://en.wikipedia.org/wiki/Garth_Hamilton",
    adb = NA_character_,
    comments = NA_character_
  )

all <- 
  rbind(all, new_politician) %>% 
  arrange(uniqueID)

write_csv(all, "data/australian_politicians-all.csv")

# Party
party <- read_csv("data/australian_politicians-all-by_party.csv", 
                guess_max = 2500)

new_politician <- 
  tibble(
    uniqueID = "Hamilton1979",
    partyAbbrev = "LIB",
    partyName = "Liberal Party of Australia", 
    partyFrom = NA_Date_,
    partyTo = NA_Date_, 
    partyChangedName = NA_character_,
    partySimplifiedName = "Liberals",
    partySpecificDateInputted = NA_integer_,
    partyComments = NA_character_
  )

party <- 
  rbind(party, new_politician) %>% 
  arrange(uniqueID)

write_csv(party, "data/australian_politicians-all-by_party.csv")


# Members
members <- read_csv("data/australian_politicians-mps-by_division.csv", 
                  guess_max = 2500)


new_politician <- 
  tibble(
    uniqueID = "Hamilton1979",
    division = "Groom",
    stateOfDivision = 'QLD',
    enteredAtByElection = 1,
    mpFrom = ymd("2020-11-28"),
    mpTo = NA_Date_,
    mpEndReason = NA_character_,
    mpChangedSeat = NA_real_,
    mpComments = NA_character_,
  )

members <- 
  rbind(members, new_politician) %>% 
  arrange(uniqueID)

members$mpTo[members$uniqueID == "McVeigh1965"] <- ymd("2020-09-18")
members$mpEndReason[members$uniqueID == "McVeigh1965"] <- "Resigned"

write_csv(members, "data/australian_politicians-mps-by_division.csv")




#### Doug Anthony passed away
all <- read_csv("data/australian_politicians-all.csv", 
                guess_max = 2500)
all$deathDate <- ymd(all$deathDate)
all$deathDate[all$uniqueID == "Anthony1929"] <- ymd("2020-12-20")
write_csv(all, "data/australian_politicians-all.csv")



#### Fix Kristy McBain

all <- read_csv("data/australian_politicians-all.csv", 
                guess_max = 2500)

all[1097,]

new_politician <- 
  tibble(
    uniqueID = "McBain1982",
    surname = "McBain",
    allOtherNames = "Kristy Louise",
    firstName = "Kristy",
    commonName = "",
    displayName = "McBain, Kristy",
    earlierOrLaterNames = NA_character_,
    title = NA_character_,
    gender = "female",
    birthDate = ymd('1982-09-29'),
    birthYear = 1982,
    birthPlace = 'Traralgon',
    deathDate = NA_character_,
    member = "1",
    senator = "0",
    wasPrimeMinister = NA_character_,
    wikidataID = "Q96970848",
    wikipedia = "https://en.wikipedia.org/wiki/Kristy_McBain",
    adb = NA_character_,
    comments = NA_character_
  )

all <- 
  all %>% 
  filter(uniqueID != 'McBain1982') 

all <- 
  rbind(all, new_politician) %>% 
  arrange(uniqueID)

write_csv(all, "data/australian_politicians-all.csv")


#### Matias Cormann
# All
new_politician <- 
  tibble(
    uniqueID = "Small1988",
    surname = "Small",
    allOtherNames = "Benjamin John",
    firstName = "Benjamin",
    commonName = "Ben",
    displayName = "Small, Ben",
    earlierOrLaterNames = NA_character_,
    title = NA_character_,
    gender = "male",
    birthDate = NA_Date_,
    birthYear = NA_integer_,
    birthPlace = NA_character_,
    deathDate = NA_character_,
    member = "0",
    senator = "1",
    wasPrimeMinister = NA_character_,
    wikidataID = "Q101244911",
    wikipedia = "https://en.wikipedia.org/wiki/Ben_Small_(politician)",
    adb = NA_character_,
    comments = NA_character_
  )

all <- 
  rbind(all, new_politician) %>% 
  arrange(uniqueID)

write_csv(all, "outputs/australian_politicians-all.csv")


# Party
new_politician <- 
  tibble(
    uniqueID = "Small1988",
    partyAbbrev = "LIB",
    partyName = "Liberal Party of Australia", 
    partyFrom = NA_Date_,
    partyTo = NA_Date_, 
    partyChangedName = NA_character_,
    partySimplifiedName = "Liberals",
    partySpecificDateInputted = NA_integer_,
    partyComments = NA_character_
    )

party <- 
  rbind(party, new_politician) %>% 
  arrange(uniqueID)

write_csv(party, "outputs/australian_politicians-all-by_party.csv")


# Senators
new_politician <- 
  tibble(
    uniqueID = "Small1988",
    senatorsState = "WA",
    senatorFrom = ymd("2020-11-25"),
    senatorTo = NA_Date_,
    senatorEndReason = NA_character_,
    sec15Sel = 1,
    senatorComments = NA_character_
  )


senators <- 
  rbind(senators, new_politician) %>% 
  arrange(uniqueID)


senators$senatorTo[senators$uniqueID == "Cormann1970"] <- ymd("2020-11-06")
senators$senatorEndReason[senators$uniqueID == "Cormann1970"] <- "Resigned"


write_csv(senators, "outputs/australian_politicians-senators-by_state.csv")


