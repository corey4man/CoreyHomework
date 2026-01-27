# This is a document describing vectors in R
# 22 Jan 2026
# CF

#--------------------------------------------
# START OF SCRIPT

x <- 5
print(x)
x

y=3 #Better to use print in R

plant_height <- 3 #Snake case, better for non-native English speakers
plantHeight <-4 #Camel case
plant.height <- 2 #Not prefered syntax but works, R automatically does sometimes
# . is a good temporary variable because it isn't reserved in R
#1D Homogeneous is vector and heterogeneous is list
#2D Homogeneous is matrix and heterogeneous is data frame
#ND Homogeneous is array and heterogeneous is list of lists

# 1D atomic vec
z <- c(3.2, 5, 5, 6)
print(z)
typeof(z) #Double has decimal places

z <- c(c(3.2,3),c(3,5))
z
is.numeric(z)
is.character(z)

# Character strings
t <- "perch"
print(t)

t <- c("perch","bass","trout")
print(t)
t[1]

typeof(t)
is.numeric(t)

t <- c("This is a 'character' string", "a second")
t[1]
t[2]

# Logical/Boolean
z <- c(TRUE, FALSE, TRUE)
print(z)
is.logical(z)
typeof(z)

c(T, F) #Advised to write whole word because this can get confusing

mean(z)

# Vector properties
z <- c(c(3.2,3),c(3,5))
z
typeof(z) #Gives type
is.numeric(z) # is. gives logical
t <- as.character(z) # as. coerces variable
typeof(t)

t <- c(1, 2, "3", 4) #Heterogeneous with 1 character so will convert all to characters

length(t)

# Random number generator
z <- runif(5)
names(z)
print(Z)

names(z) <- c("A", "B", "C", "D", "E")

print(z)

names(z) <- NULL
names(z)

# Special data types
z <- c(3.2, 3, 3, NA)
print(z)
typeof(z)
length(z)
typeof(z[3])
typeof(z[4])

sum(z)
sum(z, na.rm=T) #NA is an unknown

z <- 0/0
print(z)

z <- 1/0
z

# Vectorization
z <- c(10, 20, 30)
z + 1
z / 3

y <- c(1, 2, 3)

z + y

# Recycling
x <- c(1, 2)
z + x

#################################
# Atomic Vecs Part II

z <- vector(mode = "numeric", length = 0) #Empty vector
print(z)
#Dynamic creation, will do in Python but not in R because R creates them exponentially and Python is linear
z <- c(z, 5)
print(z) 

# Predefined Length
## Empty vectors - 2 methods
z <- rep(0, 100)
print(z)
length(z)

z <- rep(NA, 100)
z

typeof(z)

z[1] <- "Vermont"
head(z)
typeof(z)

my_vector <- runif(100)
my_names <- paste("Species", seq(1:length(my_vector)), sep="")
print(my_names)

names(my_vector) <- my_names
head(my_vector)
str(my_vector)

# using the rep function
rep(0.5, 6)
rep(x = 0.5, times = 6) #same thing but more readable

my_vec <- c(1,2,3)

# repeat a vector
rep(x = my_vec, times = 2, each = 2)

# sequencing vectors
seq(from = 2, to = 4)
2:4

x <- seq(from = 2, to = 4, length = 7)

my_vec <- 1:length(x) #common in other languages but slow in R
my_vec

#better in R
seq_along(my_vec)

#generating random vectors

runif(5) #gives us 5 values 0 to 1

#the params
runif(n=3, min=100, max=101)

set.seed(123) #takes any number

#gives you the same progression of random nums
runif(n=1, min=0, max=1)

# normal distribution
out <- rnorm(n = 500, mean = 100, sd = 30) #randomly sampling from this distribution
hist(out)

# random sampling

long_vec <- seq_len(10)
sample(x = long_vec, size = 100, replace = T)

# weighted sampling from a vec
weights <- c(rep(20, 5), rep(100, 5))
weights

sample(x = long_vec, replace=TRUE, prob=weights)

#subsetting vectors
z <- c(3.1, 9.2, 1.3, 0.4, 7.5)
z
z[1]
z[-1]

z[c(2,3)]

z[-c(2,3)] #using vecs to slice

#using logicals
z[z<3]
z[!z<3] #! means not, so this means greater than 3

#relational operators
# < > <= >= ==

#logical operators
# ! not, & and (vector), | or (vector), xor(x,y) (xor means either x or y is true, only wants one to be true)

x <- 1:5
y <- c(1:3,7,7)

x == 2
x != 2

x == 1 & y == 7
x == 5 & y == 7

x == 1 | y == 7
x == 3 | y == 3

x == 3 & y == 3

xor(x==3, y==3)
xor(x==3, y==5)

#missing values
set.seed(90)
z <- runif(10)

z< 0.5
z[z < 0.5]
which(z < 0.5) #gives index of where values are
which(z < 0.5)

zd <- c(z, NA, NA)
zd

zd[zd <0.5]

#dropping NAs with which to index
zd[which(zd < 0.5)]

zd[11]
