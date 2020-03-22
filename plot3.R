library(base)

unzip(zipfile = "exdata_data_household_power_consumption.zip")
electric_power_consumption <- read.csv(
  "household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

epc_rel_days <- electric_power_consumption[
  electric_power_consumption$Date %in% c("1/2/2007","2/2/2007"),]

rm(electric_power_consumption)

epc_rel_days$Date <- as.Date(epc_rel_days$Date, "%d/%m/%Y")

epc_rel_days <- data.frame(date_time = paste(epc_rel_days$Date, epc_rel_days$Time),
                           epc_rel_days)

epc_rel_days$date_time <- strptime(epc_rel_days$date_time, "%Y-%m-%d %H:%M:%S")

png(filename = "plot3.png", width = 480, height = 480)

with(epc_rel_days, plot(date_time, Sub_metering_1,
                        type = "l",
                        col = "black",
                        main = NULL,
                        xlab = "",
                        ylab = "Energy sub metering"))
with(epc_rel_days, lines(date_time, Sub_metering_2,
                        col = "red"))
with(epc_rel_days, lines(date_time, Sub_metering_3,
                         col = "blue"))
legend("topright",
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)

dev.off()