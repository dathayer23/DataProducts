#download.file("http://earthquake.usgs.gov/data/centennial/centennial_Y2K.CAT", "centennial_Y2K.txt")
centEQData <- file("centennial_Y2K.txt", "rt")
textData <- readLines(centEQData)
close(centEQData)

cat <- function(line) { stringr::str_trim(substr(line, 1, 6)) }
asol <- function(line) { stringr::str_trim(substr(line, 7, 7)) }
isol <- function(line) { stringr::str_trim(substr(line, 8, 12)) }
year <- function(line) { as.numeric(stringr::str_trim(substr(line, 13, 16))) }
month <- function(line) { as.numeric(stringr::str_trim(substr(line, 17, 19))) }
day <- function(line) { as.numeric(stringr::str_trim(substr(line, 20, 22))) }
day <- function(line) { as.numeric(stringr::str_trim(substr(line, 20, 22))) }
hour <- function(line) { as.numeric(stringr::str_trim(substr(line, 23, 26))) }
min <- function(line) { as.numeric(stringr::str_trim(substr(line, 27, 29))) }
sec <- function(line) { as.numeric(stringr::str_trim(substr(line, 30, 35))) }
latitude <- function(line) { as.numeric(stringr::str_trim(substr(line, 36, 44))) }
longitude <- function(line) { as.numeric(stringr::str_trim(substr(line, 45, 52))) }
depth <- function(line) { as.numeric(stringr::str_trim(substr(line, 53, 58))) }
region <- function(line) { as.numeric(stringr::str_trim(substr(line, 59, 62))) }
observations <- function(line) { as.numeric(stringr::str_trim(substr(line, 63, 66))) }
magnitude <- function(line) { as.numeric(stringr::str_trim(substr(line, 67, 70))) }
scale <- function(line) { stringr::str_trim(substr(line, 71, 74)) }
src <- function(line) { stringr::str_trim(substr(line, 75, 80)) }

names <- c("SourceCatalog", "Asol", "Isol", "Year", "Month", 
          "Day", "Hour", "Minute", "Second", "Latitude", "Longitude", 
          "Depth", "Region", "Observations", "Magnitude", "Scale", "Src")

data2 <- read.csv("query2007-2015.csv", header = TRUE, stringsAsFactors = FALSE)
initParsing <- function() {
  catv <- c("")
  asolv <- c("")
  isolv <- c("")
  yearv <- c(-1)
  monthv <- c(-1)
  dayv <- (-1)
  hourv <- c(-1)
  minv <- c(-1)
  secv <- c(0.0)
  latv <- c(-999)
  longv <- c(-999)
  depthv <- c(999)
  regionv <- c(-1)
  obsv <- c(-1)
  magv <- c(-1)
  scalev <- c(-1)
  srcv <- c("")
  
  df <- data.frame(catv, asolv, isolv,yearv,monthv,dayv,hourv, minv, secv, 
                   latv, longv, depthv, regionv, obsv, magv, scalev, srcv)
  
  names(df) <- names
  df
}


parseDataLine <- function(line, df) {
  d <- 
   data.frame(
    cat(line),
    asol(line),
    isol(line),
    year(line),
    month(line),
    day(line),
    hour(line),
    min(line),
    sec(line),
    latitude(line),
    longitude(line),
    depth(line),
    region(line),
    observations(line),
    magnitude(line),
    scale(line),
    src(line),
    stringsAsFactors = FALSE
    )
  
  names(d) <- names
  rbind(df, d)  
}
parseData <- function(data) {  
  df <- initParsing()
  for(i in 1:length(data)) {
    df <- parseDataLine(data[i], df)
  }
  
  df
}



