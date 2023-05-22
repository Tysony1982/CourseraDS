
setwd("C:/Users/tbetts/source/DataScience/RProjects/Coursera/CleaningData")
library(dplyr)

# Set the relative file path to the utilities.R file
file_path <- "./../Utility/utilities.R"

# Source the file to load the my_function function into the global environment
source(file_path)
q1FileName <- "q1FileName"

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", q1FileName)

q1File <- read.csv(q1FileName, header = TRUE)

class(q1File)

housePriceRanges <- q1File$VAL

housesOverMil <- housePriceRanges[which(housePriceRanges == 24)]

housesOverMil |> length()


library(xlsx)

fileQ2 <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx", sheetIndex = 1)
dat <- fileQ2[18:23,7:15]

sum(dat$Zip*dat$Ext,na.rm=T)

##install.packages('XML')
library(XML)
library(xml2)
xmlUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xmlData <-  xmlParse(xmlUrl, useInternal = TRUE)

xmlData2 <- read_xml(xmlUrl)
xmlData2 |> xml_children()

zipCodes <- xmlData2 |> xml_find_all("//zipcode") |> xml_text()
d <- zipCodes[zipCodes == 21231]
d |> length()


install.packages(("data.table"))
library(data.table)
DT <- fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")
time(sapply(split(DT$pwgtp15,DT$SEX),mean))
