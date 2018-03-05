## Get relevant entries that have both a known race and known income
## Filter data down to
race <- biopic %>% filter(race_known == "Known") %>% 
      filter(box_office != "-") %>%
      select(subject_race,year_release,box_office)
##filters data by input race and year range
getRacial <- function(input.race,input.year){
race.byinput <- race %>% filter(subject_race == input.race) %>% select(year_release,box_office)
if(input.year == "After 2000"){
  race.byinput %>% filter(year_release > 1999) %>% select(box_office) %>% getMoney() %>% return()
} else {
  return(race.byinput)
}
}
##Returns data frame with box office revenue converted to double.
## Data must be non-factor. stringsAsFactors = FALSE
getMoney <- function(money){
  money$box_office <- substr(money$box_office,2,nchar(money$box_office))
  scale <- substr(money$box_office,nchar(money$box_office),nchar(money$box_office))
  money$box_office <- as.double(substr(money$box_office,1,nchar(money$box_office)-1))
  if(scale == "K"){
    money$box_office <- money$box_office * 1000
    return(money)
  } else {
    money$box_office <- money$box_office * 1000000
    return(money)
  }
} 