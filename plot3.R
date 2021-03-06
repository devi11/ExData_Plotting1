
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

## plot 3:
png(filename="plot3.png",width=480,height=480)

plot(df$dateTime,df$Sub_metering_1,type="l",xlab=" ",ylab="Energy sub metering",col="black",lwd=1)

lines(df$dateTime,df$Sub_metering_2,col="red",lwd=0.5)
lines(df$dateTime,df$Sub_metering_3,col="blue",lwd=0.5)

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1), lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))
      
dev.off()