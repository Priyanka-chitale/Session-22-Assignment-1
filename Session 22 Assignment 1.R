getwd()
setwd("D:/Priyanka/R")

library("readr")
epi = read.csv("epi_r.csv", header = TRUE, na.strings = TRUE)

## Checking missing values if any
is.na(epi)
# complete.cases(epi)
nrow(epi[!complete.cases(epi),])

# imputing missing data
library(mice)

#imputing calories with median

median(epi$calories,na.rm = TRUE)
mean(epi$calories,na.rm = TRUE)

median(epi$protein,na.rm = TRUE)
mean(epi$protein,na.rm = TRUE)

median(epi$fat,na.rm = TRUE)
mean(epi$fat,na.rm = TRUE)

median(epi$sodium,na.rm = TRUE)
mean(epi$sodium,na.rm = TRUE)

list_na <- colnames(epi)[ apply(epi, 2, anyNA) ]
view(list_na)

epi_missing <- apply(epi[,colnames(epi) %in% list_na],
                         2,
                         median,
                         na.rm =  TRUE)
view(epi_missing)

library(dplyr)

epi_missing_replace = epi %>% 
  mutate(calories = ifelse(is.na(calories), epi_missing[1], calories),
         protein = ifelse(is.na(protein), epi_missing[2], protein),
         fat = ifelse(is.na(fat), epi_missing[3], fat),
         sodium = ifelse(is.na(sodium), epi_missing[4], sodium))
