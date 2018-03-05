## Get relevant entries that have both a known race and known income
## Filter data down to
race <- biopic %>% filter(race_known == "Known") %>% 
      filter(box_office != "-") %>%
      select(subject_race,year_release,box_office) %>%
      group_by(subject_race)
##filters data by input race and year range
getRacial <- function(input.race,input.year){
race.byinput <- race %>% filter(subject_race == input.race) %>% select(year_release,box_office)
if(input.year == "After 2000"){
  race.byinput %>% filter(year_release > 1999) %>% select(box_office) %>% getMoney() %>% return()
}
}
getMoney(money){
  
}