library(shiny)
library(dplyr)
library(ggplot2)


#filtering

biopic <- read.csv("data/biopics.csv", stringsAsFactors = FALSE)
race <- filter(biopic, race_known == "Known") %>% 
  filter(box_office != "-") %>%
  select(subject_race, year_release, box_office) %>% group_by(year_release)

shinyServer(function(input, output) {

  #function to convert 'k' to 'M'

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
  
  #filtering data for race_impact bar graph and function to extract race
  getRacial <- function(input.race, input.year){
    race.byinput <- race %>% filter(subject_race == input.race) %>% select(year_release,box_office)
    if(input.year == "after 2000"){
      race.byinput %>% filter(year_release > 1999) %>% select(box_office, year_release) %>% getMoney() %>% return()
    } else {
      race.byinput %>% filter(year_release < 2000)  %>% select(box_office, year_release) %>% getMoney() %>% return()
    }
  }
  
  # race graph
  output$raceGraph <- renderPlot({
    data <- getRacial(input$race, input$year)
    p <- ggplot(data, aes(x = year_release, y = box_office, group = year_release)) + 
           geom_bar(stat = "identity") +
           labs(title = paste0("Box office revenue for biopics featuring ",input$race," subjects ",input$year,"."),
                x = "Films", y = "Revenue in millions of Dollars") +
          theme_minimal()
    return(p)
  })
  
  # gender graph
  output$sexEffect <- renderPlot({
    
    biopic_money <- filter(biopic, subject_sex == input$sex) %>%
      select(year_release, box_office) %>%
      filter(box_office != "-") 
    
    biopic_filter <- getMoney(biopic_money)
    
    return(ggplot(biopic_filter, aes(x = year_release, y = box_office)) + geom_bar(stat = "identity") +
             labs(title = "Average Box Office Earnings", x = "Year Of Release", y = "Box Office Earnings") + 
             theme_minimal())
    
  })
  
  output$main_c_race <- renderPlot({
    if(input$main_c_race == "Overall") {
      biopic_main_c_race <- reactive({
        df <- biopic %>%
          filter(year_release > input$year_choice[1] & year_release < input$year_choice[2]) %>%
          select(year_release, box_office, subject_race) %>%
          filter(box_office != "-") %>% getMoney()
        return(df)
      })
    } else { 
      filtered <- reactive({
        data <- filter(biopic, subject_race == input$main_c_race) %>%
          filter(year_release > input$year_choice[1] & year_release < input$year_choice[2]) %>%
          select(year_release, box_office, subject_race) %>%
          filter(box_office != "-") %>% getMoney()
      return(data)
    })
    }
    
    
    if(input$main_c_race == "Overall") {
      p <- ggplot(biopic_main_c_race(), aes(x = year_release, y = box_office, fill = subject_race)) + geom_bar(stat = "identity") +
        labs(title = "Average Box Office Earnings (Overall race)", x = "Year Of Release", y = "Box Office Earnings")
    } else {
      p <- ggplot(filtered(), aes(x = year_release, y = box_office)) + geom_bar(stat = "identity") +
        labs(title = paste0("Average Box Office Earnings (", input$main_c_race, ")"), x = "Year Of Release", y = "Box Office Earnings") +
        theme_minimal()
    }
    
    return(p)
  })
})

