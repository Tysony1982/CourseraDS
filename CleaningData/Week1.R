library(rstudioapi)
library(xlsx)
oldPath <- gewd()
e <- getSourceEditorContext()$path
dn <- dirname(e)
setwd(dn)
getwd()

sampleUrl <- "https://github.com/datablist/sample-csv-files/raw/main/files/organizations/organizations-100.csv"
sampleFn <- "csv_example.csv"
csvData <- read.table("./FSharp/csv_example.csv", sep = ',', header = TRUE)

if (!file.exists(sampleFn)) {
  download.file(sampleUrl, sampleFn)
}

csv2 <- read.table(sampleFn, sep = ",", header = TRUE)

summary(csv2)


xlsxUrl <- "https://wri-dataportal-prod.s3.amazonaws.com/manual/local_government_renewables_action_tracker_dec_2022.xlsx"
xlsxFn <- "X.xlsx"

if (!file.exists(xlsxFn)) {
  download.file(xlsxUrl,xlsxFn)
}

xslxFile <- read.xlsx(xlsxFn, sheetIndex = 1, colIndex = 1, rowIndex = 2)
