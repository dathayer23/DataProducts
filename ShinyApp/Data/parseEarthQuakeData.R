library(dplyr)

if (file.exists("Data/eqData3.RData")) {
   load("Data/eqData3.RData")
} else{
   createDataSet()
}

createDataSet <- function() {
  #download.file("http://earthquake.usgs.gov/data/centennial/centennial_Y2K.CAT", "centennial_Y2K.txt")
  centEQData <- file("Data/centennial_Y2K.txt", "rt")
  
  eqData1a <- read.fwf(centEQData, c(6,1,5,4,3,3,-1,3,3,6,-1,8,8,6,4,4,4, -1,2,-1,5, -143 ), stringsAsFactors = FALSE)
  
  summary(eqData1a)
  
  names <- c("SourceCatalog", "Asol", "Isol", "Year", "Month", 
             "Day", "Hour", "Minute", "Second", "Latitude", "Longitude", 
             "Depth", "Region", "Observations"
             , "Magnitude", "Scale", "Src")
  
  names(eqData1a) <- names
  close(centEQData)
  
  # remove statistical outlier Earthquake in 1960 in chile of 9.6
  eqData1 <- filter(eqData1a, Magnitude < 9.5)
  
  # result of querying for the latest earthquake data from the USGS website
  # http://earthquake.usgs.gov/earthquakes/search/
  # selected dates for search was from 2007-09-30 09:48:00 to 2015-03-19 25:59:59
  # selected magnitudes >= 6
  # all regions and entire globe
  # all sources and catalogs
  # any depth
  data2 <- read.csv("Data/query2007-2015.csv", header = TRUE, stringsAsFactors = FALSE)
  
  time2 = as.POSIXlt(data2$time)
  catalog <- replicate(nrow(data2), "ANSS")
  asol <- replicate(nrow(data2), "C")
  isol <- replicate(nrow(data2), "C")
  year <- time2$year + 1900
  month <- time2$mon
  day <- time2$mday
  hour <- time2$hour
  min <- time2$min
  sec <- time2$sec
  lat2 = data2$latitude
  long2 = data2$longitude
  depth2 = data2$depth
  Mag2 = data2$mag
  scale2 = data2$magType
  typ2 = data2$type
  
  eqData2b <- data.frame (catalog, asol, isol,year, month, day, hour, min, sec,
                          data2$latitude, data2$longitude, data2$depth, replicate(nrow(data2), -1),
                          replicate(nrow(data2), 1), data2$mag, data2$magType, 
                          replicate(nrow(data2), "Cent"),  data2$type)
  
  names2 <- c("SourceCatalog", "Asol", "Isol", "Year", "Month", 
              "Day", "Hour", "Minute", "Second", "Latitude", "Longitude", 
              "Depth", "Region", "Observations"
              , "Magnitude", "Scale", "Src", "Type")
  
  names(eqData2b) <- names2
  eqData2a <- filter(eqData2b, Type == 'earthquake')
  eqData2 <- select(eqData2a, -Type)
  eqData3 <- rbind(eqData1, eqData2)
  
  save(eqData3, file = "eqData3.RData")  
}


sumAbsMag <- function(mags, base) { sum((10 ^ (1.5 * (mags - base))))}
absMagForYear <- function(base, data, year) { sumAbsMag(filter(data, Year == year, Magnitude >= base)$Magnitude, base) }
numberForYear<- function(base, data, year) { length(filter(data, Year == year, Magnitude >= base)$Magnitude) }

countByYear <- function(base, maxyear) {
  years = unique(filter(eqData3, Year <= maxyear)$Year)
  sapply(years, function(year) {numberForYear(base, eqData3, year)})
} 

magByYear <- function(base, maxyear) {
  years = unique(filter(eqData3, Year <= maxyear)$Year)
  sapply(years, function(year) { absMagForYear(base, eqData3, year)})
}
 
plotFreqByYearAndMagnitude <- function(mag, year) { 
  barplot(countByYear(mag,year), 
          names.arg = 1900:year, space = 0.5, col = "green", border = NULL, main = "Number of Earth Quakes By Year",
          ylab = "Number of Earth Quakes")
}

plotAbsMagByYearAndMagnitude <- function(mag, year) { 
  barplot(magByYear(mag,year), 
          names.arg = 1900:year, space = 0.5, col = "green", border = NULL, main = "Sum of Earth Quake Relative Magnitude By Year",
          ylab = "Sum of Relative Magnitude")
}


