library(shiny)

shinyUI(fluidPage(
  
  #Application Title
  titlePanel("Counts and Summary of Magnitude for Earth Quakes between 1900 and 2015"),
  
  sidebarLayout(
  sidebarPanel(
    
    p("This selects the minimum earth quake magnitude that will be used in calculating the plot.  For instance if you select 7.25 then only earth quakes in each year that had a magnitude greater than 7.25 will be used in the plot calculations."),  
    sliderInput("mag", "Minimum Magnitude to Plot",
                min = 5.0,
                max = 8.0,
                value = 6.0,
                step = 0.25),
    
    p("This selects the maximum year for which the data is examined.  If you select 1960 then only earth quake records from 1900 - 1960 will be examined to calculate the plot."),
    sliderInput("maxYear", "Maximum Year to Examine",
                min = 1925,
                max = 2015,
                value = 2015,
                sep = ""),
    p("There are two different plot calculations that can be displayed."),
    p("The first type is simply the number of earth quakes that occured during the year in question."),
    p("The second type takes the minimum earth quake magnitude specified and calculates the energy, relative to this value as 1, of the earthquakes selected for analysis.  These relative energies are then summed to get a total for the entire year. Since we are using relative terms these values are unitless"),
    selectInput("plotType", label = h3("Select Plot Type"), 
                choices = list("Number of Earth Quakes per Year" = "Num", 
                               "Sum of Quake Magnitude per Year" = "Mag"), 
                selected = 1)
    
    
  ),
    
    
  
  mainPanel(
    h4("Plot of earthquakes by year"),
    p("Earth quake data was gathered from two sources"),
    p("For earth quakes between 1900 - 2007 the USGS Centennial Data was used"),
    p("For data newer then 2007 the USGS ANSS Comprehensive Catalog was queried for all data beyond the end point of the Centennial data set.  These two data sets were then merged and made available in R as a data frame."),
    plotOutput("eqPlot")
    ) #,
  
  #position = c("left", "right")
  )
  ))

