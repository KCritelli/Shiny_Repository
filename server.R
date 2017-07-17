deaths = read.csv('data/Drug_deaths.csv')




# Define server logic required to draw a histogram
function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    x    <- as.numeric(new_deaths[ ,5])
    bins <- seq(min(x, na.rm = T), max(x, na.rm = T), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'darkblue',border = 'white', alpha = 1)
  })
  
  
  output$mymap <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% addMarkers(lat = as.numeric(admits$latitude), lng = as.numeric(admits$longitude),clusterOptions = markerClusterOptions())
  })
}
