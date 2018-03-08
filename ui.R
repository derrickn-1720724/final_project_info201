library(shinythemes)
library(shiny)
library(dplyr)

shinyUI(navbarPage("Biopics Data",theme = shinytheme("yeti"),
                   
  tabPanel("Introduction",
    titlePanel("Project Overview"),
    p("The report provides an overview on how several variables affect the outcome of how well biopics do
      in the theatre as reflected by their box office earnings. We also look at the main character's race to see if there
      has been an increase in different ethnicities being brought to the theatre."),
    h3("Audience"),
    p("While this might interest a number of groups, our intended audience is anyone with an interest in biopics
      or even just movies in general, and would like to see how their performance has changed over time."),
    h3("Data"),
    p("We obtained this data from the fivethirtyeight database. The data itself consists of biopics from the 1940's to 2014
      and tracks various statistics of the films, we focus on the subject's gender, race, and the film's total box office earnings."),
      a(href = "https://github.com/fivethirtyeight/data/blob/master/biopics/biopics.csv", "Biopics"),
    h3("Questions"),
    p("Some questions that we had:"),
    tags$ul(  
      tags$li("How does sex affect the earnings in the box office?"),
      tags$li("How does race affect the earnings in the box office?"),
      tags$li("How has the number of Biopics focusing on minorities changed over time?")
    ),
    
    h3("Structure"),
    p("The tabs each contain a graph focusing on one of our questions. The first
      tab contains information based on effect of a subject's sex in the box office. The second tab shows information
      about the effect of race, and the third tab shows the amount of films made featuring different ethnicities."),
    
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
    p("With the graph we can see the difference, how the race of subject affected box office earnings. 
      Before 2000, there weren't many biopics about African Americans, and box office earnings were low,
      but after 2000, the film industry began create more movies about African Americans, and box office earnings have improved."),
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
    p("With the graph, we can see some noticable differences. In earlier years, 
      the film industry and audiences didn't favor films featuring African American or minority actors or actresses. 
      Therefore, most African Americans played supporting roles. 
      However, as shown in the graph by increasing box office earning of films where a minority actor or actress played main character,
      over time, people's perception of African American actors and actresses improved"),
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



