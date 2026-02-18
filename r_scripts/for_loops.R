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

# Working with for loops
# P. Alexander Burnham
# 12 February 2026

# LOGISTIC GROWTH FUNCTION
######################################################
# Function Name: logistic_growth
#
# Purpose:
#   Simulates continuous-time logistic population growth using the
#   closed-form solution to the logistic differential equation.
#   Returns a tidy dataframe suitable for plotting or further analysis.
#
# Inputs:
#   N0 (numeric)  : Initial population size at time t = 0
#   r  (numeric)  : Intrinsic growth rate
#   K  (numeric)  : Carrying capacity
#   t_max (numeric) : Maximum simulation time
#   dt (numeric)  : Time step used to generate the time vector
#
# Output:
#   data.frame containing:
#     time (numeric)        : Time values from 0 to t_max
#     population (numeric)  : Population size N(t) at each time
#     N0 (numeric)          : Initial population parameter used
#     r (numeric)           : Growth rate parameter used
#     K (numeric)           : Carrying capacity parameter used
######################################################
logistic_growth <- function(
  N0 = 10,
  r  = 0.3,
  K  = 100,
  t_max = 50,
  dt = 0.1
){
  
  # time vector
  time <- seq(0, t_max, by = dt)
  
  # logistic equation (closed-form solution)
  N <- K / (1 + ((K - N0) / N0) * exp(-r * time))
  
  # return tidy dataframe
  data.frame(
    time = time,
    population = N,
    N0 = N0,
    r = r,
    K = K
  )
}
######################################################
# END FUNCTION

# 1. Initialize vector of 1000 r values from 0 to 1
r_values <- seq(0, 1, length.out = 1000)

# 2. Initialize storage container
max_n_values <- numeric(length(r_values))

# 3. Loop through r values
for (i in seq_along(r_values)) {
  temp <- logistic_growth(r = r_values[i])
  max_n_values[i] <- max(temp$population)
}

# make data frame
df <- data.frame(r_values, max_n_values)
names(df) <- c("r", "max(N)")


plot(x = df$r, y = df$`max(N)`)





##################################
# 2D parameter sweep for log growth function
# outputs matrix


# vectors for r and k parameters
r_values <- seq(0, 1, length.out = 100)
K_values <- seq(10, 1000, length.out = 100)


growth_sweep <- function(rvec, kvec){

  # create storage matrix for outputs
  stor_mat <- matrix(NA, nrow = length(rvec), ncol = length(kvec))

  for (i in seq_along(rvec)){ # rows
    for (j in seq_along(kvec)){ # cols

      # run log growth
      tmp_df <- logistic_growth(r = rvec[i], K = kvec[j])

      # store max n in 2d matrix
      stor_mat[i,j] <- max(tmp_df$population)
    }
  }
  return(stor_mat)
}

# run growth param sweep
growth_mat <- growth_sweep(rvec = r_values, kvec = K_values)









##################################
# 2D parameter sweep for log growth function
# outputs a data frame

numParms <- 100


# vectors for r and k parameters
r_values <- seq(0, 1, length.out = numParms)
K_values <- seq(10, 1000, length.out = numParms)



growth_sweep <- function(rvec, kvec){

  # row indexing variable
  counter <- 1

  # create storage dataframe
  dfLength <- length(rvec)*length(kvec) # how long is DF
  r_out <- rep(NA, dfLength)
  k_out <- rep(NA, dfLength)
  maxn_out <- rep(NA, dfLength)

  # turn vecs into df
  storageDF <- data.frame(r_out, k_out, maxn_out)


  # enter our loops
  for (i in seq_along(rvec)){ # rows
    for (j in seq_along(kvec)){ # cols

      # run log growth
      tmp_df <- logistic_growth(r = rvec[i], K = kvec[j])

      # store max n in dataframe
      storageDF$maxn_out[counter] <- mean(tmp_df$population)
      storageDF$r_out[counter] <- rvec[i] # value for r stored
      storageDF$k_out[counter] <- kvec[j] # value for k stored

      counter <- counter + 1 # increase counter
    }
  }
  return(storageDF)
}

# run growth param sweep
df <- growth_sweep(rvec = r_values, kvec = K_values)

df

ggplot(data = df, aes(x = r_out, y = k_out, fill= maxn_out)) + 
  geom_tile()









# create a random walk function

###############################
# NAME: ran_walk
# purpose: conducts a random walk
# input:times = number of time steps
#       n1 = initial pop size
#       lamda = finite rate of increase
#.      noise_sd = 10
# output:
#          vector n with population size > 0 until extinct.
#
library(ggplot2)



ran_walk <- function(times = 100, n1=50, lamda = 1, noise_sd = 10){
  n <- rep(NA, times) # create our output vec
  n[1] <- n1 # initialize init pop size
  noise <- rnorm(n = 100, mean = 0, sd = noise_sd) # created noise/error

  for (i in 1:(times-1)){
    n[i + 1] <- lamda*n[i] + noise[i]
    if(n[i + 1] <= 0){
      n[i + 1] <- NA
      cat("Population extinction at time", i+1, "\n")
      break
    }
  }
  return(n)
}

x <- ran_walk()
print(x)

# plotting with default values
qplot(x=1:100, y=ran_walk(), geom="line")

# no noise/not so random walk
qplot(x=1:100, y=ran_walk(noise_sd=0), geom="line")

# no noise and adjust lamda
qplot(x=1:100, y=ran_walk(lamda = 0.92, noise_sd=0), geom="line")

# add some stoch. make lamda > 1
qplot(x=1:100, y=ran_walk(lamda = 1.01, noise_sd=6), geom="line")




#############################################################################



numParms <-  3

# vectors for r and k parameters
r_values <- seq(0, 1, length.out = numParms)
K_values <- seq(10, 1000, length.out = numParms)


growth_sweep <- function(rvec, kvec){

  #create storage dataframe
 dfLength <-length(rvec)*length(kvec) #how long is df
  r_out <- rep(NA, dfLength)
  k_out <- rep(NA, dfLength)
  maxn_out <- rep(NA, dfLength)

  # turn vecs into df
  storageDF <- data.frame(r_out, k_out, maxn_out)
# create storage matrix for outputs
stor_mat <- matrix(NA, nrow = length(r_values), ncol = length(K_values))

  # row indexing variable
  counter <- 1
  #enter our loops
  for(i in seq_along(r_values)){ # rows
    for (j in seq_along(K_values)){ # cols


# run log growth
tmp_df <- log_growth(r = r_values[i], K = K_values[j])
  
  counter

# store max n in 2d matrix
#stor_mat[i,j] <- max(tmp_df$population)
# store max in dataframe
      storageDF$maxn_out[counter] <- max(tmp_df$population)
      storageDF$r_out[counter] <- rvec[i]
      storageDF$k_out[counter] <- kvec[i]
      counter <- counter + 1 # increase counter
    }
    return (storageDF)
  }
# run growth param sweep
#growth_mat <- growth_sweep(rvec = r_values, kvec = K_values)
  df <- growth_sweep(rvec = r_values, kvec = K_values)
}
df

ggplot(data = df, aes(x = r_out, y = k_out, fill = maxn_out)) +
  geom_tile()

# create a random walk function

#############################################
# NAME: ran_walk
# purpose: conducts a random walk
# input: times = number of time steps
        # n1 = initial pop size
        # lambda = finite rate of increase
        # noise_sd = 10
# output: 
          # vector n with population size > 0 until extinct
library(ggplot2)

ran_walk <- function(times = 100, n1 = 50, lambda = 1, noise_sd = 10){
  n <- rep(NA, times) # create our output vec
  n[1] <- n1 # initialize init pop size
  noise <- rnorm(n = 100, mean = 0, sd = noise_sd) # created noise/error; could have put this in the loop but this is more efficient to just do it all at once

  for(i in 1:(times-1)){
    n[i + 1] <- lambda*n[i] + noise[i] # adding noise to create the random walk, need to do i+1 because n[1] is already done
    if(n[i + 1] <= 0){
      n[i + 1] <- NA
      cat("Population extinction at time", i+1, "\n")
      break
    }
  }
  return(n)
}

x <- ran_walk()
print(x)

#plotting with default values
qplot(x=1:100, y=ran_walk(), geom="line")

#no noise/not so random walk
qplot(x=1:100, y=ran_walk(noise_sd = 0), geom="line")

#no noise and adjust lambda
qplot(x=1:100, y=ran_walk(lambda = .92, noise_sd = 0), geom="line")

#add some stochasticity back. make lambda > 1
qplot(x=1:100, y=ran_walk(lambda = 1.01, noise_sd = 10), geom="line")
  