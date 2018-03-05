biopic <- read.csv("data/biopics.csv")
biopic_money <- filter(biopic, subject_sex == "Male") %>%
                select(year_release, box_office) %>%
                filter(box_office != "-") 

biopic_money$box_office <- gsub('\\$', '', biopic_money$box_office)
biopic_money$box_office <- gsub('M', '', biopic_money$box_office)
biopic_money$box_office <- gsub('K', '', biopic_money$box_office)

aggregate(biopic_money, list(biopic_money$year_release), mean)
