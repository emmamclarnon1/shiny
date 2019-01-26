#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(shiny)
library(DT)
library(lubridate
        )

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Testing harvest app"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(),
      
      # Show a plot of the generated distribution
      mainPanel(
         dataTableOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  
  
  today="2019-01-16"
  today=ymd(today)
  
  #Make dataframe
  veg=c("Onions", "Garlic", "Asparagus")
  sown=c(today)
  harv=(today+months(6))
  h2=today-years(1)
  harvest=c(harv,harv,h2)
  plants=data.frame(veg,sown,harvest)
  names(plants)=c("Vegetable", "Date_Sown", "Harvest_Date")
  
  
  
  plants2=plants%>%
    mutate(ready=case_when(Harvest_Date >= today() ~ "Not yet", TRUE~"Harvest"))
  
   output$distPlot <- renderDataTable({
     DT::datatable(plants2)%>%
       formatStyle(columns='ready',
                   backgroundColor = styleEqual(c('Not yet', 'Harvest'), c('white', 'yellow')))
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

