# Assignment 3
# Data Set: Kiva Crowd funding 
# Data Set Link: https://www.kaggle.com/datasets/kiva/data-science-for-good-kiva-crowdfunding

# Load Libraries
library(tidyverse)
install.packages("leaflet")
library(leaflet)

#Entry 1: Creating a dynamic path to read all the data files
#Solution: https://stackoverflow.com/questions/34226187/r-dynamic-reference-to-files-for-read-csv

folder_name <- 'NUIG BA/MS5130_Applied Analytics_R/R_A3/data/'

# Read data
loans <- read_csv(file = paste0('D:/', folder_name,'kiva_loans.csv'))
head(loans)
