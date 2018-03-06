library(shiny)
<<<<<<< HEAD
library(dplyr)
library(ggplot2)
=======
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



>>>>>>> 5dc259817a4a2bf3386fe701997a52d2b5e7983e

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  ## Creates bar plot of input race vs box office revenue during input year range.
<<<<<<< HEAD
  biopic <- read.csv("data/biopics.csv", stringsAsFactors = FALSE)
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
  
  getRacial <- function(input.race, input.year){
    race.byinput <- race %>% filter(subject_race == input.race) %>% select(year_release,box_office)
    if(input.year == "after 2000"){
      race.byinput %>% filter(year_release > 1999) %>% select(box_office) %>% getMoney() %>% return()
    } else {
      return(race.byinput)
    }
  }
  
  output$raceGraph <- renderPlot({
=======
   output$raceGraph <- renderPlot({
     barplot(getRacial(input$race,input$year)$box_office,
             main = paste("Box office revenue for biopics featuring ",input$race," actors ",input$year,".",sep =""),
             xlab = "Films", ylab = "Revenue in millions of Dollars",
             col = "green"
             )
     
   })
  output$distPlot <- renderPlot({
>>>>>>> 5dc259817a4a2bf3386fe701997a52d2b5e7983e
    
    race <- filter(biopic, race_known == "Known") %>% 
      filter(box_office != "-") %>%
      select(subject_race, year_release, box_office)
    
    barplot(getRacial(input$race, input$year)$box_office,
            main = paste("Box office revenue for biopics featuring ",input$race," actors ",input$year,".",sep =""),
            xlab = "Films", ylab = "Revenue in millions of Dollars",
            col = "green"
    )
    
  })
  
  output$sexEffect <- renderPlot({

    biopic_money <- filter(biopic, subject_sex == input$sex) %>%
      select(year_release, box_office) %>%
      filter(box_office != "-") 
      
    biopic_filter <- getMoney(biopic_money)
    
    return(ggplot(biopic_filter, aes(x= year_release, y = box_office)) + geom_bar(stat = "identity")
           + labs(title = "Average Box Office Earnings", x = "Year Of Release", y = "Box Office Earnings"))
    
  })
  
  
})