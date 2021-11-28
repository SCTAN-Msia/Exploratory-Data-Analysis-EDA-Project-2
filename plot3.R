# Exploratory Data Analysis Peer-graded Assignment: Course Project 2
# Cont's Analysis from Q2
# Code for Question 3 (Plot3)

# Q3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#     which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#     Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
#     a plot answer this question.

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

# Extra data only for Baltimore City, Maryland (fips == "24510")
emissions.Baltimore <- subset(NEI,fips == "24510")

# GGPlot for data Baltimore City, Maryland by Year vs Type of Source
library(ggplot2)
dev.cur()
png('plot3.png')

ggpBaltimore <- ggplot(emissions.Baltimore, aes(factor(year),Emissions, fill=type)) +
  geom_bar(stat="identity") + theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type) + 
  labs(x="Year", y=expression("PM"[2.5]*" Emission (Tons)"))+ 
  labs(title=expression("PM"[2.5]*" Emissions in Baltimore City, Maryland Breakdown by Type of Sources"))

print(ggpBaltimore)
dev.off()