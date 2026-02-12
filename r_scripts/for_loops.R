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

for (i in seq_along(my_dogs)){ # seq along better than length because it handles empty vectors better
   cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")
}

# Tip 1:
# Don't do things in a loop that you don't need to:

for (i in seq_along(my_dogs)){
  my_dogs[i] <- toupper(my_dogs[i])
}

tolower(my_dogs) #Could've done this instead of making a function
#Don't do things in a loop that don't need to be looped because the system will run it every loop

# Tip 2:
# Don't change dimensions in the loop
my_dat <- runif(1)
for (i in 2:10){
  temp <- runif(1)
  my_dat <- c(my_dat, temp)
  #cat("loop number =", i, my_dat[i], "\n") #Could've just made vector of length 10 since we were just pulling my_dat
  print(my_dat)
}

# Tip 3:
# Don't write a loop if you can vectorize it
my_dat <- 1:10
for(i in seq_along(my_dat)){
  my_dat[i] <- my_dat[i] + my_dat[i]^2
  cat("loop number =", i, "vector element =", my_dat[i], "\n")
}

# Can just do this
z <- 1:10
z <- z + z^2
z

# Tip 4:
# Remember the difference between i and z[i] (i is counter variable)

z <- c(10, 2, 4)
for (i in seq_along(z)){
  cat("i =", i, "z[i] =", z[i], "\n")
}

# Tip 5:
# Don't have to loop through everything

z <- 1:20

for(i in seq_along(z)){
  if(i %% 2 ==0) next
  print(i)
}


######################################
# look at the parameter space of the logistic
# growth model with a for loop

r_vec <- seq(0, 1, by = .05) # vector of little rs
container_vec <- rep(NA, length(r_vec)) # If you changed r_vec to by=0.1 for example, the length automatically updates for this

for (i in seq_along(r_vec)){
  temp_df <- log_growth(r = r_vec[i])
  max_n <- max(temp_df$popsize)
  container_vec[i] <- max_n # Storage is happening here
}
logdf <- data.frame(r = r_vec, popsize = container_vec)
logdf
############################################################################
log_growth <- function(N0 = 5, r = .1, K = 1000, tfinal = 100, tstep = 5){

times <- seq(from = 0, to = tfinal, by = tstep)

logdf <- data.frame(times, popsize = NA)

for (t in 1:length(times)){
    time <- logdf$times[t]
n <- (K/
    (1 + ((K-N0)/N0)*exp((-r)*time)))
logdf$popsize[t] = n
}

return(logdf)
}
#############################################################################