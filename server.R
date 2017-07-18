


# Define server logic required to draw a histogram
function(input, output) {
  
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot
  output$mapping = renderPlot({
    ggplot(data = state_deaths, aes(x = long, y = lat)) +
      geom_polygon(aes(group = group, fill = Deaths_per_population)) +labs(x = " ",y = " ") + labs(fill = "Deaths/\nPopulation") 
  })
  
  output$distPlot <- renderPlot({
    Ages    <- as.numeric(new_deaths[,6])
    bins <- seq(min(Ages, na.rm = T), max(Ages, na.rm = T), length.out = input$bins + 1)
    hist(Ages, breaks = bins, col = 'darkblue',border = 'white', alpha = 1)
  })
  
  output$mytable1 = renderDataTable({
    rb
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
    plot_ly(SAT_dc, x = SAT_dc$Proportion,y = SAT_dc$Benchmark.x, mode = 'markers', text = SAT_dc$Residence.City) %>% 
      layout(title = "Correlation: Education (SAT) vs. Proportion Dead", xaxis = xaxis, yaxis = yaxis) 
  })
  
  output$plot4 = renderPlotly({
    xaxis <- list(
      title = "Proportion Dead (Count/Total Population)"
    )
    yaxis <- list(
      title = "Mean Tax per Capita (Proxy Measure for Wealth)"
    )
    fit <- lm(cor_income$Tax.Per.Capita ~ cor_income$Proportion, data = cor_income)
    plot_ly(cor_income, x = cor_income$Proportion,y = cor_income$Tax.Per.Capita, mode = 'markers', text = cor_income$Residence.City) %>% 
      layout(title = "Correlation: Income (Measure:Tax) vs. Proportion Dead", xaxis = xaxis, yaxis = yaxis) 
  })
  
  output$mymap <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% addMarkers(lat = as.numeric(new_deaths$latitude), lng = as.numeric(new_deaths$longitude),clusterOptions = markerClusterOptions())
  })
  
  output$life_death <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% addMarkers(lat = as.numeric(new_deaths$latitude), lng = as.numeric(new_deaths$longitude), icon = skulls, group = 'Deaths') %>% addMarkers(lat = as.numeric(admits$latitude), lng = as.numeric(admits$longitude), icon = redCross, group = 'Seeking Treatment') %>% 
      addLayersControl(
        baseGroups = c(),
        overlayGroups = c("Deaths", "Seeking Treatment"),
        options = layersControlOptions(collapsed = FALSE))
  })
  
  output$plot3 = renderPlotly({
    plot_ly(x = pres$Specialty, y = pres$Number_Prescriptions, type = 'bar', orientation = 'v')%>% layout(barmode = "stack") %>% 
      layout(margin = list(b = 150), xaxis = list(tickangle = 90)) %>% 
      layout(title = 'Count of Opioid Prescriptions Written by Medical Specialty')
  }) 
}

