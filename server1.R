#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
  biopic <- read.csv("data/biopics.csv", stringsAsFactors = FALSE)

  
  
  output$sexEffect <- renderPlot({
    
    library(dplyr)
    
    biopic_money <- filter(biopic, subject_sex == input$sex) %>%
    select(year_release, box_office) %>%
    filter(box_office != "-") 
    
    getMoney <- function(money){
      money$box_office <- substr(money$box_office,2,nchar(money$box_office))
      scale <- substr(money$box_office,nchar(money$box_office),nchar(money$box_office))
      money$box_office <- as.double(substr(money$box_office,1,nchar(money$box_office)-1))
      if(scale == "K"){
        money$box_office <- money$box_office * 1000
        return(money)
      } else {
        money$box_office <- money$box_office * 1000000
        return(money)
      }
    } 
    
    biopic_filter <- getMoney(biopic_money)

    return(ggplot(biopic_filter, aes(year_release, box_office)) + geom_bar(stat = "identity")
        + labs(title = "Average Box Office Earnings", x = "Year Of Release", y = "Box Office Earnings"))
    
  })
  
})
