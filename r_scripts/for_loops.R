# basic coding with for loops
# 10 February, 2026
# C Forman

# for loops
for(i in 1:10){
  #Do things
  #For example
  print(i)
}

z <- c(1:10)
for(i in 1:10){
  print(z)
}

for(i in 1:10){
  t <- x[i] + y[i]
  z[i] <- t
}

# creating a basic for loop
for(i in 1:5){
  cat("stuck in a loop", "\n")
  cat(3+2, "\n")
  cat(runif(1), "\n")
}

my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")

for (i in 1:length(my_dogs)){
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}

my_bad_dogs <- NULL
for (i in 1:length(my_bad_dogs)){
   cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")
}

for (i in seq_along(my_dogs)){ # seq along better than length
   cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")
}
