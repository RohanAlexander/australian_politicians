# Australian Politicians

This repo provides the code, datasets and other support materials for the data package AustralianPoliticians.

The most important folder is 'data' which contains the cleaned datasets. And the most important dataset is 'australian_politicians-all.csv'. Datasets are linked by the 'uniqueID' field.

- 'data' is a folder that contains the cleaned datasets. The datasets are linked by the 'uniqueID' field and the most important is 'australian_politicians-all.csv'.
  - 'australian_politicians-all-by_party.csv': TBD
  - 'australian_politicians-all.csv': TBD
  - 'australian_politicians-ministries.csv': TBD
  - 'australian_politicians-mps-by_division.csv': TBD
  - 'australian_politicians-senators-by_state.csv': TBD
  - 'australian_politicians-uniqueID_to_aph_ministries.csv': TBD
  - 'australian_politicians-uniqueID_to_aphID.csv': TBD
- The 'inputs' folder contain raw data and resources. The materials in here should not be directly modified, but are drawn on.
- The 'outputs' folder contains the relevant paper.
- The 'scripts' folder contains various scripts that can be used to update the datasets.

Further information on these datasets is available at the AustralianPoliticians repo: https://github.com/RohanAlexander/AustralianPoliticians.


# Sources

In the first instance, the Parliamentary Handbook was the main source of information. This was augmented with information from Wikipedia, the Australian Dictionary of Biography, and the Senate Biographies wherever possible. Limited information was obtained from other sources, such as state parliaments and newspapers (via Trove), and these have generally been specified in the comments. birthPlace is mostly from WikiData.

The uniqueID_to_aphID dataset was primarily drawn from a dataset put together by Patrick Leslie, and it was checked against a modern dataset from Open Australia, and Tim Sherratt’s Historic Hansard records for the Reps and Senate.

# Citation

Alexander, Rohan, 2021, 'A dataset of Australian federal politicians (1901-2021) and associated R package', last updated 29 November 2021.

I'd recommend using the datasets as they are provided in the AustralianPoliticians package and repo - https://github.com/RohanAlexander/AustralianPoliticians - and if you do that please additionally cite the package.



# Author information

**Rohan Alexander** (corresponding author and repository maintainer)  
Faculty of Information & Department of Statistical Sciences  
University of Toronto  
140 St George St  
Toronto, ON, Canada  
Email: rohan.alexander@utoronto.ca  


# TODO

1. Karen Grogan needs a birthdate or at least a year - will need to update the uniqueID at that point too.
2. Greg Mirabella likely soon in the Senate replacing Scott Ryan.
