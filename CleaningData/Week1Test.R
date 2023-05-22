library(httr)
library(purrr)

secret <- "3cf1b5f83727169ada4b39e8f8ad78d1ae584226"
client_id <- "424384f7fa44c2c31187"

oauth_endpoints("github")

my_app <- oauth_app("github",
                    key = client_id,
                    secret = secret)

github_token <- oauth2.0_token(oauth_endpoints("github"), my_app)

gtoken <- config(token = github_token)

req <- GET("https://api.github.com/users/jtleek/repos",gtoken)
stop_for_status(req)
data <- content(req)

#class(data)
#sapply(data, class)
#sapply(sapply(data,class),class)
#summary(data)

#s <- lapply(data,head)

lists <- data |> keep(~ .x$name == "datasharing")
q1 <- lists[[1]]["created_at"] 

print("Question 1 - %s" |> sprintf(q1))


#QUESTION 2
library(readr)
library(dplyr)
library(sqldf)

acs <- read_csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")
spec(acs)
sqldf("select pwgtp1 from acs where AGEP < 50")
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")

#Question 4
html <- read_lines("http://biostat.jhsph.edu/~jleek/contact.html")
html_lines <- html |> split("\n")
html_lines |> class()
line_count <- html_lines |> lapply(nchar)
line_count
print(sprintf("Question 4 - %s", line_count[[1]][c(10,20,30,100)]))


#Question 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
d <- read_csv(url)
d |> glimpse()
# Define the column widths and column names
fwf_widths <- c(11,5,5,5,5,5,5,5,5)
col_names <- c("Week (date)" , "Nino1+2 SST", "Nino1+2 SSTA", "Nino3 SST", "Nino3 SSTA", "Nino3+4 SST", "Nino3+4 SSTA", "Nino4 STT", "Nino4 STTA")

# Read the file
data <- read_fwf(url, fwf_widths(fwf_widths, col_names))

# Print the data
print(data)

data_clean <- data |> list_flatten()
data_clean
