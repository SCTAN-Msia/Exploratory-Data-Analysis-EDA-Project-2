# Exploratory Data Analysis Peer-graded Assignment: Course Project 2
# Cont's Analysis from Q1
# Code for Question 2 (Plot2)

# Q2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#     from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#setwd working directory
setwd("C:/Users/small/Documents/R_GitHub/EDA/Exploratory-Data-Analysis-EDA-Project-2")
library(dplyr)

# Download data from Course Web site & Unzip data zipped file (Option 2)
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

# Extra data only for Baltimore City, Maryland (fips == "24510")
emissions.Baltimore <- subset(NEI,fips == "24510")
tol.emissions.Baltimore <- aggregate(Emissions ~ year, emissions.Baltimore, sum)

dev.cur()
png('plot2.png')

barplot((tol.emissions.Baltimore$Emissions)
        , names= tol.emissions.Baltimore$year
        , xlab = "Years", ylab = "PM2.5 Emissions (Tons)"
        , main = "Total PM2.5 Emissions in Baltimore City, Maryland Over the Years")

dev.off()
