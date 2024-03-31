# Assignment 3
# Data Set: Kiva Crowd funding 
# Data Set Link: https://www.kaggle.com/datasets/kiva/data-science-for-good-kiva-crowdfunding

# install.packages("leaflet")
# install.packages("DT")

# Required Libraries
library(tidyverse)
library(leaflet)
library(DT)

##Entry 1: Creating a dynamic path to read all the data files
##Solution: https://stackoverflow.com/questions/34226187/r-dynamic-reference-to-files-for-read-csv

folder_name <- 'D:/NUIG BA/MS5130_Applied Analytics_R/R_A3/data/'

# Load data
kiva_loans <- read_csv(file = paste0(folder_name,"kiva_loans.csv"))
kiva_mpi_region_locations <- read_csv(file = paste0(folder_name,"kiva_mpi_region_locations.csv"))
loan_themes <- read_csv(file = paste0(folder_name,"loan_theme_ids.csv"))
loan_themes_by_region  <- read_csv(file = paste0(folder_name,"loan_themes_by_region.csv"))

# Data Exploration
str(kiva_loans)
str(kiva_mpi_region_locations)
str(loan_themes)
str(loan_themes_by_region)

# Handling missing data
kiva_loans <- kiva_loans[complete.cases(kiva_loans),]
kiva_mpi_region_locations <- kiva_mpi_region_locations[complete.cases(kiva_mpi_region_locations),]
loan_themes <- loan_themes[complete.cases(loan_themes),]
loan_themes_by_region <- loan_themes_by_region[complete.cases(loan_themes_by_region),]

# Shape of data
dim(kiva_loans)
dim(kiva_mpi_region_locations)
dim(loan_themes)
dim(loan_themes_by_region)

# Merge Data
merged_data <- kiva_loans %>%
  left_join(kiva_mpi_region_locations, by = c("country" = "country", "region" = "region"))
loan_themes_merged <- loan_themes %>% 
  left_join(loan_themes_by_region, by = c("Loan Theme ID","Partner ID"))
merged_data <- merged_data %>% 
  left_join(loan_themes_merged, by = "id")

# Explore merged data
str(merged_data)

# Shape of merged data
dim(merged_data)

# Handling missing data
merged_data <- merged_data[complete.cases(merged_data),]

str(merged_data)

# Most Popular Sectors

merged_data %>%
  group_by(sector.x) %>%
  summarise(Count = n()) %>%
  arrange(desc(Count)) %>%
  ungroup() %>%
  mutate(sector.x = reorder(sector.x,Count)) %>%
  head(10) %>%
  
  ggplot(aes(x = sector.x,y = Count)) +
  geom_bar(stat='identity',colour="white", fill = "#F1C40F") +
  geom_text(aes(x = sector.x, y = 1, label = paste0("(",Count,")",sep="")),
            hjust=0, vjust=.5, size = 4, colour = 'black',
            fontface = 'bold') +
  labs(x = 'Sector', 
       y = 'Count', 
       title = 'Most Popular Sectors') +
  coord_flip() +
  theme_bw()
