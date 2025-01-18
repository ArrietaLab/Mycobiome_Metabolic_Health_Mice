# This experiment involved many independent variables, requiring more complex statistical tests than can be performed in Prism GraphPad. These analyses are specifically for repeated measure outcomes such as bodyweight (measured over time) and OGTT. Between-subject variables include sex, diet and colonization, while the within-subject variable is time. Tests should initially be run with all variables, with special attention paid to the effect of sex. If significant, males and females can be analyzed separately. If non-significant, males and females can be combined and analyzed together. 

# We will follow the tutorial from this URL: https://cran.r-project.org/web/packages/MANOVA.RM/vignettes/Introduction_to_MANOVA.RM.html

# Install package
install.packages("MANOVA.RM")

# Load packages into library
library(MANOVA.RM)
library(tidyverse)

# Load dataframe
bodyweight <- read.csv(file = "/Users/mwgutierrez/Desktop/HFHS_fungi1/HFHS_fungi1_RM_BW.csv")

# To convert from wide to long use the following chunk
bodyweight_long <- gather(data = bodyweight, key = time, value = bodyweight, BW_3, BW_4, BW_5, BW_6, BW_7, BW_8, BW_9, BW_10, BW_11, BW_12, na.rm = TRUE)

# run the repeated measures test
model <- RM(bodyweight ~ colonization * diet * sex * time, data = bodyweight_long, 
            subject = "mouse", no.subf = 1, iter = 1000, 
            resampling = "Perm", seed = 1234)
summary(model)

# Results indicated a significant sex effect so need to run males and females seperately.
bodyweight_male <- filter(bodyweight_long, sex == "M")
bodyweight_female <- filter(bodyweight_long, sex == "F")

# Repeat the test on each dataframe without sex as a variable
model <- RM(bodyweight ~ colonization * diet * time, data = bodyweight_male, 
            subject = "mouse", no.subf = 1, iter = 1000, 
            resampling = "Perm", seed = 1234)
summary(model)

model <- RM(bodyweight ~ colonization * diet * time, data = bodyweight_female, 
            subject = "mouse", no.subf = 1, iter = 1000, 
            resampling = "Perm", seed = 1234)
summary(model)