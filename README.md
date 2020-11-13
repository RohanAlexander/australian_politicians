# Australian Politicians

This repo provides the code, datasets and other support materials for the data package AustralianPoliticians.

- Inputs are raw data and resources and should not be directly modified
- Intermediates are data that have been constructed from inputs, but still need work before being finalised
- Outputs are the final datasets that are drawn on by AustralianPoliticians.

Further information on these datasets is available at the AustralianPoliticians repo.

# Sources

In the first instance, the Parliamentary Handbook was the main source of information. This was augmented with information from Wikipedia, the Australian Dictionary of Biography, and the Senate Biographies wherever possible. Limited information was obtained from other sources, such as state parliaments and newspapers (via Trove), and these have generally been specified in the comments. birthPlace is mostly from WikiData.

The uniqueID_to_aphID dataset was primarily drawn from a dataset put together by Patrick Leslie, and it was checked against a modern dataset from Open Australia, and Tim Sherratt’s Historic Hansard records for the Reps and Senate.

# Citation

I'd recommend using the datasets as they are provided in the AustralianPoliticians package and repo - https://github.com/RohanAlexander/AustralianPoliticians - and if you do that please consider citing the working paper:

Alexander, Rohan and Hidaya Ismail, 2020, 'AusPol: Three datasets on Australian Politics'.


# Author information

**Rohan Alexander** (corresponding author and repository maintainer)  
Faculty of Information & Department of Statistical Sciences  
University of Toronto  
140 St George St  
Toronto, ON, Canada  
Email: rohan.alexander@utoronto.ca  

**Hidaya Ismail** (repository contributor)


# TODO

1. From intermediates/cabinet.csv - work out some way to have a flag in outputs/ministry.csv as to whether the person was in cabinet or not.
2. From intermediates/recent_ministries.csv - work out a way to add these to outputs/ministry.csv.
3. Checks. Tables. Graphs.

