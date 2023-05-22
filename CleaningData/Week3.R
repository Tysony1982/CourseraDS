library(data.table)
library(dplyr)
library(readr)

# Question 1
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
file1 <- "data/CommunityServeyData.csv"
download.file(url1,file1)
# AGS > $10000 sales of agricultural products (value = 6)
agsLimit <- 10000
# ACR > 10 acres (value = 3)
acrLimit <- 10

# Create data frame from csv file
com_survey <- read_csv(file1)
# create a data table
com_survey_dt <- as.data.table(com_survey)


logicalVect1 <- com_survey_dt$AGS == 6 & com_survey_dt$ACR == 3

which(logicalVect1)

# Question 2
#install.packages("jpeg")
#install.packages("raster")
library(jpeg)
library(raster)
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
file2 <- "data/week3Image.jpeg"
download.file(url2, file2, , mode='wb')
r_array <- readJPEG(file2, native = TRUE)
#vec2 <- getValues(r_array)
r_array |> class()
quantile(r_array,0.30, na.rm = TRUE)
quantile(r_array,0.80, na.rm = TRUE)

# Question 3
url3_1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url3_2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
file3_1 <- "data/Week3q3_1.csv"
file3_2 <- "data/Week3Q3_2.csv"
download.file(url3_1,file3_1)
download.file(url3_2,file3_2)

# create dfs and dts
#df1 <- read_csv(file3_1,skip=5,col_names = c("CountryCode", "Rank", "Economy", "Total"),col_select = c(1,2,4,5),n_max = 206)
#df2 <- read_csv(file3_2)
#dt1 <- as.data.table(df1)
#dt2 <- as.data.table(df2)

FGDP <- data.table::fread(url3_1 #'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                          , skip=5
                          , nrows = 190
                          , select = c(1, 2, 4, 5)
                          , col.names=c("CountryCode", "Rank", "Economy", "Total")
)

# Download data and read FGDP data into data.table
FEDSTATS_Country <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')
                                      
merged_dt <- merge(FGDP, FEDSTATS_Country, by = "CountryCode")

nrow(merged_dt)

merged_dt[order(-Rank)][13,.(Economy)]

# Question 4
unique(merged_dt$`Income Group`)

highNon <- merged_dt[`Income Group` == "High income: nonOECD",.(x=mean(Rank, na.rm = TRUE))]
highOecd <- merged_dt[`Income Group` == "High income: OECD",.(x=mean(Rank, na.rm= TRUE))]
highNon
highOecd
