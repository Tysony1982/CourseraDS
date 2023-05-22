install.packages("RMySQL")

source("http://bioconductor.org/biocLite.R")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.16")

library(BiocManager)

library(RMySQL)

uscDb <- dbConnect(MySQL(), user="genome",host="genome-mysql.cse.ucsc.edu")

result <- dbGetQuery(uscDb, "show databases;"); dbDisconnect(uscDb)
result

hg19 <- dbConnect(MySQL(), user="genome",host="genome-mysql.cse.ucsc.edu", db = "hg19")

allTables <- dbListTables(hg19)

allTables |> length()

allTables[1:5]

hg19 |> dbListFields("encTfChipPkENCFF525EJQ")

hg19 |> dbGetQuery("SELECT count(*) from encTfChipPkENCFF525EJQ")

encData <- hg19 |> dbReadTable("encTfChipPkENCFF525EJQ")

head(encData)


query <- dbSendQuery(hg19, "SELECT * from encTfChipPkENCFF525EJQ")

affMis <- fetch(query)

quantile(affMis$chromStart)

smallerSet <- query |> fetch(n= 10)

dbClearResult(query)

dbDisconnect(hg19)

BiocManager::install("rhdf5")
library(rhdf5)

created <- h5createFile("example.h5")

oldwd <- getwd()
newWd <- paste(oldwd,"/CleaningData", sep = "")
setwd(newWd)

h5FileName <- "example.h5"

created <- h5createFile(h5FileName)
created <- h5createGroup(h5FileName, "foo")
created <- h5createGroup(h5FileName, "baa")
created <- h5createGroup(h5FileName, "foo/foobaa")

h5ls(h5FileName)


setwd(oldWd)


library(httr)
library(xml2)

url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ"
html2 <- GET(url)

content2 <- content(html2, as="text")
parsedHtml <- read_html(content2, asText=TRUE)

title <- xml_text(xml_find_first(parsedHtml, "//title"))
title


#Github
secret <- "483233a6d2d31be4155851bef8c3a120e3727b42"
clientId <- "424384f7fa44c2c31187"












