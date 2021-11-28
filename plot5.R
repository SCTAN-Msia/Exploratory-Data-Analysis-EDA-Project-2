# Exploratory Data Analysis Peer-graded Assignment: Course Project 2
# Cont's Analysis from Q4
# Code for Question 5 (Plot5)

# Q5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# The type of source - on-road refer to motor vehicle sources

#setwd working directory
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

# Extra only motor vehicle sources (type=ON-ROAD) data for Baltimore City, Maryland (fips == "24510")

emissions.BaltimoreMotor <- subset(NEI,fips == "24510" & type == "ON-ROAD")
tol.BaltimoreMotor <- aggregate(Emissions ~ year, emissions.BaltimoreMotor, sum)

# LinePlot
library(ggplot2)
dev.cur()
png('plot5.png')

ggBaltimoreMotor <-ggplot(tol.BaltimoreMotor, aes(year, Emissions)) + 
  geom_line(col = "steelblue3") +
  geom_point(shape="diamond filled", size = 2, fill = "steelblue3") +
  ggtitle(expression("Total PM"[2.5]* " Emissions from Motor Vehicle in Baltimore City by Year")) +
  xlab("Year") +
  ylab(expression("PM2.5 Emissions (Tons)"))

print(ggBaltimoreMotor)

dev.off()