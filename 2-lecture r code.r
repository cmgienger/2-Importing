#C.M. Gienger
#Code to follow along with lecture #2 Beckerman et al. pages 34-55

#maybe best to install library(tidyverse), but I chose to install component
#packages individually to show that it is a common issue. 

#follow along starting with compensation examples:

compensation <- read.csv("compensation.csv")
View(compensation)

#Checking the Data
names(compensation) #variable names assigned to each column
head(compensation) #returns data for first 6 rows; also try tail() 
dim(compensation) #number of rows/columns; note rows come first in R 
str(compensation) #structure of the dataset

library(dplyr)
glimpse(compensation) #note that all dplyr and ggplot2 code use the dataframe as first arguement
tbl_df(compensation)

#Import nasty.format
nasty.format <- read.csv("nasty format.csv")
str(nasty.format)
library(dplyr)
glimpse(nasty.format)   #I prefer View(nasty.format)

#Filter nasty.format
library(dplyr)
nasty.format <- filter(nasty.format, Bottle != "")
glimpse(nasty.format)    

#Gather nasty.format
library(tidyr)
tidy_data <- gather(nasty.format, Date, Abundance, 4:11)
View(tidy_data)

#Clean the Dates
library(stringr)
tidy_data <- mutate(tidy_data, Date = substr(Date, 2, 20))

#Force Date Format
unique(tidy_data$Date)
library(lubridate)
tidy_data <- mutate(tidy_data, Date = dmy(Date))
glimpse(tidy_data)

#Visualize the Data
library(ggplot2)
ggplot(data = tidy_data, aes(x=Date, y=Abundance)) +
  geom_point() +
  facet_wrap(~Bottle)
