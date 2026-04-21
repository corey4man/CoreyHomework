# playing with probability distributions in R
# C Forman
# 21 April 2026

########################################################

############################
# Function: my_histo
# Purpose: creates a ggplot histogram
# Requires: ggplot
# Input: x = a numeric vector
#        data_type= "cont" or "disc"
# Output: a ggplot histogram
############################
library(ggplot2)
my_histo <- function(x=NULL,data_type="cont") { # If you don't include x var it won't run
  if(is.null(x)) x=runif(1000)
  df <- data.frame(x=x) 

# if data are continuous bounded (0,1), adjust bins for histogram  
  if (data_type=="cont" & min(df$x) > 0 & max(df$x) < 1) {
  p1 <- ggplot(data=df) +
    aes(x=x) +
    geom_histogram(boundary=0,
                   binwidth=1/30,
                   color="black",
                   fill="goldenrod") +
    scale_x_continuous(limits=c(0,1))}  

  
# if data are continuous, but not bounded (0,1), use
# ggplot default bins
  if (data_type=="cont" & (min(df$x) < 0 | max(df$x) > 1)) {
  p1 <- ggplot(data=df) +
    aes(x=x) +
    geom_histogram(color="black",
                   fill="goldenrod")}

     
  

# if data are discrete integers, 
#  use geom_bar to create a histogram
if (data_type=="disc") {
  p1 <- ggplot(data=df) + 
    aes(x=x) +
    geom_bar(color="black",fill="goldenrod") }
  
print(p1)
} 
my_histo()
my_histo(data_type="disc",x=rpois(1000,lambda=0.2)) # You have 1000 calls with lambda=0.2
my_histo(data_type="disc",x=rpois(1000,lambda=10)) # Shifting lambda pushes closer to normal
my_histo(data_type="cont",x=runif(1000))
my_histo(data_type="cont",x=rnorm(n=1000,mean=0,sd=1))
############################
# Function: my_pdf
# Purpose: creates a ggplot probability density function
# Requires: ggplot
# Input: x = a numeric vector of x values
#        y = pdf values calculated for each value of x
#        data_type= "cont" or "disc"
# Output: a ggplot pdf
############################
my_pdf <- function(x=NULL,y=NULL,data_type="cont") {
  if(is.null(x) | is.null(y)) {
    x=seq(from=-3,to=3,length.out=100)
    y=dnorm(x) }
  
    df <- data.frame(x=x,y=y) 
    
    # for continuous distributions, 
    # plot the line for the pdf
    if(data_type=="cont") {
      p1 <- ggplot(data=df) +
        aes(x=x,y=y) +
      geom_line() +
        geom_area(fill = "cornflower blue") } 
    
    # for discrete distributions,
    # plot a bar for the probability at each value
    if (data_type=="disc") {
      p1 <- ggplot(data=df) + 
        aes(x=x,y=y) +
        geom_col(color="black",fill="cornflower blue") }
    print(p1)
}
my_pdf()
my_x=seq(from=0,to=1,length.out=100)
my_pdf(x=my_x,y=dbeta(x=my_x,shape1=15,shape2=10)) # Beta distribution with shape1 of 15 and shape2 of 10
my_pdf(x=0:10,y=dpois(x=0:10,lambda=1.1),data_type="disc") #0-10 discrete with lambda of 1.1

library(MASS)

hits <- 0:10
myVec <- dpois(x=hits, lambda = 1)
myVec # Number 1 probability of having 0 events, Number 2 is probability of 1 event and so on

my_pdf(x = hits, y = myVec, data_type = "disc")


data <- c(100, 100, 104, 99)
z <- fitdistr(data, "normal")
z

hist(rnorm(n = 1000, mean = 100.75, sd = 1.9))

# frog data
frog_data <- c(20.15, 26.3, 27.5, 22.9, 27.8, 26.2)
frog_data

# fit normal frog data
z <- fitdistr(frog_data, "normal")
print(z)

x <- 1:100

frog_density <- dnorm(x = x, mean = 26.8, sd = 2.18)

qplot(x, frog_density, geom="line")

z <- fitdistr(frog_data, "gamma")
z

# gamma density
frog_gamma <- dgamma(x, shape = 147.2, rate = 5.5)

qplot(x, frog_gamma, geom="line")

# introducing outlier to add skewness
newFrogData <- c(frog_data, 0.05)
z <- fitdistr(newFrogData, "gamma")
z

# gamma density
frog_gamma <- dgamma(x, shape = 0.8, rate = .035)
qplot(x, frog_gamma, geom="line")
