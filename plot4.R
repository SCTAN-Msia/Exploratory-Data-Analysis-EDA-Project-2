# Exploratory Data Analysis Peer-graded Assignment: Course Project 2
# Cont's Analysis from Q3
# Code for Question 4 (Plot4)

# Q4: Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

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
SCC <- readRDS("Source_Classification_Code.rds")

# Extra only coal combustion-related sources data for all US

combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE) # to form TrueFalse index for SCC combustion related data
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) # to form TrueFalse index for SCC coal related data
coalCombustion <- (combustionRelated & coalRelated) # to form TrueFalse index for data with: combustion & coal = TRUE
combustionSCC <- SCC[coalCombustion,]$SCC   # to select SCC data that combustion & coal = TRUE
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,] # to merge & Select NEI & SCC data that combustion & coal = TRUE

tol.combustionNEI <- aggregate(Emissions ~ year, combustionNEI, sum)

# BarPlot for coal combustion-related sources data for all US
dev.cur()
png('plot4.png')

barplot((tol.combustionNEI$Emissions)/10^3
        , names= tol.combustionNEI$year
        , xlab = "Years", ylab = "PM2.5 Emissions (KiloTons)"
        , main = paste("Total PM2.5 Emissions from Coal Combustion-Related Sources","\nin United States"))

dev.off()

