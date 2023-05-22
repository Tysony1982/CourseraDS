
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
  zipUrl <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip"
  
  
  localFolder <- "RProgramming/Week2Assignments/"
  
  
  unzipFromUrl(zipUrl,localFolder)
}

outcome <- read.csv("RProgramming/Week2Assignments/outcome-of-care-measures.csv", colClasses = "character")

head(outcome)
summary(outcome)
dim(outcome)
ncol(outcome)
nrow(outcome)

outcome[,11] <- as.numeric(outcome[,11])

hist(outcome[,11])

names(outcome)

outcome <- "heart attack"
state <- "SC"

best <- function(state, outcome) {
  ## Read outcome data
  outcomes <- read_csv("RProgramming/Week2Assignments/outcome-of-care-measures.csv")
  
  columnName <- switch (
    outcome,
    "heart attack" = "Number of Patients - Hospital 30-Day Death (Mortality) Rates from Heart Attack",
    "heart failure" = "Number of Patients - Hospital 30-Day Death (Mortality) Rates from Heart Failure",
    "pneumonia" = "Number of Patients - Hospital 30-Day Death (Mortality) Rates from Pneumonia",
    stop("invalid outcome")
  )
  
  
  outcomeData <- outcomes |> 
                select(State,all_of("Hospital Name"),all_of(columnName)) |> 
                rename("oc" = !State & !"Hospital Name") |> 
                mutate("cleaned" = as.numeric(oc)) |> 
                filter(!is.na(cleaned)) |>
                select(State,"Hospital Name",cleaned)
  

  ## Return hospital name in that state with lowest 30-day death
  hospitalData <- outcomeData |> 
                    filter(State == state)
  ## if no state then throw error
  if (hospitalData |> nrow() == 0) stop("invalid state")
  
  ## Lowest Rate
  d <- hospitalData |> arrange(cleaned,"Hospital Name")
  d[1,]
}


#"heart attack" = outcomes["Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"],
#"pneumonia" = outcomes["Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"],
#"heart failure" = outcomes["Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"],

