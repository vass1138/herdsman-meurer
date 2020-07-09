
if (!exists("data")) {
  source("herdsman_times.R")
}


temp1 <- read.csv("IDCJAC0010_009225_2019_Data.csv",stringsAsFactors = FALSE)
temp1$EventDate <- as.Date(with(temp1, paste(Year, Month, Day,sep="-")), "%Y-%m-%d")

temp2 <- read.csv("IDCJAC0010_009225_2018_Data.csv",stringsAsFactors = FALSE)
temp2$EventDate <- as.Date(with(temp2, paste(Year, Month, Day,sep="-")), "%Y-%m-%d")

temp <- rbind(temp1,temp2)

# keep date and temp columns
dt <- temp[,c("EventDate","Maximum.temperature..Degree.C.")]
names(dt)[names(dt) == "Maximum.temperature..Degree.C."] <- "temperature"

# merge elapsed time and temp
dm <-merge(d0[,c('EventDate','ElapsedMinutes')],dt,by='EventDate')

ggplot(dm) +
  geom_point(aes(x=temperature,y=ElapsedMinutes)) +
  xlab("Daily Max Temperature (C)") +
  ylab("Elapsed Minutes") +
  ylim(38,48) +
  ggtitle("Herdsman-Meurer Effect")

ggsave("meurer-temperature.png")

# solar data for 2018 and 2019
solar1 <- read.csv("IDCJAC0016_009225_2018_Data.csv",stringsAsFactors = FALSE)
solar1$EventDate <- as.Date(with(solar1, paste(Year, Month, Day,sep="-")), "%Y-%m-%d")

solar2 <- read.csv("IDCJAC0016_009225_2019_Data.csv",stringsAsFactors = FALSE)
solar2$EventDate <- as.Date(with(solar2, paste(Year, Month, Day,sep="-")), "%Y-%m-%d")

solar <- rbind(solar1,solar2)

# keep date and temp columns
ds <- solar[,c("EventDate","Daily.global.solar.exposure..MJ.m.m.")]
names(ds)[names(ds) == "Daily.global.solar.exposure..MJ.m.m."] <- "DailyGlobalSolarExp"

# merge elapsed time and solar
# dms <-merge(d0[,c('EventDate','ElapsedMinutes')],ds,by='EventDate')
dms <-merge(dm[,c('EventDate','ElapsedMinutes','temperature')],ds,by='EventDate')

ggplot(dms,aes(x=temperature,y=ElapsedMinutes)) +
  geom_point(aes(size=DailyGlobalSolarExp)) +
  xlab("Temperature (C)") +
  ylab("Elapsed Minutes") +
  ylim(38,48) +
  ggtitle("Herdsman-Meurer Effect")

# S&P500 data
sp500 <- read.csv("SandP500.csv",stringsAsFactors = FALSE)
sp500$EventDate <- as.Date(sp500$Date)

dsp <- sp500[,c("EventDate","Close")]

# merge elapsed time and temp - THIS IS NOT WORKING!!!!
dmp <-merge(d0[,c('EventDate','ElapsedMinutes')],dsp,by='EventDate')

ggplot(dmp) +
  geom_point(aes(x=Close,y=ElapsedMinutes)) +
  xlab("Closing S & P 500") +
  ylab("Elapsed Minutes") +
  ylim(38,48) +
  ggtitle("Herdsman-Meurer Effect")

