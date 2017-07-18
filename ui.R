


# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel(h1('Opioid Deaths Across the United States in 2014', align = 'center')),
  fluidRow(plotOutput('mapping')),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(sliderInput("bins",
                             "Number of bins:",
                             min = 1,
                             max = 50,
                             value = 30)

    ),
    
    # Show a plot of the generated distribution
    mainPanel( 
      h3('Deaths from Opioid Use by Age', align = 'center'),
      plotOutput("distPlot"),
      h2('Map of Opioid Deaths in CT in 2014', align = 'center',
      leafletOutput("mymap")),
      h3('Counts by Race and Gender', align = 'center'),
      dataTableOutput('mytable1'),
      plotlyOutput('plot2'),
      p(),
      plotlyOutput('plot3')
    )
  )
)
