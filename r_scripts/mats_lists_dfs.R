# Lists, Matrices, and Data Frames
# C Forman
# 29 Jan 2026

###########################################

#creating a mat from a vector

my_vec <- 1:12

# numbers by rows
m <- matrix(data = my_vec, nrow = 4)
m

# filling matrix the other way (123 across instead of down)
m <- matrix(data = my_vec, ncol = 3, byrow = TRUE)
m

# lists
my_list <- list(1:10, matrix(1:8, nrow = 4, byrow = T), letters[1:3], pi)
my_list

# indexing a list
my_list[1]
str(my_list[1]) #shows that list isn't stored as integers but a string so can't add 1 to it or something
my_list[[1]] #double brackets pulls list as the actual list of integers not as a string

# indexing into a matrix
my_list[[2]][1,2] #rows, cols

# naming lists
my_list2 <- list(tester=FALSE, little_m = matrix(1:9, nrow = 3))
my_list2

# named objects in lists
my_list2$little_m[2,3] #don't have to use double brackets here because you're already pulling

# looking at empty place indexing
my_list2$little_m[1,] 
my_list2$little_m[1]
my_list2$little_m[2] #essentially flattens out matrix into vector if you don't use comma

# unlist
unrolled <- unlist(my_list2)
unrolled #since tester was false, it's automatically read as a 0

# unpacking complex lists
library(ggplot2)

# creat some random vars
y_var <- runif(10)
x_var <- runif(10)

# regress
my_model <- lm(y_var~x_var) #sets y as a function of x

# plot it
qplot(x=x_var, y=y_var)
print(my_model)

# explore structure
summary(my_model)
str(summary(my_model))

# extracting values like p-values
summary(my_model)$coefficients[1,1]
summary(my_model)$coefficients["x_var","Pr(>|t|)"]

u <- unlist(summary(my_model))
print(u)

u$coefficients2
pval <- u$coefficients8

# data frames
var_a <- 1:12
var_b <- rep(c("A", "B", "C"), 4)
var_c <- runif(12)

# creating a data frame from vectors
df <- data.frame(var_a, var_b, var_c)
df

str(df)

df$var_b
df[1,1] #not a useful way of accessing data in a df
df$var_a[1] #easier

#expanding the data frame
new_data <- list(var_a = 13, var_b = "D", var_c = 0.77)

df2 <- rbind(df, new_data) #row binding to append to df
df2

head(df2)
tail(df2)
head(df2, 10)
View(df2) #useful for looking at data frames in viewer

# add a new column to a data frame
df2

# using cbind (column bind)
new_var <- rnorm(13)
df3 <- cbind(df2, new_var)
df3
str(df3)

# using assignment operator
char_var <- rep("T", 13)
df3$charV <- char_var # $ usually used for pulling variable out but can also be used to add, good for adding 1 column
df3

# writing data frames
write.csv(df3, "data/my_dataframe.csv") # data/ adds it into my folder named data, the rest makes the csv

# calling data frame back
data <- read.csv("data/my_dataframe.csv")
data$var_a
