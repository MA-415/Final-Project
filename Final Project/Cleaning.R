library(tidyverse)
data_eco <- read.csv("ENOW_Sectors_2005_2021.csv")

# Filter for Newport, RI
newport_data <- data_eco |>
  filter(GeoName == "Newport, RI",
         OceanSector %in% c("Ship and Boat Building", 
                            "Tourism and Recreation", 
                            "All Ocean Sectors"))

data <- read.csv("Demographics_RI.csv")

# Filter for COUNTYICP == 70 and drop the RACED column
filtered_data <- data |>
  filter(COUNTYICP == 70) |>
  select(-RACED.)
