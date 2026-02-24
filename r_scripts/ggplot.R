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
  geom_bar() +
  labs(fill = "Fuel Type", x = "Fuel Type", y = "Count") +
  theme(legend.position = c(.2, .8)) # Could also do like legend.position="Top"
p2

p2 + coord_flip() + theme_grey(base_size = 20, base_family = "sans")

# setting x and y lims
p1 <- ggplot(data = d, mapping = aes(x = displ, y = cty)) + 
  geom_point() +
  theme_bw() +
  xlim(0, 8)
  ylim(0, 50)
p1

###################################################################
# multi panel plots

library(patchwork)
library(ggthemes)

g1 <- ggplot(data = d) +
  aes(x = displ, y = cty) +
  geom_point() +
  geom_smooth()
g1

g2 <- ggplot(data = d) +
  aes(x = fl) +
  geom_bar(fill = "tomato", color = "black") # Setting fill with multiple colors automatically makes legend
g2

g3 <- ggplot(data = d) +
  aes(x = displ) +
  geom_histogram(fill = "royalblue", color = "black")
g3

g4 <- ggplot(data = d) +
  aes(x = fl, y = cty, fill = fl) +
  geom_boxplot() +
  theme(legend.position = "none") # How to remove a legend
g4

g1 + g2

#plot three plots
g1 + g2 + g3 + plot_layout(ncol = 1)

# changing area of each plot
g1 + g2 + plot_layout(ncol = 1, heights = c(2,1)) #Makes top figure twice as tall as bottom figure

# in the other dimension
g1 + g2 + plot_layout(ncol = 2, widths = c(1,2))

# adding spacers
g1 + plot_spacer() + g2

# nested layouts
g1 + {
  g2 + {
    g3 +
      g4 +
      plot_layout(ncol = 1)
  }
} +
  plot_layout(ncol = 1)

# - operator for subtrack placement
g1 + g2 - g3 + plot_layout(ncol = 1)

# using | and /

(g1 | g2 | g3) / g4 + plot_annotation("Title Here",
caption = "made this patchwork")

# adding tags
g1 / (g2 | g3) +
  plot_annotation(tag_levels = "A")

####################################################################
# multi-panel plots with facet

m1 <- ggplot(data = d) +
  aes(x = displ, y = cty) +
  geom_point() + # Could just add facet to this variable as well
  geom_smooth(method = "lm")

# using facet grid
m1 + facet_grid(class ~ fl, scales = "free_x") #Defaults to equal scales

# facet for only one variable
m1 + facet_grid(.~class) # . is placeholder

# facet wrap (doesn't allow you to have a variable as a function of the other but can do them separately)
m1 + facet_wrap(~class + fl, drop = F) # Notice it stripped non-existent combinations, add drop = F
