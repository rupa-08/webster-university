############################### Chapter 5 Data Frames 


# we will start by creating three vectors called "names" of movies, 
# "year" for year released,and "boxoffice" for total revenue
# Each vector will contain 10 elements. 
# THIS is comment

# Create the vector of movie names
names <- c("Whatever Works", "It Follows", "Love and Mercy", 
           "The Goonies", "Jiro Dreams of Sushi",
           "There Will be Blood", "Moon","Spice World", 
           "Serenity", "Finding Vivian Maier")

# Create the vector that contains the year the movies were released
year <- c(2009, 2015, 2015, 1985, 2012, 2007, 2009, 1988, 2005, 2014)

# Create the vector that holds box office total revenue in Millions of dollars
boxoffice <- c(35, 15, 15, 62, 3, 10, 321, 79, 39, 1.5) 

# Returns the mean of the values in the vector boxoffice
mean(boxoffice) 

# Returns the sum of the values in the vector boxoffice
sum(boxoffice)

# Display the values of the vector boxoffice
boxoffice


# Combine all 3 vectors into a single 10 x 3 data frame called movieDF
movieDF <- data.frame(names,year,boxoffice)
movieDF 

# Check the number of Rows in a data frame
nrow(movieDF)

# Check the number of columns in a data frame
ncol(movieDF)

# Check the number of cols and rows in a data frame. 
# It will return NULL if used for vectors
dim(movieDF)   

# Check the col names of a data frame
names(movieDF)

# Assign row names of a data frame
rownames(movieDF) <- c("One", "Two", "Three", "Four", "Five",
                       "Six", "Seven", "Eight", "Nine", "Ten")
movieDF

# Look at the first few rows of a data frame
head(movieDF,10)

# Look at the last few rows of a data frame
tail(movieDF,10)

# Check the class of a data frame
class(movieDF)

# Accessing individual elements of a data frame by using the $
movieDF$year # returns the years column
movieDF$names # returns the name of the movies

# Use the mean function to return the mean value of the boxoffice column
mean(movieDF$boxoffice)

# Use summary() to view summary statistics of the dataframe
summary(movieDF)


# Access rows and columns of a data frame by using []
movieDF[5,3] # Returns the 5th Row, 3rd Column value
movieDF[6, 2:3] # returns the 6th row and 2nd through 3rd column values
movieDF[c(1,4), 2] # returns the 1st and 4th rows and the 2nd column values
movieDF[c(1,4), 2:3] # returns the 1st and 4th rows, 2nd through 3rd column values
movieDF[3,] # returns the entire 3rd row values
movieDF[,3] # returns the entire 3rd column of values
movieDF[,2:3] # returns the entire 2nd through 3rd column of values
movieDF[2:6,]# returns the entire 2nd through 6th row

# You can use the column names to access multiple columns by name
movieDF[,c("names","year")] # returns all the values in the names and year columns

movieDF[,"names"] # Returns just a single specific column by name
class(movieDF[,"names"]) # note that it returns it as a factor

movieDF["names"] # Returns just a single specific column by name
class(movieDF["names"]) # returns the class data.frame

movieDF$names[2:4] #returns the values for the column names from rows 2 through 4
movieDF$year[3:6] #returns the values for the column year from rows 3 through 6


# Factor variables are variables that categorize and store data 
# as vector of integer values with corresponding labels
# Factors are used to represent categorical data, which have a 
# limited number of distinct values or levels.
# To see how factors are represented in a data.frame we use the model.matrix
# formula to create dummy variables to create a set of indicator variables

# For each level of a factor a single column is shown that will 
# contain 1 if a row contains that factor level or 
# a 0 if the row contains no factor level
newFactor <- factor( c("Pennsylvania", "New York", "New Jersey",
                       "New York", "Tennessee", "Massachusetts",
                       "Pennsylvania", "New York"))

# Formulas consist of a left side and a right side separated by a tilde (~). 
# The left side represents a variable that we want to make a calculation on, 
# and the right side represents a variable (or more) that we want to group the 
# calculation by.

# in this formula we are grouping the factors in the variable newFactor
# and assigning an attribute of 1 to the rows that have that level

model.matrix(~ newFactor -1) 


############################### Chapter 5 Lists

# A list is a special type of vector
# Lists can contain various data types
# A List can contain all the same data types, a mix of data types, 
# data frames, or other lists

# Create a list using the list() function
# Within its parentheses, you can code as many items as you want, 
# separated by commas. For each column, you can optionally provide a name 
# for the item by coding its name and the equals operator (=) before the item.

# This example shows how to create a list that stores three items 
# that contain information about each month. The first item doesn’t have 
# a name and stores a string, “Misc Calendar Data”. The second item has 
# a name of headers and stores a character vector. 
# And the third item has a name of rows and stores another list. 
# This list contains two more lists that provide data
# for two rows. Here, each row uses more than one data type. 

calendar_list <- list("Misc Calendar Data", headers = c("Month","NumDays",
                                                        "Season"), rows = list(
                                                          list("Jan",31,"Winter"), list("Feb",28,"Winter")))

# To view the structure of this list, we pass the list to the str()function.
# This will show us that the list has 3 items: A string, character vector that
# contains 3 strings, and a list that contains two more lists that contain 
# three items each
str(calendar_list)

# To retrieve an item from a list, you can use the bracket selector
# as shown in the example below.
# However, this retrieves the item, not the item’s value.
# That’s why the output will display the name of the second item, 
# which is $headers, before displaying the value of the item, 
# which is the vector of strings. 

# How to use single brackets to select an item 
calendar_list[2] # gets the 2nd item (headers) in the list


# To retrieve an item’s value, you need to code two sets of brackets as shown 
# in the below example. This example retrieves the vector that’s stored as 
# the value of the second item, and it doesn’t retrieve the name of this item. 

#How to use double brackets to select an item’s value 
calendar_list[[2]] # get the value of the 2nd item (headers)


# Both the second and third examples use an index to select the second item 
# in the list. However, if an item has a name, you can use its name to select 
# it as shown by the fourth example. 
# Here, the first statement uses a name to get the vector that’s stored as the 
# value of the second item. 
# The second statement gets the item for the first row in the rows item. 
# And the third statement gets the value for the second column of the first row.

#How to use names or indexes to select nested items 
calendar_list[["headers"]]  # get value for headers item 
calendar_list[["rows"]][1] # get the first item in rows
calendar_list[["rows"]][[1]][[2]] # get value for row 1, column 2


# 
# Using the names() function, we can assign a name for each of the elements
# within our list as well
names(calendar_list) <- c("String", "Char vector", "list of lists")
names(calendar_list) # View the names of the elements
calendar_list # view the list's elements

############################## Chapter 5 Matrices 

# Matrices are two dimensional structures used for data manipulation
# Matrices take a vector of data and the number of rows and columns,
# in the matrix as arguments

# create a 5x2 matrix
A <- matrix(1:10, nrow = 5)

# create another 5x2 matrix
B <- matrix(21:30, nrow = 5)

# create another 5x2 matrix
C <- matrix(21:40, nrow = 2)

# Add matrix A and B together
A + B

# Adding matrix A and C together will produce an error
A + C

# multiply the values of matrix A by the values of B
A * B

# see if the elements are equal
A == B

# Matrix multiplication is a commonly used operation in mathematics, 
# requiring the number of columns of the left-hand matrix to be the same 
# as the number of rows of the right-hand matrix. 
# Both A and B are 5X2 so we will transpose B so it can be used on the 
# right-hand side. 

# To transpose matrix b, we use the t() to transpose matrix b and 
# the %*% operator for matrix multiplication, providint the matrix product of
# the two matrices. 
# The resulting new matrix will have the same number of rows as matrix A 
# and the same number of columns as matrix B

A %*% t(B)


# Giving rownames and column names
colnames(A) <- c("Left", "Right")
rownames(A) <- c("1st", "2nd", "3rd", "4th", "5th")
colnames(B) <- c("First", "Second")
rownames(B) <- c("One", "Two", "Three", "Four", "Five")
A * B

# using letters and LETTERS respectively. UPPERCASE
colnames(C) <- LETTERS[1:10]
rownames(C) <- c("Top", "Bottom")
C
# lowercase
colnames(C) <- letters[1:10]
rownames(C) <- c("Top", "Bottom")


############################### Chapter 5 Arrays 

# Arrays are like vectors but are multidimensional
# Arrays can only hold values that are of the same data types. 
# The array() function is used to create an array in R. 
# It takes a vector of numbers and dimensions as arguments. 
# The dimensions are specified using the dim parameter. 
# Here’s an example of creating an array using two vectors 
# named array1 and array2 1

# creating  3 dimensional array
vector1 = c(5, 10, 15, 20)
vector2 = c(25, 30, 35, 40, 45, 50, 55, 60)
final = array(c(vector1, vector2), dim = c(4, 4, 3))

class(vector2)
is.vector(x)

x <- 10:15

# In the above example code output above we have created a three-dimensional 
# array with dimensions 4 x4 x3. The first two dimensions represent the rows 
# and columns of the matrix respectively. The third dimension represents 
# the number of matrices in the array