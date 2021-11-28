# Exploratory Data Analysis Peer-graded Assignment: Course Project 2
# Cont's Analysis from Q5
# Code for Question 6 (Plot6)

# Q6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
#     in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in 
#     motor vehicle emissions?
#     Note: The type of source - on-road refer to motor vehicle sources

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

# Extra only motor vehicle sources (type=ON-ROAD) data for Baltimore City (fips == "24510") &  
# Los Angeles County (fips == "06037")

Baltimore_LosAngelesMotor <- subset(NEI, NEI$fips %in% c("24510","06037") & NEI$type == "ON-ROAD")
tol.Baltimore_LosAngelesMotor <- aggregate(Emissions ~ year + fips, Baltimore_LosAngelesMotor, sum)

library(ggplot2)
dev.cur()
png('plot6.png')

ggBaltimoreMotor2<-ggplot(tol.Baltimore_LosAngelesMotor, aes(year, Emissions, col = fips)) +
  geom_line() +
  geom_point() +
  ggtitle(expression("Baltimore & Los Angeles PM"*""[2.5]* " Emissions from Motor Vehicle by Year")) +  
  labs(x = "Year", y = expression("PM"[2.5]*" Emission (Tons)")) +
  scale_colour_discrete(name = "City", labels = c("Los Angeles", "Baltimore")) +
  theme(legend.title = element_text(face = "bold"))

print(ggBaltimoreMotor2)
dev.off()