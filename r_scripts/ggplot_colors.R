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
