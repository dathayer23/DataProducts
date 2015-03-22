library(shiny)
source("Data/parseEarthQuakeData.R")

shinyServer(function(input,output) {
  
  output$eqPlot <- renderPlot({
    switch(input$plotType,
            "Num" = plotFreqByYearAndMagnitude(input$mag,input$maxYear),
            "Mag" = plotAbsMagByYearAndMagnitude(input$mag,input$maxYear))         
  } )
})