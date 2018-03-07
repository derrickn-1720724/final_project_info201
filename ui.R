library(shinythemes)
library(shiny)
library(dplyr)

shinyUI(navbarPage("Biopics Data",theme = shinytheme("yeti"),
                   
  tabPanel("Introduction",
    titlePanel("Project Overview"),
    p("The report provides an overview on how several variables affect the outcome of how well biopics do
      in the theatre based on their box office earnings. We also look at the main character's race to see if their
      has been an increase in different ethnicities being brought to the theatre."),
    h3("Audience"),
    p("While this may be interesting to anyone, our intended audience at first was for anyone who enjoyed movies or biopics
      more specifically and would like to see how things have changed over time."),
    h3("Data"),
    p("We obtained this data from the fivethirtyeight database. The data itself has the biopics from the 1940's
      and the main character's gender, race, and the total box office earnings."),
      a(href = "https://github.com/fivethirtyeight/data/blob/master/biopics/biopics.csv", "Biopics"),
    h3("Questions"),
    p("Some questions that we had:"),
    tags$ul(  
      tags$li("How does sex affect the earnings in the box office?"),
      tags$li("How does race affect the earnings in the box office?"),
      tags$li("How has the amount of Biopics that focused on minorities changed?")
    ),
    
    h3("Structure"),
    p("The tabs each contain a different graph focusing on the different questions that we had. The first
      tab contains information based on the sex affect in the box office. The second tab shows the information
      about the affect of race and the third tab shows the amount of movies that show the different races.
      Each data"),
    
    h3("Project Creators"),
    tags$ul(
      tags$li("Derrick Nguyen"),
      tags$li("Chaehyung Hwang"),
      tags$li("Jacob Nelson")
    )
  ),  
  
  tabPanel("Gender Impact on Box office",
    titlePanel("Box office Earning By Sex of Subject"),
    p("With the graph we can see the difference between average box office earnings between both races.
      We can see that on average between both races that male leads are are often earning more. 
      However, the past few years have shown that females are starting to attract more viewers to the movies thus earning themselves more through the box office."
    ),
    sidebarLayout(
      sidebarPanel(
        selectInput("sex", label = h3("Select Sex"), choices = unique(c("Male", "Female")), selected = "Male")
      ),
      
      mainPanel(
        plotOutput("sexEffect")
      )
    )
  ),
  
  tabPanel("Race Impact on Box office Before 2000 and After 2000",
    titlePanel("Box office Earning Over Time by Race of Subject"),
    p("With the grah we can see the difference, how the race of subject affected box office earning. 
      Before 2000, there weren't many movies about African American, and box office earning was low,
      but after 2000, film industries created more movies about African American, and the box office earning have increased."),
    sidebarLayout(
      sidebarPanel(
        selectInput("race", choices = unique(c("White", "African American")), label = "Subject's Race"),
        radioButtons("year", c("before 2000", "after 2000"),label = "Year released")
      ),
      mainPanel(
        plotOutput("raceGraph")
      )
    )
  ), 
  
  tabPanel("Race of main character impact on box office earning",
    titlePanel("Box office Earning over Time by main character's race"),
    p("With the graph, we can see the difference. In the past, 
      film industries and the people didn't favor African American or minority actor or actress. 
      Therefore, most African American played supporting role. 
      However, as shown in the graph by increasing box office earning of the film that minority actor or actress played main character,
      over time, people's perception to African American actor and actress changed"),
    sidebarLayout(
      sidebarPanel(
        selectInput("main_c_race", label = "Main character's race", choices = c("White", "African American", "Overall")),
        sliderInput(inputId = "year_choice", label = "Year", min = 1930, max = 2014, value = c(1930, 2014), sep = '')
        
      ),
      
      mainPanel(
        plotOutput("main_c_race")
      )
    )
  )  
))



