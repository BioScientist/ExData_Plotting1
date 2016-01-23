library(readr)
library(dplyr)
library(magrittr)



df <- read_csv2("../household_power_consumption.txt",
                col_types = "ccc______", na = "?") %>%
  mutate(
    dateTime = paste(Date, Time) %>%
      as.POSIXct(tz = "UTC", format = "%d/%m/%Y %H:%M:%S"),
    Global_active_power = as.numeric(Global_active_power)
  ) %>%
  filter(as.Date(Date,"%d/%m/%Y") %>%
           between(as.Date("2007-02-01"), as.Date("2007-02-02"))) %>%
  select(dateTime, power = Global_active_power)

  
png("plot2.png")
  
with(df, plot(
  dateTime, power, 
  type = "l",
  ylab = "Global Active Power (kilowatts)",
  xlab = NA
))

dev.off()
