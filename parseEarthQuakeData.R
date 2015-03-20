#download.file("http://earthquake.usgs.gov/data/centennial/centennial_Y2K.CAT", "centennial_Y2K.txt")
centEQData <- file("centennial_Y2K.txt", "rt")

eqData <- read.fwf(centEQData, c(6,1,5,4,3,3,-1,3,3,6,-1,8,8,6,4,4,4, -1,2,-1,5, -143 ), stringsAsFactors = FALSE)
names <- c("SourceCatalog", "Asol", "Isol", "Year", "Month", 
           "Day", "Hour", "Minute", "Second", "Latitude", "Longitude", 
           "Depth", "Region", "Observations"
           , "Magnitude", "Scale", "Src")

names(eqData) <- names
close(centEQData)



data2 <- read.csv("query2007-2015.csv", header = TRUE, stringsAsFactors = FALSE)

#eqData2 <- transmute(data2, Year = as.POSIXlt(time), Month = as.POSIXlt(time), Day = as.POSIXlt(time), 
#                     Hour = as.POSIXlt(time), Minute = as.POSIXlt(time), Sec = as.POSIXlt(time),
#                    Latitude = latitude, Longitude = longitude,  Depth = depth,  Magnitude = mag, 
#                     Scale = magType, Type = type)
#


