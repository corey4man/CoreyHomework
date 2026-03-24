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
# extend, remove, pop (removes and saves removed), clear (delete)
mixed.pop()
mixed.append("green")
mixed.remove("start")

# pop pulls last value from data stack and saves it outside of the stack and you can put it back in later (linear scaled so you can pop out and back in in a loop)

mixed.remove("start")
last = mixed.pop() # default picks last one

# list comprehensions, like for loops in one line

print(mixed)

[x for x in mixed]

[x for x in mixed if isinstance(x, str)]

###########################################
# dictionaries
###########################################

md = {
    "first":"John", #Key and then value
    "last":"Smith",
    "year":2017,
    "status":"active"
}

 # above is hardcoding, this is another way to do it using constructor function
md2 = dict(first = "john", last = "Smith")
print(md)
type(md)
len(md)

# data types within a dictionary
dataTypes = {
    "string":"thing",
    "integer":3,
    "float":3.14342,
    "list":[1,2,3,"a"],
    "boolean":False
}

# calling values by using key name in brackets
dataTypes["string"]

# using get instead, built in method
dataTypes.get("boolean")
dataTypes.keys()
dataTypes.values()

# return as a list of tuples
dataTypes.items()

# add element
dataTypes["age"] = 36
dataTypes

# change value within a dictionary
dataTypes["age"] = 35
dataTypes

# arrays are like lists of lists, not vectorizable (so can't like multiply them)
################################################
# NUMPY (everyone uses Numpy, it's basically part of it now)

arr1 = np.array([0,1,2,3,4,5,6,7,8,9])
 # array not a method within numpy object, an array function but specifically written in numpy package
arr1[3]
arr1[-1]
arr1[:3]
arr1[1:5]
arr1[1:8:3] # gives every 3rd element from 1-8

#2d array
arr2 = np.array([[1,2,3],[4,5,6],[7,8,9]])
arr2[2,2]
arr2[:,2] # gives 3rd element of all lists
arr2[2,:] # gives 3rd list
arr2[0:2, 0:2]

#3d array
arr3 = np.array([[[1,2],[3,4]],[[5,6],[7,8]]]) # list of list of lists
arr3

# 3d indexing
arr3[1,0,1] #layer, row, column
arr3

# querying numpy array: dimensions
arr1.ndim
arr2.ndim
arr3.ndim
# shape of an array
arr1.shape
arr2.shape
arr3.shape

arr2.dtype
arr2.astype(str)

# reshaping an array
arr1.shape
arr1.reshape(2,5) # made it 2d

# 3d array to 2d
arr3.shape
arr3.reshape(4,2)

# combining arrays
first = np.array([1,2,3])
second = np.array([4,5,6,7,8,9])

longArray = np.concatenate((first, second))

# select axis for higher dims
newStack =np.concatenate((arr2, arr2), axis = 0) #will concatenate on first axis, can have as many axes as dimensions
newStack

# stacking arrays
newStack = np.stack((arr2, arr2))
newStack.shape

# splitting arrays
np.array_split(arr1, 2) # how to split array; into 2 parts
np.array_split(arr1, 2, axis = 0)

# random numbers
from numpy import random

random.seed(seed = 100)
random.randint(50) # value from 0 to 50
random.rand(50) # like runif, 50 random numbers from 0-1
random.rand(50, 5, 10) # 5x10 array of 50 random values
random.choice(arr1) # will give random number from arr1
random.choice(arr1, size = (3,3)) # pulls randomly from arr1 to make 3x3 matrix
random.choice([0,1], p = [.3,.7], size = 100) # pulls from 0 and 1 array but 0s pulled with probably of 30%

x = random.normal(loc = 5, scale = 3, size = 200)

plt.hist(x)
plt.show()

x = random.binomial(n = 10, p = 0.5, size = 30)
print(x)
plt.hist(x)


x = random.uniform(low = 1, high = 10, size = 50)
print(x)

# math
# math b/w arrays, symbols are the same as R

x * 100

arr2 * arr2

np.mean(arr2)
np.max(arr2)

##########################################################################
# logic structures
##########################################################################

# if stat.

a = 6

if a >= 5:
    print("a is greater than or equal to 5") # notice no parentheses or anything just indentation)

# with else statement
if a >= 5:
    print("a is greater than or equal to 5")
else:
    print("a is less than 5")

a = 3
b = 3
operation = "add"

if operation == "mult":
    y = a * b
elif operation == "div": # not else, just adding another if basically
    y = a / b
elif operation == "add":
    y = a + b
elif operation == "sub":
    y = a - b
else:
    y = "I don't know that operation" # else captures all other possibilities

############################################################
# LOOPS
############################################################

l = [10, 20]

for i in range(2):
    print(l[i])

# loop on an object directly
x = ["blue", "green", "red"]
for i in x:
    print(i)

# a more complicated loop
rnd = random.uniform(low = 1, high = 5, size = 10)

outList = [] # truly empty list

for i in range(len(arr1)):
    outList.append(rnd[i] + arr1[i])
outList

# nested loop with ifelse

rnd2D = random.uniform(low = 0, high = 1, size = (3,3)) # 9 but automatically filled as 3x3 array
rnd2D

matOut = np.empty(shape = (3,3)) # why does empty matrix repopulate with old array
matOut
shp = rnd2D.shape

# nested loop
for i in range(shp[0]):
    for j in range(shp[1]):

        if rnd2D[i,j] >= 0.5:
            matOut[i,j] = rnd2D[i,j] * 1000
        else:
            matOut[i,j] = rnd2D[i,j] / 1000
matOut


#####################################################
# PANDAS DFs
#####################################################
# pandas is like dataframes, written in C

dates = pd.date_range("20130101", periods = 6)
dates # defaulted to days and adds 5 days

df = pd.DataFrame(np.random.randn(6,4), index = dates, columns = list("ABCD")) # index is basically row name
df

# df methods
df.head(4)
df.tail(4)
df.index
df.columns

df.describe()

df.to_numpy() # numpy conversion

# indexing into pandas
df["A"]
df.loc[:,["A", "B"]]
df["20130102":"20130104"]

# read in csv file
ds = pd.read_csv("iris.data.csv")
ds

ds["sepal_length"] # pulling col out

ds["sepal_area"] = ds.sepal_length * ds.sepal_width # creates new column stored in dataset

# full numeric filter
df[df>.5] # converted those values to NA, but didn't store
