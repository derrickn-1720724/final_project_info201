#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage((tabsetPanel(
    tabPanel("Introduction",
           "Test1"   
    ),
    tabPanel("Gender vs Earnings",
    "Test2"  
    ),
    tabPanel("Race vs Earnings",
          "Test3"
    ),
    tabPanel("Number of Biopics by Race",
             "Test4"
    )
  )
  )
))
