best <- function(state, outcome){
  if(!dir.exists("./data")) dir.create("./data")
  if(!file.exists("data/outcome-of-care-measures.csv")){
    url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip"
    temp <- tempfile()
    download.file(url, temp)
    unzip(temp, exdir = "./data")
    unlink(temp)
  }
  data <- read.csv("data/outcome-of-care-measures.csv", 
                   colClasses = "character")
  ##check whether the state is valid
  if(!state %in% data$State) stop("invalid state")
  ##check the validity of outcome
  outcome.list <- c("heart attack", "heart failure", "pneumonia")
  if(!outcome %in% outcome.list) stop("invalid outcome")
  ##select the outcome column
  index <- which(outcome.list %in% outcome)
  outcome.index <- c(11, 17, 23)[index]
  ##arrange and return data
  data <- data[data$State == state, ]
  suppressWarnings(data[, outcome.index] <- 
                     as.numeric(data[, outcome.index]))
  data <- data[order(data[, outcome.index], data[,2]), ]
  data[1,2]
}

##Function to rank hospitals by outcome in a state

rankhospital <- function(state, outcome, num="best"){
  if(!dir.exists("./data")) dir.create("./data")
  if(!file.exists("data/outcome-of-care-measures.csv")){
    url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip"
    temp <- tempfile()
    download.file(url, temp)
    unzip(temp, exdir = "./data")
    unlink(temp)
  }
  data <- read.csv("data/outcome-of-care-measures.csv", 
                   colClasses = "character")
  ##check whether the state is valid
  if(!state %in% data$State) stop("invalid state")
  ##check the validity of outcome
  outcome.list <- c("heart attack", "heart failure", "pneumonia")
  if(!outcome %in% outcome.list) stop("invalid outcome")
  ##select the outcome column
  index <- which(outcome.list %in% outcome)
  outcome.index <- c(11, 17, 23)[index]
  ##arrange and return data
  data <- data[data$State == state, ]
  data[, outcome.index] <- suppressWarnings(
    as.numeric(data[, outcome.index]))
  data <- data[order(data[, outcome.index], data[, 2]), ]
  data <- data[!is.na(data[, outcome.index]), ]
  ##converting best and worst to numbers
  if(num == "best") num <- 1
  if(num == "worst") num <- nrow(data)
  data[num,2]
}

##rank hospitals in all states

rankall <- function(outcome, num = "best"){
  if(!dir.exists("./data")) dir.create("./data")
  if(!file.exists("data/outcome-of-care-measures.csv")){
    url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip"
    temp <- tempfile()
    download.file(url, temp)
    unzip(temp, exdir = "./data")
    unlink(temp)
  }
  data <- read.csv("data/outcome-of-care-measures.csv", 
                   colClasses = "character")
  ##check the validity of outcome
  outcome.list <- c("heart attack", "heart failure", "pneumonia")
  if(!outcome %in% outcome.list) stop("invalid outcome")
  ##select the outcome column
  index <- which(outcome.list %in% outcome)
  outcome.index <- c(11, 17, 23)[index]
  data[, outcome.index] <- suppressWarnings(
    as.numeric(data[ , outcome.index]))
  data <- data[!is.na(data[, outcome.index]), ]
  ##for each state give the hospital of a given rank
  states <- sort(unique(data$State))
  hospitals <- NULL
  for(i in states){
    rank <- num
    ##arrange and return data
    state.data <- data[data$State == i, ]
    ##converting best and worst to numbers
    state.data <- state.data[order(state.data[, outcome.index], 
                                   state.data[, 2]), ]
    if(rank == "best") rank <- 1
    if(rank == "worst") rank <- nrow(state.data)
    hospital <- state.data[rank, 2]
    hospitals <- c(hospitals, hospital)
  }
  
  
  ##return and print the result data frame
  (output <- cbind(hospitals, states))
}

helper <- function(data, outcome, num){
  hospital <- data[, 2][order(outcome, data[, 2])[num]]
  hospital
}
rankall <- function(outcome, num = "best") {
  data <- read.csv(file="RProgramming/Week2Assignments/outcome-of-care-measures.csv", colClasses = "character")
  reason <- c("heart attack", "heart failure", "pneumonia")
  state_arr <- sort(unique(data$State))
  arr_len <- length(state_arr)
  hospital <- rep("", arr_len)
  if(!outcome %in% reason){
    stop("invalid outcome")
  } else {
    for(i in 1:arr_len){
      goal <- data[data$State == state_arr[i], ]
      if(outcome == "heart attack"){
        attack <- as.numeric(goal[, 11])   
        len <- dim(goal[!is.na(attack),])[1]
        if(num == "best"){
          hospital[i] <- helper(goal, attack, 1)
        } else if(num == "worst"){
          hospital[i] <- helper(goal, attack, len)
        } else if(num > len){
          hospital[i] <- NA
        } else{
          hospital[i] <- helper(goal, attack, num)
        }          
      }
      else if(outcome == "heart failure" ){ # Attention here!
        failure <- as.numeric(goal[, 17])   
        len <- dim(goal[!is.na(failure),])[1]
        if(num == "best"){
          hospital[i] <- helper(goal, failure, 1)
        } else if(num == "worst"){
          hospital[i] <- helper(goal, failure, len)
        } else if(num > len){
          hospital[i] <- NA
        } else{
          hospital[i] <- helper(goal, failure, num)
        } 
      }
      else{
        pneumonia <- as.numeric(goal[, 23])
        len <- dim(goal[!is.na(pneumonia),])[1]
        if(num == "best"){
          hospital[i] <- helper(goal, pneumonia, 1)
        } else if(num == "worst"){
          hospital[i] <- helper(goal, pneumonia, len)
        } else if(num > len){
          hospital[i] <- NA
        } else{
          hospital[i] <- helper(goal, pneumonia, num)   
        } 
      }  
    }
    df <- data.frame(hospital = hospital, state = state_arr)
    df
  }
}