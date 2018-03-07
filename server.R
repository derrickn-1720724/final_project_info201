library(shiny)
library(dplyr)
library(ggplot2)

biopic <- read.csv("data/biopics.csv", stringsAsFactors = FALSE)
race <- filter(biopic, race_known == "Known") %>% 
  filter(box_office != "-") %>%
  select(subject_race, year_release, box_office) %>% group_by(year_release)

shinyServer(function(input, output) {
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
  
  getRacial <- function(input.race){
    race.byinput <- race %>% filter(subject_race == input.race) %>% select(year_release,box_office)
      race.byinput %>% getMoney() %>% return()
      
  }
  
  output$raceGraph <- renderPlot({
    return(ggplot(getRacial(input$race), aes(x= year_release, y = box_office)) + geom_bar(stat = "identity",fill = "green", color = "green4")
    + labs(title = "Average Box Office Earnings", x = "Year Of Release", y = "Box Office Earnings"))
    
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
