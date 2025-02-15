
file_root <- "https://www.ndbc.noaa.gov/view_text_file.php?filename=44013h"
tail <- ".txt.gz&dir=data/historical/stdmet/"

path <- paste0(file_root, "1984", tail)

buoy <- read.table(path, fill=TRUE, header = TRUE, sep = "")

head(buoy)

nat <- which(is.na(buoy$ATMP))

nat <- length(nat)


airtemp <- buoy$ATMP
saveRDS(airtemp, file = "airtemp.rdata")

plot(airtemp)

#convert time

library(lubridate)
library(tidyverse)
library(data.table)

buoy[1,]

date <- buoy[10,1:4]

date1 <- unlist(date)
date1 <- as.character(date1)
date1 <- paste0(date1[1], "-", date1[2], "-",date1[3], "-",date1[4])

date2 <- ymd_h(date1)




#Her stuff
#This is all just data cleaning
#TTF CGTSD SLTC


file_root <- "https://www.ndbc.noaa.gov/view_text_file.php?filename=44013h"
tail <- ".txt.gz&dir=data/historical/stdmet/"



load_buoy_data1 <- function(year) {
  path <- paste0(file_root, year, tail)


if (year < 2007) {
  header <- scan(path, what = "character", nlines = 1)
  buoy <- read.table(path, fill=TRUE, header = TRUE, sep = "")
  buoy <- add_column(buoy, mm =NA, .after = "hh")
  buoy <- add_column(buoy, TIDE =NA, .after = "VIS")
  
}else{
  
  header <- scan(path, what = "character", nlines = 1)
  buoy <- fread(path, header = FALSE, skip =1, fill = TRUE)
  setnames(buoy, header)
}

}

all_data1 <- lapply(1985:2024, load_buoy_data1)

combined_data1 <- rbindlist(all_data, fill = TRUE)

#Get all the years in one format/column
#Get Tide and Tide.1 in same column
#Use na.if to remove 99, 999, 9999


