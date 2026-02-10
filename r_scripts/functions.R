# Functional programming takes inputs and gives output - good for organizing code. You can find exactly which function broke, mostly R
# OOP (Object oriented) Create object that has attributes that can do things to itself, mostly Python
# In R, function called function - defines functions
myfunc <- function(x=1, y=2) #{
# Out X and Y, can't only call x
# Can only output 1 object, return(out)
# Can have z <- list(out, out1)
# return(z) }
# Won't see anything, function just enters memory, have to call function
z <- myfunc(x=2, y=3)

#################################################################################

# A demo of user defined functions in R
# C Forman
# 2/5/26

#################################################################################

# looking at existing functions

sum(3,2)
3+2 #Arithmetic operator is a function, can be called to head of a statement
`+`(3,2)

y <- 3 # Called an infix function
`<-`(yy, 5) # Even assignment operator is a function

print(read.table)

# Creating a function

# Use hashtag delineator to wrap function

# Start function called adder_subtractor
###########################################################################
adder_subtractor <- function(x = 1, y = 2, z = TRUE){
# Name: adder_subtractor
# Operation: It does some random math depending on the value of z
# Inputs: (3 inputs):
  # x (numeric scalar value, default = 1): one of the numbers to be operated on
  # y (numeric scalar value, default = 2): one of the numbers to be operated on
  # z (logical, default = TRUE): A switch to decide on subtracting or adding
# Outputs: numeric value resulting from addition or subtraction
# These comments stay in function so they will travel with it
  
  if(z == TRUE){
    out <- x + y
  }else{
    out <- x - y
  }
  
  return(out)
}
###########################################################################
# End of function

v <- adder_subtractor()
v
v <- adder_subtractor(x = 7, y = 4)
v
v <- adder_subtractor(x = 7, y = 4, z = TRUE)
v
v <- adder_subtractor(x = 7, y = 4, z = FALSE)
v

adder_subtractor(x = 7, y = 4, operation = "division")

# Hardy-Weinberg Function

# START FUNCTION
hardy_weinberg <- function(p = runif(1)){
#####################################################################
    # FUNCTION: hardy_weinberg
    # operation: does a Hardy-Weinberg equilibrium problem
    # input = p: allele frequency of dominant allele
    # output = q (recessive): the frequencies of the 3 genotypes (fAA, fAB, fBB)
    q <- 1 - p # defined q
    fAA <- p^2
    fAB <- 2*p*q
    fBB <- q^2
  
    # store data for output
    out_vec <- signif(c(p = p, q = q, AA = fAA, AB = fAB, BB = fBB), digits = 3) #Signif because it usually returns long floats
    # return values
    return(out_vec)
  
  print(c(q,p)) # This is called a side effect, printing but not being stored
  
}
  #####################################################################
# END FUNCTION

hardy_weinberg()
hardy_weinberg(p = 0.3)
hardy_weinberg(p = 9) # Need to check for things like this, can put warning or break function

# global vs local parameters
my_func <- function(a = 3, a = 4){}
  z <- a + b
  return(z)
my_badfunc <- function(a=3){
  b <- 8
  z <- a + b
  return(z)
}
my_badfunc()

# passing global variables properly

a <- 32
b <- 4

my_func_2 <- function(first, second){
  z <- first + second
  return(z)
}
my_func_2(first = a, second = b) # Using global variables but being passed into function
# Global variables are outside of the function, if you need to use them in a function, alwaays pass them in
# Coding warning messages into code that can tell the user what exactly is wrong is helpful


# START FUNCTION
hardy_weinberg <- function(p = runif(1)){
#####################################################################
    # FUNCTION: hardy_weinberg
    # operation: does a Hardy-Weinberg equilibrium problem
    # input = p: allele frequency of dominant allele
    # output = q (recessive): the frequencies of the 3 genotypes (fAA, fAB, fBB)
    if (p > 1 | p < 0){
      stop("Function failure p must be greater than 0 but less than 1")
    }
  
    q <- 1 - p # defined q
    fAA <- p^2
    fAB <- 2*p*q
    fBB <- q^2
  
    # store data for output
    out_vec <- signif(c(p = p, q = q, AA = fAA, AB = fAB, BB = fBB), digits = 3) #Signif because it usually returns long floats
    # return values
    return(out_vec)
  
  print(c(q,p)) # This is called a side effect, printing but not being stored
  
}
  #####################################################################
# END FUNCTION

hardy_weinberg(p = .3)
hardy_weinberg(p = 3) # This doesn't make biological sense but it does mathematical
# Using stop gives a true error statement that tells you where the error is while return just has it as a character string

# regression function
# START OF FUNCTION 
#######################################################################
fit_linear <- function(x = runif(20), y = runif(20)){

#######################################################
# FUNCTION: fit_linear
# PURPOSE: fits a simple linear regression
# INPUTS: numeric vector of predictors x and response y
# OUT: slope and p value
  my_mod <- lm(y~x) # here's the model

  # get values out
  my_out <- c(slope=summary(my_mod)$coefficients[2,1], 
  p_value=summary(my_mod)$coefficients[2,4])

  # plot the output
  plot(x=x, y=y)
  return(my_out)
}
########################################################
# END OF FUNCTION

var1 <- 1:20
var2 <- 21:40

fit_linear(x = var1, y = var2)

# more complicated defaults...
#######################################################################
fit_linear <- function(p = NULL){

#######################################################
# FUNCTION: fit_linear
# PURPOSE: fits a simple linear regression
# INPUTS: numeric vector of predictors x and response y
# OUT: slope and p value
  if(is.null(p)){
    p <- list(x=runif(20), y=runif(20))
  }
  my_mod <- lm(p$x~p$y) # fit the model

  # get the outputs
   my_out <- c(slope=summary(my_mod)$coefficients[2,1], 
  p_value=summary(my_mod)$coefficients[2,4])

  plot(x=p$x, y=p$y) # quick and dirty plot to check output

  return(my_out)
}

fit_linear()

my_parms <- list(x = 1:10, y = sort(runif(10)))
my_parms

fit_linear(p = my_parms)