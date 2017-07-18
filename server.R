


# Define server logic required to draw a histogram
function(input, output) {
  output$mytable1 = renderDataTable({
    rb
  })
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    x    <- as.numeric(new_deaths[,6])
    bins <- seq(min(x, na.rm = T), max(x, na.rm = T), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'darkblue',border = 'white', alpha = 1)
  })
  
  output$plot = renderPlotly({
    plot_ly(x = new_deaths$Age, type = "histogram")  
  })
  
  output$plot2 = renderPlotly({
    xaxis <- list(
      title = "Proportion Dead (Count/Total Population)"
    )
    yaxis <- list(
      title = "% Achieving SAT Benchmark"
    )
    fit <- lm(SAT_dc$Benchmark.x ~ SAT_dc$Proportion, data = SAT_dc)
    plot_ly(SAT_dc, x = SAT_dc$Proportion,y = SAT_dc$Benchmark.x, mode = 'markers') %>% 
      layout(title = "Correlation: Education (SAT) vs. Proportion Dead", xaxis = xaxis, yaxis = yaxis) 
  })
  
  output$mymap <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% addMarkers(lat = as.numeric(admits$latitude), lng = as.numeric(admits$longitude),clusterOptions = markerClusterOptions())
  })
}

