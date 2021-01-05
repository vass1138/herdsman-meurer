if (!exists("d0")) {
  source("herdsman_times.R")
}

mt <- median(d0$ElapsedMinutes)
sdt <-sd(d0$ElapsedMinutes) 

# Fixed events to label

dl <- data.frame(x=c('2019/12/20','2019/09/15','2019/06/28','2019/04/29','2019/4/14','2018/12/23','2018/9/9','2018/8/18'),
                 lab=c('Nephrectomy','Flu','Kidney Stones','Gastro','USA','Too hot','Flu','Vienna'),stringsAsFactors = FALSE)

# label height position
ypos <- 50.0
dl$y <- ypos + 0.1

dl$x <- as.Date(dl$x)
str(dl)

# X-axis limits
xmin <- as.Date('2018-07-01')
xmax <- as.Date('2020-12-01')

xpos <- as.Date('2019/04/01')

ggplot(d0) +
  geom_line(aes(x=EventDate,y=ElapsedMinutes)) +
  geom_point(aes(x=EventDate,y=ElapsedMinutes)) +
  geom_smooth(aes(x=EventDate,y=ElapsedMinutes),span=0.5) +
  geom_segment(data=dl,aes(x=x,xend=x,y=ypos-0.5,yend=ypos-2),arrow=arrow(type='closed',angle=10)) +
  geom_text(data=dl,aes(x=x,y=y,label=lab),angle=45,hjust=0) +
  ylim(38,52.5) +
  labs(x='Date',
       y="Elapsed Minutes",
       title="Herdsman-Meurer Effect",
       subtitle=sprintf("median=%.2f stddev=%.2f",mt,sdt),
       caption="www.linkedin.com/in/evassiliadis/\ngithub.com/vass1138/herdsman-meurer"
  ) +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust=1,face="italic"),
        axis.text.x = element_text(angle=45,vjust=0.5)) +
  scale_x_date(breaks = function(x) seq.Date(from = xmin, 
                                             to = xmax, 
                                             by = "3 months"),
               minor_breaks = function(x) seq.Date(from = xmin, 
                                                   to = xmax, 
                                                   by = "1 months"))

this_date <- format(Sys.Date(),"%y%m%d")
ggsave(paste0('meurer_',this_date,'.png'))
