csvPath = paste(getwd(),"/RProgramming/hw1_data.csv", sep="")

csv <- read.csv(csvPath)

head(csv,2)

nrow(csv)

tail(csv,2)

csv[47,]

sum(is.na(csv$Ozone))

mean(csv$Ozone,na.rm = TRUE)

indexes <- csv$Ozone > 31 & csv$Temp > 90 & is.na(csv$Ozone) == FALSE 
subset <- csv[indexes,]
 
  
subset

mean(subset$Solar.R)


monthEq6 <- csv[csv$Month == 6, ]

mean(monthEq6$Temp)

monthEqMay <- csv[csv$Month == 5, ]

max(monthEqMay$Ozone[is.na(monthEqMay$Ozone) == FALSE], r.na = TRUE)
