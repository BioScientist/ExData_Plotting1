library(readr)
library(dplyr)
library(magrittr)



df <- read_csv2("../household_power_consumption.txt",
                col_types = cols(.default = "c"), na = "?") 

for_plot <- df %>%
  filter(as.Date(Date,"%d/%m/%Y") %>%
           between(as.Date("2007-02-01"), as.Date("2007-02-02"))) %>%
  mutate(
    dateTime = paste(Date, Time) %>%
      as.POSIXct(tz = "UTC", format = "%d/%m/%Y %H:%M:%S")
  ) %>%
  select(dateTime, starts_with("Sub_metering_")) %>%
  type_convert()

png("plot3.png")
with(for_plot, {
  plot( dateTime, Sub_metering_1, type = "l" )
  lines(dateTime, Sub_metering_2, col = "red")
  lines(dateTime, Sub_metering_3, col = "blue")
  legend("topright", legend = names(for_plot)[-1], lty = 1, col = c("black", "red", "blue") )
})
dev.off()

