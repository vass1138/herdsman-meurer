if (!exists("d0")) {
  source("herdsman_times.R")
}

library(ggplot2)

# remove outliers
boxplot(d0$ElapsedMinutes)
boxplot(d0$ElapsedMinutes,plot=FALSE)$out
outliers <- boxplot(d0$ElapsedMinutes, plot=FALSE)$out
d0 <- d0[-which(d0$ElapsedMinutes %in% outliers),]
boxplot(d0$ElapsedMinutes)

summary(d0)

