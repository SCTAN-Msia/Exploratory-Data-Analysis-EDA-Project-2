# Objective (Goal)
# To explore the National Emissions Inventory database and observe what it say about fine
# particulate matter pollution in the United states over the 10-year period 1999–2008.

# Code for Question 1 (Plot1)
# Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008

# setwd working directory

setwd("C:/Users/small/Documents/R_GitHub/EDA/Exploratory-Data-Analysis-EDA-Project-2")
library(dplyr)

# Download data from Course Web site & Unzip data zipped file
Data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip" 
DaTZipfile <- "exdata_data_NEI_data.zip"

if(!file.exists(DaTZipfile)) {
  download.file(Data_url, 
                destfile = DaTZipfile, 
                method = "curl")
  unzip(zipfile = "exdata_data_NEI_data.zip", list = FALSE, exdir = ".")
}

#  Reads data from the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Compute the aggregate values
tol.emissions <- aggregate(Emissions ~ year, NEI, sum)

# Active graphics device
dev.cur()

## Assigned plot 
png("plot1.png")

## Plotting
barplot((tol.emissions$Emissions)/10^3 , names = tol.emissions$year
        , xlab = "Years", ylab = "PM2.5 Emissions (in 10 KiloTons)"
        , main = "Total PM2.5 Emissions in United States Over the Years")

dev.off()
