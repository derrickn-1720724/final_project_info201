library(shiny)
library(dplyr)
library(ggplot2)


race <- filter(biopic, race_known == "Known") %>% 
  filter(box_office != "-") %>%
  select(subject_race, year_release, box_office)

shinyServer(function(input, output) {
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
