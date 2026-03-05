# looking at colors and color mapping in ggplot
# C Forman
# 24 Feb 2026

##################################################
install.packages("colorspace")
install.packages("wesanderson")
install.packages("ggsci")
install.packages("devtools") # lets you pull packages from github in addition to CRAN (doing because some of these packages are deprecated from cran)

devtools::install_github("wilkelab/cowplot") # :: ensures only using functions from devtool package, good for if several packages have functions with same name
devtools::install_github("clauswilke/colorblindr")
install.packages("colorspace", repo = "http://R-Forge.R-project.org")

library(ggplot2)
library(ggthemes)
library(colorblindr)
library(colorspace)
library(wesanderson)
library(ggsci)

# Pale colors for large geoms (fills) and bright colors for small geoms (lines, points)
# Pale, grey to deemphasize or bright to emphasize
# Color blind visible, colors that convert well to b&w

# Neutral colors for control group (black, gray, white), symbolic colors (red for heat, etc.)
# Continuous scale, monochromatic (differing shades of one color)
# Show color names, hex in base R
# Show color schemes in colorbrewer

#Create custom color palette
my_cols <- c("green", "thistle", "tomato", "cornsilk", "chocolate")

demoplot(my_cols, "map")
demoplot(my_cols, "bar")
demoplot(my_cols, "scatter")
demoplot(my_cols, "heatmap")
demoplot(my_cols, "spine")
demoplot(my_cols, "perspective")

# Working with b&w color schemes

# choose grey but grey has scale(0=black, 100=white)
my_greys <- c("grey20", "grey50", "grey80")
demoplot(my_greys, "bar")

my_greys2 <- grey(seq(from=0.1,to=0.9,length.out=10))
demoplot(my_greys2, "heatmap")
d <- mpg
p1 <- ggplot(d, aes(x=as.factor(cyl), y=cty, fill=as.factor(cyl)))+geom_boxplot() # If there are like just 4 & 6, without as.factor would add 5 but as.factor makes them discrete
p1
# Default colors that look identical in black and white
p1_des <- colorblindr::edit_colors(p1, desaturate)
plot(p1_des)

#Set transparency of images using the alpha
x1 <- rnorm(n=100, mean=0)
x2 <- rnorm(100, mean=2.7)

d_frame <- data.frame(v1=c(x1,x2))
lab <- rep(c("Control", "Treatment"), each = 100)
d_frame <- cbind(d_frame, lab) #Adding labels from lab to d_frame
h1 <- ggplot(d_frame)+aes(x=v1, fill = lab)
h1+geom_histogram(position="identity", alpha = 0.5, color="black")

# Discrete classifications
# scale_fill_manual for boxplots or barplots
# scale_color_manual for points, lines

# boxplot with no colors

p_fil <- ggplot(d)+aes(x=as.factor(cyl),y=cty)+geom_boxplot()
p_fil

# Boxplot default ggplot fill
p_fil <- ggplot(d, aes(x=as.factor(cyl),y=cty, fill = as.factor(cyl)))+geom_boxplot()
p_fil

# Changing from defaults to your own colors
my_cols <- c("red", "brown", "blue", "orange")
p_fil+scale_fill_manual(values=my_cols)

# Scatterplot with no color
p_col <- ggplot(d)+aes(x=displ,y=cty)
p_col + geom_point(size=3)

# Scatterplot with default ggplot colors
p_col <- ggplot(d, aes(x=displ,y=cty, col = as.factor(displ)))+geom_point(size=3)
p_col

# Using custom color requires "scale_color_manual"
p_col + scale_color_manual(values = my_cols)

# Continuous classification (gradient color scale)

p_grad <- ggplot(d)+aes(x=displ, y=cty, col=hwy)+geom_point(size=3)
p_grad

# Custom sequential gradient (2 colors)
p_grad+scale_color_gradient(low="green", high="red")

# Custom diverging gradient (3 colors)
mid <- median(d$cty)
p_grad+scale_color_gradient2(midpoint=mid,low="blue",mid="white",high="red")

# Custom diverging gradient (n colors)
p_grad+scale_color_gradientn(colors=c("blue", "green", "yellow", "purple", "orange"))

# Color palettes
library(wesanderson)
print(wes_palettes)

demoplot(wes_palettes$BottleRocket1, "pie")
demoplot(wes_palettes[[2]][1:3], "bar") # 2 brackets around 2 are to pull palette so these are first 3 from bottlerocket2

# Color brewer palettes
install.packages("RColorBrewer")
library(RColorBrewer)

display.brewer.all()
display.brewer.all(colorblindFriendly = TRUE)

demoplot(brewer.pal(4, "Accent"), "bar")
demoplot(brewer.pal(11, "Spectral"), "heatmap")

# Look at hex values for colors
library(scales)
my_cols <- c("grey75", brewer.pal(3,"Blues"))
show_col(my_cols)

xVar <- 1:30
yVar <- 1:5
myData <- expand.grid(xVar=xVar, yVar=yVar)
head(myData)
zVar <- myData$xVar + myData$yVar+ 2*rnorm(n=150)
myData <- cbind(myData,zVar)
head(myData)
# default gradient colors in ggplot
p4 <- ggplot(myData) +
      aes(x=xVar,y=yVar,fill=zVar) +
  geom_tile()
print(p4)
# user defined divergent palette
p4 + scale_fill_gradient2(midpoint=19,
                          low="brown",
                          mid=grey(0.8),
                          high="darkblue")
# Viridis
p4+scale_fill_viridis_c()
# Viridis has other themes that you can change with options (viridis, cividis, magma, inferno, plasma)
p4+scale_fill_viridis_c(option="plasma")
