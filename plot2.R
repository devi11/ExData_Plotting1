
## reading data
f <- file("household_power_consumption.txt","rt");

nolines <- 100
greped<-c()
repeat {
  lines=readLines(f,n=nolines)       #read lines
  idx <- grep("^[12]/2/2007", lines) #find those that match
  greped<-c(greped, lines[idx])      #add the found lines
  #
  if(nolines!=length(lines)) {
    break #are we at the end of the file?
  }
}
close(f)

tc<-textConnection(greped,"rt") #now we create a text connection and load data
df<-read.csv(tc,sep=";",header=FALSE)
head(df)
names(df) <- c( "Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
head(df)


df$dateTime <- as.POSIXct(strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S"))


## plot 2:
png(filename="plot2.png",width=480,height=480)

plot(df$dateTime, df$Global_active_power, type="l", xlab="",
     ylab="Global Active Power (kilowatts)")

dev.off()


