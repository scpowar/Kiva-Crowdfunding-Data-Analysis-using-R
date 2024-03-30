# Assignment 3
# Data Set: Kiva Crowd funding 
# Data Set Link: https://www.kaggle.com/datasets/kiva/data-science-for-good-kiva-crowdfunding

# Load Libraries
library(tidyverse)
install.packages("leaflet")
library(leaflet)
install.packages("DT")
library(DT)

##Entry 1: Creating a dynamic path to read all the data files
##Solution: https://stackoverflow.com/questions/34226187/r-dynamic-reference-to-files-for-read-csv

folder_name <- 'D:/NUIG BA/MS5130_Applied Analytics_R/R_A3/data/'

# Read data
loans <- read_csv(file = paste0(folder_name,"kiva_loans.csv"))
regions <- read_csv(file = paste0(folder_name,"kiva_mpi_region_locations.csv"))
themes <- read_csv(file = paste0(folder_name,"loan_theme_ids.csv"))
themes_region <- read_csv(file = paste0(folder_name,"loan_themes_by_region.csv"))

glimpse(loans)

glimpse(regions)

glimpse(themes)

glimpse(themes_region)

# Most Popular Sectors

loans %>%
  group_by(sector) %>%
  summarise(Count = n()) %>%
  arrange(desc(Count)) %>%
  ungroup() %>%
  mutate(sector = reorder(sector,Count)) %>%
  head(10) %>%
  
  ggplot(aes(x = sector,y = Count)) +
  geom_bar(stat='identity',colour="white", fill = "#F1C40F") +
  geom_text(aes(x = sector, y = 1, label = paste0("(",Count,")",sep="")),
            hjust=0, vjust=.5, size = 4, colour = 'black',
            fontface = 'bold') +
  labs(x = 'Sector', 
       y = 'Count', 
       title = 'Most Popular Sectors') +
  coord_flip() +
  theme_bw()
