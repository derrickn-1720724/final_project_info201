library(shiny)

shinyUI(fluidPage((tabsetPanel(
  
  tabPanel("Introduction",
           "Test1"   
  ),
  
  tabPanel("Gender vs Earnings",
           "Test2", 
           selectInput("sex", label = h3("Select Sex"), c("Male", "Female"), selected = "Male"),
           mainPanel(
                plotOutput("sexEffect")
            )
  ),
  
  tabPanel("Race vs Earnings",
           "Test3",
           selectInput("race", choices = unique(race$subject_race), label = "Subject's Race"),
           radioButtons("year", c("before 2000", "after 2000"),label = "Year released"),
           mainPanel(
                plotOutput("raceGraph")
           )
  ),
  
  tabPanel("Number of Biopics by Race",
           "Test4"
  )
)
)
))
