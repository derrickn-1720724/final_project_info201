#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library("dplyr")

############ Racial Functions ######
## Get relevant entries that have both a known race and known income
## Filter data down to race, year, and box office revenue
race <- biopic %>% filter(race_known == "Known") %>% 
  filter(box_office != "-") %>%
  select(subject_race,year_release,box_office)
##filters data by input race and year range
getRacial <- function(input.race,input.year){
  race.byinput <- race %>% filter(subject_race == input.race) %>% select(year_release,box_office)
  if(input.year == "after 2000"){
    race.byinput %>% filter(year_release > 1999) %>% select(box_office) %>% getMoney() %>% return()
  } else {
    return(race.byinput)
  }
}

########### END OF RACE FUNCTIONS ##################

########### General Functions ####################

##Returns data frame with box office revenue converted to double.
## Data must be non-factor. stringsAsFactors = FALSE
getMoney <- function(money){
  money$box_office <- substr(money$box_office,2,nchar(money$box_office))
  scale <- substr(money$box_office,nchar(money$box_office),nchar(money$box_office))
  money$box_office <- as.double(substr(money$box_office,1,nchar(money$box_office)-1))
  if(scale == "K"){
    money$box_office <- money$box_office * .001
    return(money)
  } else {
    money$box_office <- money$box_office * 1
    return(money)
  }
} 




# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  ## Creates bar plot of input race vs box office revenue during input year range.
   output$raceGraph <- renderPlot({
     barplot(getRacial(input$race,input$year)$box_office,
             main = paste("Box office revenue for biopics featuring ",input$race," actors ",input$year,".",sep =""),
             xlab = "Films", ylab = "Revenue in millions of Dollars",
             col = "green"
             )
     
   })
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
