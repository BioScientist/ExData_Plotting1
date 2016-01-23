library(readr)
library(dplyr)
library(magrittr)




df <- read_csv2("../household_power_consumption.txt",
                col_types = cols(.default = "c"), na = "?") 

df <- df %>%
  filter(as.Date(Date,"%d/%m/%Y") %>%
           between(as.Date("2007-02-01"), as.Date("2007-02-02"))) %>%
  mutate(
    datetime = paste(Date, Time) %>%
      as.POSIXct(tz = "UTC", format = "%d/%m/%Y %H:%M:%S")
  ) %>% 
  select(-Time) %>% 
  type_convert()


png("plot4.png")

par(mfcol = c(2,2))

with(df, plot(
  datetime, Global_active_power, 
  type = "l",
  ylab = "Global Active Power",
  xlab = NA
))


with(df, {
  plot( datetime, Sub_metering_1, type = "l" )
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
  legend("topright", legend = names(df)[7:9], lty = 1, 
         col = c("black", "red", "blue"),
         box.lwd = 0)
})

with(df, {
  plot(datetime, Voltage, type = "l")
  plot(datetime, Global_reactive_power, type = "l")
  
})

dev.off()

