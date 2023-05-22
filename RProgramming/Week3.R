# Set the relative file path to the utilities.R file
file_path <- "./Utility/utilities.R"

# Source the file to load the my_function function into the global environment
source(file_path)

library(datasets)
head(airquality)

s <- split(airquality, airquality$Month)
s

meansAq <-sapply(s, function(x) {colMeans(x[, c("Ozone", "Solar.R","Wind")], na.rm = TRUE)}) 
meansAq

tapply(mtcars$mpg,mtcars$cyl,mean)


