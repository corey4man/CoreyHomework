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
