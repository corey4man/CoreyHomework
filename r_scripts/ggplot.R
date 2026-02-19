# basics of ggplot
# C Forman
# 19 Feb 2026

#START CODE HERE
##############################################################

#p1 <- ggplot(data= <DATA>) +
 #     aes(<MAPPINGS>) + 
  #    <GEOM_FUNCTION>(aes(<MAPPINGS>),
   #                 position=<POSITION>) +
     #                 <COORDINATE_FUNCTION> +
      #                <FACET_FUNCTION>
# required packages for this script
library(ggplot2)
library(ggthemes)
library(patchwork)

# load our dataset (mpg)
d <- mpg

# our first call to ggplot: histogram
ggplot(data = d) +
  aes(x = hwy) +
  geom_histogram()

# change colors of histogram
ggplot(data = d) +
  aes(x = hwy) +
  geom_histogram(fill = "slateblue", color = "black")

# density plot
ggplot(data = d) +
  aes(x = hwy) +
  geom_density(fill = "mintcream")

# scatter plot
ggplot(data = d) +
  aes(x = displ, y = hwy) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm", col = "red")

# boxplot
ggplot(data = d) +
  aes(x = fl, y = cty) +
  geom_boxplot(fill = "thistle", color = "blue")

# basic barplot
ggplot(data = d) +
  aes(x = fl) +
  geom_bar()

# barplot with y response
x_treatment <- c("control", "low", "high")
y_response <- c(12, 2.5, 22)
summary_data <- data.frame(x_treatment, y_response)

ggplot(data = summary_data) +
  aes(x = x_treatment, y = y_response) +
  geom_col(fill = c("grey50", "goldenrod", "goldenrod"), color = "black")

# plotting curves
my_vec <- seq(1, 100, by = 0.1)

# plot a simple function
d_frame <- data.frame(x = my_vec, y = sin(my_vec))

# plot lines
ggplot(data = d_frame) +
  aes(x = x, y = y) +
  geom_line()

d_frame <- data.frame(x = my_vec, y = dgamma(my_vec, shape = 5, scale = 3))

ggplot(data = d_frame) +
  aes(x = x, y = y) +
  geom_line()

# themes and fonts
p1 <- ggplot(data = d, mapping = aes(x = displ, y = cty)) + # can call aes in function vs adding as a layer
  geom_point()

p1

p1 + theme_classic() # another way to add layers, often more readable if ggplot is long

p1 + theme_minimal()
p1 + theme_linedraw()
p1 + theme_dark() # good for presentations if using colors but not for publication
p1 + theme_base()
p1 + theme_void()
p1 + theme_par()

# changing font size and type
p1 + theme_classic(base_size = 30, base_family = "serif")

# code for adding additional fonts
library(extrafont)
font_import() # imports all system fonts (run once)

# using other fonts for presentations
p1 + theme_classic(base_size = 35, base_family="Chalkduster")

# coordinate flipping in ggplot
p2 <- ggplot(data = d, mapping = aes(x=fl, fill=fl)) +
  geom_bar()
p2

p2 + coord_flip() + theme_grey(base_size = 20, base_family = "sans")

# setting x and y lims
p1 <- ggplot(data = d, mapping = aes(x = displ, y = cty)) + 
  geom_point() +
  theme_bw() +
  xlim(0, 8)
  ylim(0, 50)
p1
