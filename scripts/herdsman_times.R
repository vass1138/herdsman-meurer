## ---------------------------
##
## Script name: herdsman_times.R
##
## Purpose of script: 
##
##
## Author: Dr. Emanuel Vassiliadis
##
## Date Created: 2020-07-09
##
## LinkedIn: https://www.linkedin.com/in/evassiliadis/
##
## ---------------------------
##
## Notes: Data taken from facebook posts.
##   
##
## ---------------------------

rm(list = ls(all = TRUE))

library(here)
getwd()

library(tidyverse)

# package listing
# ip <- as.data.frame(installed.packages()[,c(1,3:4)])
# rownames(ip) <- NULL
# ip <- ip[is.na(ip$Priority),1:2,drop=FALSE]
# print(ip, row.names=FALSE)

install_this_library <- function(libname) {

  if (!(libname %in% installed.packages())) {
    install.packages(libname)
  } else {
    print(paste0(libname," already installed"))
  }
}

# test
# install_this_library("rvest")

data <- read.csv(paste0(here("data"),"/herdsman_times.csv"),stringsAsFactors = FALSE)

head(data)

data$EventDate <- as.Date(data$EventDate,"%Y-%b-%d")
d0 <- data.frame(data)
