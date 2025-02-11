############################## Chapter 6 Reading Data into R

getwd()
setwd()

# Using read.table examples

# Read in a text file of employee information
# use the print() function to display the information on screen
Company.Employees <- read.table("EmployeeSales.txt", 
                                header = TRUE, sep = ",",quote = "\"")
print(Company.Employees)

head(Company.Employees)
dim(Company.Employees)
summary(Company.Employees)


#Read in a CSV file from a URL
theUrl  <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato <-read.table(file=theUrl, header=TRUE, sep=",")
head(tomato)
nrow(tomato)

summary(tomato)
class(tomato)

# Using the read_delim function
install.packages("readr")
library(readr)
theUrl <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato2 <-read_delim(file=theUrl, delim=',')
tomato2
class(tomato2)

# Reading data from an Excel spreadsheet
# install the curl and readxl packages
# use the library() function to load the packages into R

install.packages("readxl")
library(readxl)

tomatoXL <-read_excel("ExcelExample.xlsx")
tomatoXL
head(tomatoXL)

dim(tomatoXL)
summary(tomatoXL)

