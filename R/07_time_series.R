# Time-series

library(dplyr)
library(ggplot2)
library(lubridate) # working with data
library(zoo)       # deals with dates too

# Example: We will use Covid-19 data from Recife in Pernambuco, Brazil----------

# data obtained from the portal Brasil.io: https://brasil.io/home/
covid <- read.csv("data/raw/covid19-dd7bc8e57412439098d9b25129ae6f35.csv")

View(covid)
head(covid)


# We want to plot date...

# First checking the class
class(covid$date)         #[1] "character"

# Changing to date format
covid$date <- as_date(covid$date)
# Checking the class
class(covid$date)         #[1] "Date"

# Now we can make numeric operations
range(covid$date)

summary(covid$date)

# Ploting

#First, we will create a column containing the number of new cases.
ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal()

# Oops. We have negative cases and will substitute the negative values per zero.
covid$new_confirmed[covid$new_confirmed < 0] <- 0

ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal() +
  labs(x = "Date", y = "New cases")

ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal() +
  scale_x_date(breaks = '3 months',
               date_labels = "%m-%Y"
               #, limits = as.Date(c('2020-03-12', '2022-03-27'))
               ) +
  labs(x = "Date", y = "New cases")

# Rolling mean
covid$roll_mean <- zoo::rollmean(covid$new_confirmed, 14, fill = NA)

head(covid)

ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed) ) +
  geom_line(aes(x = date, y = covid$roll_mean, color = 'red')) +
  theme_minimal() +
  labs(x = "Date", y = "New cases")





