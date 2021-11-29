#### Preamble ####
# Purpose: Use this script to update the datasets.
# Date: 29 November 2021
# Contact: Rohan Alexander
# Email: rohan.alexander@utoronto.ca
# License: MIT
# Todo: Make functions out of all this instead of copy/pasting code.


#### Setup ####
library(lubridate)
library(tidyverse)






# 29 November 2021
#### Scott Ryan resigns
# Senators
senators <- read_csv("data/australian_politicians-senators-by_state.csv", 
                     guess_max = 2500)

senators$senatorTo[senators$uniqueID == "Ryan1973"] <- ymd("2021-10-13")
senators$senatorEndReason[senators$uniqueID == "Ryan1973"] <- "Resigned"

write_csv(senators, "data/australian_politicians-senators-by_state.csv")





#### Karen Grogan replacing Alex Gallacher
all <- read_csv("data/australian_politicians-all.csv", 
                guess_max = 2500)

new_politician <- 
  tibble(
    uniqueID = "Grogan",
    surname = "Grogan",
    allOtherNames = "Karen",
    firstName = "Karen",
    commonName = NA_character_,
    displayName = "Grogan, Karen",
    earlierOrLaterNames = NA_character_,
    title = NA_character_,
    gender = "female",
    birthDate = NA_Date_,
    birthYear = NA_integer_,
    birthPlace = "London",
    deathDate = NA_Date_,
    member = "0",
    senator = "1",
    wasPrimeMinister = NA_character_,
    wikidataID = "Q108617920",
    wikipedia = "https://en.wikipedia.org/wiki/Karen_Grogan",
    adb = NA_character_,
    comments = NA_character_
  )

all <- 
  rbind(all, new_politician) %>% 
  arrange(uniqueID)

all$deathDate[all$uniqueID == "Gallacher1954"] <- ymd("2021-08-29")

write_csv(all, "data/australian_politicians-all.csv")

# Party
party <- read_csv("data/australian_politicians-all-by_party.csv", 
                  guess_max = 2500)

new_politician <- 
  tibble(
    uniqueID = "Grogan",
    partyAbbrev = "ALP",
    partyName = "Australian Labor Party", 
    partyFrom = NA_Date_,
    partyTo = NA_Date_, 
    partyChangedName = NA_character_,
    partySimplifiedName = "Labor",
    partySpecificDateInputted = NA_integer_,
    partyComments = NA_character_
  )

party <- 
  rbind(party, new_politician) %>% 
  arrange(uniqueID)

write_csv(party, "data/australian_politicians-all-by_party.csv")


# Senators
senators <- read_csv("data/australian_politicians-senators-by_state.csv", 
                     guess_max = 2500)

new_politician <- 
  tibble(
    uniqueID = "Grogan",
    senatorsState = "SA",
    senatorFrom = ymd("2021-09-21"),
    senatorTo = NA_Date_,
    senatorEndReason = NA_character_,
    sec15Sel = 1,
    senatorComments = "Replaced Alex Gallacher on his death."
  )

senators <- 
  rbind(senators, new_politician) %>% 
  arrange(uniqueID)

senators$senatorTo[senators$uniqueID == "Gallacher1954"] <- ymd("2021-08-29")
senators$senatorEndReason[senators$uniqueID == "Gallacher1954"] <- "Death"

write_csv(senators, "data/australian_politicians-senators-by_state.csv")










# 29 November 2021
####  Dorinda Cox replacing Rachel Siewert
all <- read_csv("data/australian_politicians-all.csv", 
                guess_max = 2500)

new_politician <- 
  tibble(
    uniqueID = "Cox1977",
    surname = "Cox",
    allOtherNames = "Dorinda Rose",
    firstName = "Dorinda",
    commonName = NA_character_,
    displayName = "Cox, Dorinda",
    earlierOrLaterNames = NA_character_,
    title = NA_character_,
    gender = "female",
    birthDate = NA_Date_,
    birthYear = 1977,
    birthPlace = NA_character_,
    deathDate = NA_Date_,
    member = "0",
    senator = "1",
    wasPrimeMinister = NA_character_,
    wikidataID = "Q108441696",
    wikipedia = "https://en.wikipedia.org/wiki/Dorinda_Cox",
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
    uniqueID = "Cox1977",
    partyAbbrev = "GRN",
    partyName = "Australian Greens", 
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


# Senators
senators <- read_csv("data/australian_politicians-senators-by_state.csv", 
                  guess_max = 2500)

new_politician <- 
  tibble(
    uniqueID = "Cox1977",
    senatorsState = "WA",
    senatorFrom = ymd("2021-10-19"),
    senatorTo = NA_Date_,
    senatorEndReason = NA_character_,
    sec15Sel = 1,
    senatorComments = "Replaced Rachel Siewert"
  )

senators <- 
  rbind(senators, new_politician) %>% 
  arrange(uniqueID)

senators$senatorTo[senators$uniqueID == "Siewert1961"] <- ymd("2021-09-06")
senators$senatorEndReason[senators$uniqueID == "Siewert1961"] <- "Resigned"


write_csv(senators, "data/australian_politicians-senators-by_state.csv")














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


