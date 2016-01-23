library(readr)
library(dplyr)
library(magrittr)

df <- read_csv2("../household_power_consumption.txt",
                col_types = cols(
                  Date = col_date("%d/%m/%Y"),
                  Time = col_time(),
                   .default = "c"
                ), na = "?")

df[3:9] %<>% lapply(as.numeric)


df <- df %>%
  filter(Date %>% between(as.Date("2007-02-01"), as.Date("2007-02-02")))

png("plot1.png")

hist(df$Global_active_power, 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")

dev.off()

