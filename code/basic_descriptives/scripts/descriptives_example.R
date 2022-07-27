## DESCRIPTIVES EXAMPLE: JOINT ANGULAR IMPULSE
# Prasanna Sritharan, July 2022



library(tidyverse)

# location of data file (note: need to use double back slashes)
csvfile <- "C:\\Users\\Owner\\Documents\\projects\\latr\\code\\basic_descriptives\\data\\impulse_data.csv"

# load the file into a data frame
data <- read_csv(csvfile)


# Base R: summary
summary1 <- summary(data)




# Dplyr: summarise all ()
means <- data %>% 
          group_by(subject, movement, data_leg, variable) %>% 
          summarise_all(mean)

sds <- data %>% 
          group_by(subject, movement, data_leg, variable) %>% 
          summarise_all(sd) %>% 
          ungroup()



# Add additional columns for sorting
means <- means %>% mutate(statistic="mean", row_number=row_number())
sds <- sds %>% mutate(statistic="sd", row_number=row_number())


# Merge means and sds into a single table
descriptives <- means %>% 
                  bind_rows(sds) %>% 
                  arrange(row_number, .by_group=TRUE)

# remove and rearrange columns
descriptives <- descriptives %>% 
                  select(-c(row_number, trial)) %>% 
                  relocate(statistic, .before=net)

# write to csv file
write_csv(descriptives, "descriptives.csv")

          



