library(data.table)
library(dplyr)
library(readr)
library(purrr)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
file1 <- "data/Comm_Data.csv"

download.file(url,file1)
data1 <- read_csv(file1)
q <- names(data1) |> lapply(function(x) { strsplit(x,"wgtp")} )
q[123]


# Question 2
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
file2 <- "data/week4Q2.csv"

data2 <- fread(url2, 
                skip = 5,
               nrows = 190,
               col.names = c("CountryCode","Rank","Economy","MillionsOfDollars"),
               select = c(1,2,4,5))

data2[,numericDollars := gsub(",","",MillionsOfDollars)]
data2[,mean(as.numeric(numericDollars))]

# Question 3

grep("^United",data2[,Economy])


# Question 4
url4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
data4 <- fread(url4)

data4_1 <- data2[data4,on = .(CountryCode = CountryCode)]
data4_1[grepl(pattern = "Fiscal year end: June 30;", `Special Notes`), .N]

# Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sampleTimes |> class()
timeDT <- data.table::data.table(timeCol = sampleTimes)

# How many values were collected in 2012? 
timeDT[(timeCol >= "2012-01-01") & (timeCol) < "2013-01-01", .N ]
# Answer: 
# 250

# How many values were collected on Mondays in 2012?
timeDT[((timeCol >= "2012-01-01") & (timeCol < "2013-01-01")) & (weekdays(timeCol) == "Monday"), .N ]
