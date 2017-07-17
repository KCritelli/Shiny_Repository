library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)


new_deaths = separate(deaths, DeathLoc, into=c("city","Lat_Long"), sep="\n")
new_deaths = separate(new_deaths, Lat_Long, into=c("latitude","longitude"), sep=',')
new_deaths = new_deaths %>% mutate(.,latitude = substr(latitude,2,10))
new_deaths = new_deaths %>% mutate(.,longitude = substr(longitude,1,9))


# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Deaths from Opioid Use by Age"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      img(src = 'Mosaic.png', width = 700, height = 400),
      plotOutput('scatter'),
      leafletOutput('mymap')
    )
  )
)