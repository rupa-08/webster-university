############################### Chapter 8 Functions 

# A Simple function
helloClass <- function()
{
  print("Hello Class")
}

# function call
helloClass()

############################## Using the sprintf() function 

# The "sprintf()" function allows you to pass arguments from the 
# function call to the function 
# within your scripts by using the special character of "%s"

helloClassNew <- function(studentName,courseName) 
{
  
  print(sprintf("Hello %s. Welcome to CSDA %s! Do your homework and you will get an A", 
                studentName, courseName))
}

# Call the function passing in the argument value by position
helloClassNew("Will", "5110")

# Alternative method - Passing by Argument name
helloClassNew(studentName = "Jack", courseName = "5110")

# using Default Arguments
helloClassNew <- function(studentName,courseName="5110") 
{
  
  print(sprintf("Hello %s. Welcome to CSDA %s!Do your homework and you will get an A",
                studentName, courseName))
}

helloClassNew("Mark") # Using the default argument of 5110
helloClassNew("Mark", "5160") # overwriting the default argument of 5110

# Using functions with Return Values

return.command <- function(x)
{
  return(x * 20) # This is the calculation being performed
}
# This line sets the value of X as an argument in the function
return.command(75) 


# Example of Lazy Evaluation of Function
# Create a function with arguments.
new.function <- function(a, b)
{
  print(a^2)
  print(a)
  print(b)
}

# Evaluate the function without supplying one of the arguments.
new.function(6,)