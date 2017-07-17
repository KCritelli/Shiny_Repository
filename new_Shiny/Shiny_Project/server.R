library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)
library(leaflet)

deaths = read.csv('data/Drug_deaths.csv')

new_deaths = separate(deaths, DeathLoc, into=c("city","Lat_Long"), sep="\n")
new_deaths = separate(new_deaths, Lat_Long, into=c("latitude","longitude"), sep=',')
new_deaths = new_deaths %>% mutate(.,latitude = substr(latitude,2,10))
new_deaths = new_deaths %>% mutate(.,longitude = substr(longitude,1,9))
new_deaths[new_deaths==""] <- NA
new_deaths <- new_deaths[!is.na(new_deaths$Age),]

admits = read.csv('data/Treatment_admissions.csv')
admits[admits==""] <- NA
admits <- admits[!is.na(admits$Admissions),]
admits = separate(admits, TownGeo, into=c("city","Lat_Long"), sep="\n")
admits = separate(admits, Lat_Long, into=c("latitude","longitude"), sep=',')
admits = admits %>% mutate(.,latitude = substr(latitude,2,10))
admits = admits %>% mutate(.,longitude = substr(longitude,1,9))

Income_tax = read.csv('data/Income_tax.csv')
Income_tax = Income_tax %>% filter(.,Tax.Year == '2015') %>% group_by(.,Municipality) %>% rename(.,Residence.City = Municipality)
Income_tax$Tax.Per.Capita = as.numeric(sub('$','',as.character(Income_tax$Tax.Per.Capita),fixed=TRUE))
Cities_income = left_join(counties, Income_tax, by = 'Residence.City') 
Cities_income <- Cities_income[!is.na(Cities_income$Tax.Per.Capita),]
Cities_income = Cities_income %>% group_by(.,Residence.City) %>% summarise(.,Mean.tax = mean(Tax.Per.Capita))
income_to_counts = inner_join(death_subset,Cities_income, by = 'Residence.City')



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
  
  output$scatter <- renderPlot({
    plot(income_to_counts$Counts,income_to_counts$Mean.tax)
  })
  
  output$mymap <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% addMarkers(lat = as.numeric(admits$latitude), lng = as.numeric(admits$longitude),clusterOptions = markerClusterOptions())
  })
}


