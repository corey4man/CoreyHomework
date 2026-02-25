# Use Shiny Apps for making interactive web applications

# SQL option for interacting with large datasets, useful for GIS, we are using sqldf package for R

# R graph gallery for help making charts

# dplyr used for data manipulation and structuring dataframes
# A few core verbs: 
# filter(), arrange(), select(), summarize(), group_by(), and mutate()

# start with a built-in dataset
library(tidyverse)

# to specify package you're using, call package name
dplyr::filter()

data(starwars)
class(starwars)
head(starwars)
glimpse(starwars)

# Cleaning up dataset
# Base R has complete.cases function that removes rows with NAs

starwarsClean <- starwars[complete.cases(starwars[,1:10]),]

# you can check for NAs
is.na(starwarsClean[,1])
anyNA(starwarsClean[,1:10])

#filter() function will subset observations by their values
# uses >,<,==,!, &, |, etc
# filter automatically excludes NA, have to ask for them specifically

filter(starwarsClean, gender=="masculine" & height < 180, height > 100)
filter(starwars, eye_color %in% c("blue", "brown")) # %in% filters for multiple different conditions

#arrange() reorders rows
arrange(starwarsClean, by=height)
arrange(starwarsClean, by=desc(height)) #automatically does ascending so desc does descending
arrange(starwarsClean, height, desc(mass)) # This will break ties if there are ties in height, does it by mass

#select() choose variables based on their names/columns
starwarsClean[1:10,]
select(starwarsClean, 1:10) # these functions are equivalent
select(starwarsClean, name:homeworld) # this will give you columns from 1st column (name)->homeworld
select(starwarsClean, -(films:starships)) # subsetting everything but these variables

# rearrange columns
select(starwarsClean, homeworld, name, gender, species, everything())

select(starwarsClean, contains("color"))

#rename columns
select(starwars, haircolor=hair_color) #actual name of the column comes after the new name you want

# mutate function creates new variables with functions of existing variables

# Create a new column that's just the height divided by mass
mutate(starwarsClean, ratio=height/mass)
starwars_lbs <- mutate(starwarsClean, mass_lbs=mass*2.2)

# Transmute creates new dataframe containing only what you're asking for
transmute(starwarsClean, mass_lbs=mass*2.2)

#summarize and group_by functions collapse many values down to a single summary
summarize(starwarsClean, meanHeight=mean(height)) #Summary only works if there are no NAs (clean)
summarize(starwars, meanHeight=mean(height))
summarize(starwars, meanHeight=mean(height, na.rm=TRUE), TotalNumber=n()) #shows how many rows are factored into the mean

#use group_by() for additional calculations
starwarsGender <- group_by(starwars, gender)
summarize(starwarsGender, meanHeight=mean(height,na.rm=TRUE), number=n())

#pipe statements -the pipe operator is %>% or |>
# These are sequences of actions that will change your dataset
# It's going to pass intermediate results onto next function in the sequence
# You should avoid then when you need to manipulate more than one object or if there are meaningful intermediate objects
#formatting: you should always have a space before it and usually an automatic indent
starwarsClean|>
  group_by(gender)|>
  summarize(meanHeight=mean(height, na.rm=TRUE), number=n()) #This will group means by gender

#case_when() is a function that is useful for multiple conditional ifelse statements

starwarsClean|>
  mutate(sp=case_when(species=="Human"~"Human", TRUE ~ "Non-human"))|> #Comma after human is basically an else
  select(name, sp, everything())
unique(starwarsClean$species)

glimpse(starwarsClean)

# Pivot from long to wide format using pivot_wider or pivot_longer

wideSW <- starwarsClean|>
  select(name, sex, height)|> # This just pulls name, sex, and height columns
  pivot_wider(names_from=sex, values_from=height, values_fill=NA) # This widens dataset by taking groups from within sex column and make them into new columns

pivotSW <- starwars|>
  select(name,homeworld)|>
  group_by(homeworld)|>
  mutate(rn=row_number())|>
  ungroup()|>
  pivot_wider(names_from=homeworld, values_from=name) #Names from are new columns and names are what fill them in

wideSW|>
  pivot_longer(cols=male:female, names_to="sex", values_to="height", values_drop_na=TRUE)
