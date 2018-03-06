

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Biopic Data"),
  
  sidebarLayout(
    sidebarPanel(
      
      selectInput("sex", label = h3("Select Sex"), c("Male", "Female"), selected = "Male")),
    
    mainPanel(
      plotOutput("sexEffect")
    )
  )
  
  
))
