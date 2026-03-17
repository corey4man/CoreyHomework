# Intro to Python
# More support and faster than R
# Uses nesting instead of all of the brackets (aesthetics are important in the philosophy)
# plotly package can make interactive graphs, also for graphs are matplotlib, seaborn
# other packages include scipy, panda, numpy, etc.

# Anatomy of a function
# object = function(data = ds, method = "mean", num = 10) only difference from R is = instead of <- 

# Python objects have methods
# object.python_method(method = "mean", num = 10)

# Installing libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
# Importing package as abbreviated version - these are canonical abbreviations that you always use
# Script language at heart so you generally write full script and just run it unless you're debugging but positron works like a debugger (line by line)

# Have to explicitly state the package the function you're using is from so:
# np.mean()

###################################
# Objects, Methods, and Functions
###################################

print("I love Python") # Always use print statement (R just uses it as a default but Python prefers explicit)

greeting = "Hello"
print(greeting)

scalar = 6 # Integer value

out = scalar * 3 # Doing math with an object
print(out)

myList = [34, 7, 98] # Creating a list

myList.append(33) # Our first method, lists (object since not a vector language) have built in methods

len(myList) # length function

# data structures:
#--------------------------------

# make a list of colors
a_list = ["blue", "green", "red"]
print(a_list)

# indexing into a list
print(a_list[0]) # 0 is first element in list

first_el = a_list[0]
print(first_el)

# looking at data types
nums = [1, 2, 5, 8,]
chars = ["a", "b", "c"]
boolean = [True, True, False] # Not all caps or just T/F like R

# mixed lists
mixed = [1, 2, True, "blue", 5]

# checking data types
type(nums)
type(nums[0])
# type returns highest level object type so list over integer

# negative indexing
mixed[-1] # returns last element

# ranged indexing
mixed[1:4]
mixed[:4] # Shows up to 4 places not to element 4 (3rd element)
mixed[2:]

# is an item in the list
1 in mixed

# changing elements
mixed[4] = "green"

# insert in a specific position without overwriting
mixed.insert(0, "start")

# other methods
# extend, remove, pop (add to the end), clear (delete)
