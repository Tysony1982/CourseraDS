

# Funtion to download zipped file from url and place into required directory
unzipFromUrl <- function(zipUrl, unZipLocation) {
  #zipUrl <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
  
  # Define the local file path and folder where you want to save the zip file and its contents
  local_file <- "data.zip"
  #local_folder <- "RProgramming/Week2Assignments/"
  
  # Download the zip file from the URL to your local machine
  download.file(zipUrl, destfile = local_file, mode = "wb")
  
  # Extract the contents of the zip file into the specified folder
  unzip(local_file, exdir = unZipLocation)
  
  unlink(local_file)
}