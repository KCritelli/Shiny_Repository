#All relevant libraries 
library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)
library(leaflet)

#All necessary files
deaths = read.csv('data/Drug_deaths.csv')
new_deaths = read.csv('data/new_deaths.csv')
SAT_dc = read.csv('data/SAT_death_cor.csv')
cor_income = read.csv('data/cor_income.csv')
CT_Towns = read.csv('data/CT_Towns.csv')
SAT_death_cor = read.csv('data/SAT_death_cor.csv')
death_counts_income = read.csv('data/death_counts_income.csv')
admits = read.csv('data/admits.csv')
state_deaths = read.csv('data/state_deaths.csv')
pres = read.csv('data/pres.csv')

#Mapping deaths per Population: Header
ggplot(data = state_deaths, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group, fill = Deaths_per_population)) + labs(fill = "Deaths/\nPopulation") 

#Datatable
Demographic_Group = c('White M', 'White F', 'Hispanic M','Hispanic F',
                      'Black M','Black F','Asian M','Asian F','Other M','Other F')
Opioid_Deaths = c(1746,685,257,60,179,71,11,5,22,5) 
Per_Opioid_Deaths = c(57.4,22.5,8.5,2.0,5.9,2.3,.4,.2,.7,.2)
CT_Population_Numbers = c(1345691,1434663,155036,165286,
                          149964,159878,39839,42472,90137,96096)
Per_CT_Population = c(36.6,39.0,4.2,4.5,4.1,4.3,1.1,1.2,2.4,2.6)
race_breakdown = data.frame(Demographic_Group,Opioid_Deaths, Per_Opioid_Deaths,
                            CT_Population_Numbers,Per_CT_Population)

#Icons for Treatment/Deaths Map
#Definition of the skulls icon used in the Treatment/Deaths Map
skulls <- makeIcon(
  iconUrl = "https://d30y9cdsu7xlg0.cloudfront.net/png/1962-200.png",
  iconWidth = 20, iconHeight = 20,
  iconAnchorX = 22, iconAnchorY = 94
)

#Definition of the redCross icon used in the Treatment/Deaths Map
redCross <- makeIcon(
  iconUrl = "http://icons.iconarchive.com/icons/devcom/medical/64/red-cross-icon.png",
  iconWidth = 20, iconHeight = 20,
  iconAnchorX = 22, iconAnchorY = 94
)
