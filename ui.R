fluidPage(
  
#Opioid Deaths in 2014- full page
#Begins with national perspective
  titlePanel(h1('Opioid Deaths Across the United States in 2014', align = 'center')),
  fluidRow(plotOutput('mapping')),
  
  fluidRow(
    column(width = 1, br()),
    column(width = 10, h2('Background',align = 'center',br(),
  h4("At the end of 2016, a Stat News article declared that over 50,000 Americans had died of drug overdoses, 
the most ever recorded in the course of a year. The article highlighted the growing national
abuse of heroin and prescription painkillers. In light of this national crisis, 
this project focuses a spotlight on the state of Connecticut. 
Using opioid use datasets from 2014-2016, demographic, educational, and geographic factors are examined to answer the following questions:
      1) Which populations have been hardest hit by the opioid crisis?
    2) How can the government intervene most effectively to prevent deaths?"
  ),em('Sources: 
http://www.courant.com/data-desk/hc-report-connecticut-income-gap-highest-in-the-nation-20150206-htmlstory.html
http://www.courant.com/breaking-news/hc-ocme-overdose-numbers-0224-20170223-story.html
https://ctmirror.org/2013/11/08/nations-report-card-ct-continues-show-largest-achievement-gap/
https://www.statnews.com/2016/12/09/opoid-overdose-deaths-us/
'))),
    column(width = 1, br())),
  
#Map of deaths
fluidRow(
  column(width = 8, h3('Map of Opioid Deaths in CT in 2014', align = 'center'), leafletOutput("mymap")),
    
  column(width = 4, br(),h3('Why Connecticut?'),br(),
p('-Connecticut has been hit hard by the national opioid crisis, which appears to be growing and gaining local and national concern'),
p('-Connecticut is a state of extremes. It has one of the largest educational achievement gaps in the country, according to the Department of Education, and it boasts the largest income gap, according to the Economic Analysis and Research Network'),
p('-Connecticut offers an interesting model for study: Opioid use and prescription data is readily available, different demographic and social extremes are open to analysis, and the question of how to quell the medical crisis remains unresolved'),
align = 'center')),


#Histogram and Slider
fluidRow(
    
  column(width = 4, br(), br(),br(),br(),br(),br(),br(),br(),br(), br(),br(),
    sliderInput("bins","Number of bins:", min = 1, max = 50, value = 30), align = 'center'),

  column(width = 8, h4('Deaths from Opioid Use by Age', align = 'center'),
    plotOutput("distPlot"))),


#Datatable and Statistics
fluidRow(
  
  wellPanel(
  dataTableOutput('mytable1')       
  )),

fluidRow(
  column(width = 1, br()),
  column(width = 10,
         h3('Statistical analysis on the table of races and genders', align = 'center'),
         code("Demographic_Group = c('White M', 'White F', 'Hispanic M','Hispanic F',
                                    'Black M','Black F','Asian M','Asian F','Other M','Other F')
              Opioid_Deaths = c(1746,685,257,60,179, 71,11,5,22,5)
              CT_Population_Numbers = c(1345691,1434663,155036,165286,
                                        149964,159878,39839,42472,90137,96096)"),br(),br(),
         code("race_breakdown = data.frame(Demographic_Group,Opioid_Deaths,CT_Population_Numbers)"),br(),br(),
         
         code("chisq.test(race_breakdown)
      Pearson's Chi-squared test

      data:  race_breakdown[1:10, 2:3]
      X-squared = 944.13, df = 9, p-value < 2.2e-16"),br(),br(),br()),
  column(width = 1, br())),

#Scatterplots
fluidRow(
  column(width = 8, br(), plotlyOutput('plot2'), br()),
  
  column(width = 4, h3('Education'),p('This scatter plot examines the correlation between education level and proportions of opioid-related deaths.
                      SAT benchmark achievement, or the percentage of students in a town meeting SAT benchmarks, is used as a comparative measure of educational achievement.
                      The number of opioid-related deaths was measured in each town and then normalized by population.'), code('cor(SAT_dc$Benchmark.x, SAT_dc$Proportion)'),br(),
         code('[1] -0.5599098'))),
  
                         

fluidRow(
  column(width = 8, br(), plotlyOutput('plot4'), br()),
  
  column(width = 4, h3('Wealth'),p('This scatter plot examines the correlation between wealth and proportions of opioid-related deaths.
                                   Tax per capita is used as a proxy for wealth and is compared across towns. The number of opioid-related
                                   deaths was measured in each town and then normalized by population.'), code('cor(cor_income$Proportion, cor_income$Tax.Per.Capita)
              [1] -0.4494215'))),

fluidRow(
  column(width = 8, plotlyOutput('plot3'), br(), br()),
  
  column(width = 4, h3('Medical Sources'),p('This plot examines a dataset documenting medical prescriptions for opioids
                                           written in Connecticut in the year 2014. It examines how many clinicians in each specialty were recorded prescribing opioids.
                                           Notably, this plot does not take into account how many prescriptions individual providers wrote.'))
),

#Map of Treatments/deaths
fluidRow(
  column(width = 8, h4('Overlap Between Treatment Centers and Locations of Death in 2016', align = 'center'), leafletOutput('life_death'),br(),br()),
  
  column(width = 4, h3('Treatment Admissions'),p('This plot maps town level data depicting the number of admissions in treatment programs funded or operated by the Department of Mental Health against the number of deaths in the year 2016.
                                                 The viewer is able to visually see where treatment services are utilized and where they are under-utilized or non-existent.', align = 'center'))    
)
)



