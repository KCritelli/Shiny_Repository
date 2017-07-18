


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
      plotlyOutput('plot2'),
      leafletOutput("mymap"),
      p(),
      actionButton("recalc", "New points"),
      h2('Counts by Race and Gender'),
        dataTableOutput('mytable1')
    )
  )
)