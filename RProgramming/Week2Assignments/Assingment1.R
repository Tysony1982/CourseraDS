setwd("C:/Users/tbetts/source/DataScience/RProjects/Coursera")

# Set the relative file path to the utilities.R file
file_path <- "./Utility/utilities.R"

# Source the file to load the my_function function into the global environment
source(file_path)

assignDir <-"RProgramming/Week2Assignments/"
unzippedFolderName <- "specdata"
unzippedFolder <- "specdata/"
dataDir <- paste(assignDir,unzippedFolder, sep="")

currentFiles <- list.files(assignDir)

if (!unzippedFolderName %in% currentFiles) {
  zipUrl <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
  
  
  localFolder <- "RProgramming/Week2Assignments/"
  
  
  unzipFromUrl(zipUrl,localFolder)
}

readFiles <- function(directory, id = 1:332) {
  
  allFileNames <- list.files(directory)
  # Just get the files required from the vector id
  fileNames <- allFileNames[id]
  filePaths <- sapply(fileNames, function(x) { paste(dataDir,x, sep="") })
  
  files <- lapply(filePaths, read.csv)
}


pollutantmean <- function(directory, pollutant, id = 1:332) {

  files <- readFiles(directory, id)
  
  combinedFiles = do.call(rbind,files)
  
  d <- combinedFiles[[pollutant]]
  
  mean(d, na.rm = TRUE)
  
}

complete <- function(directory,id = 1:332) {
  
  files <- readFiles(directory, id)
  
  getCountOfCompleteObs <- function(file) {
    recordId <- file$ID[[1]]
    completeRecords <- file[complete.cases(file),]
    matrix(c(recordId, nrow(completeRecords)),nrow = 1, ncol = 2)
  }
  
  listReturned <- lapply(files,getCountOfCompleteObs)
  
  df <- data.frame(do.call(rbind,listReturned))
  colnames(df) <- c("id","nobs")
  df
  
}


corr <- function(directory, threshold = 0) {
  allIds <- 1:332
  files <- readFiles(directory, allIds)
  dfOfObs <- complete(directory,allIds)
  ids <- dfOfObs[dfOfObs$nobs > threshold,]$id
  
  filesWithNas <- files[ids]
  filesToAnalyse <- lapply(filesWithNas,function(x) {x[complete.cases(x),]})
  
  func <- function(file) {
    cor(file["sulfate"],file['nitrate'])
  }

  correlations <- sapply(filesToAnalyse, func)
  as.vector(correlations)
}
