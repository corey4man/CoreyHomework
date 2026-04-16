# Statistical Machine Learning

# For reproducible results
set.seed(1)

# Packages used today
library(ggplot2)
library(psych)        # Bartlett's test - used to determine when to stop choosing PCs
library(randomForest) # Random forest

# Data
data(iris)

iris_num <- iris[, 1:4]
iris_species <- iris$Species

round(cor(iris_num), 2)

# Bartlett's to see if PCA is even worth doing
bart <- cortest.bartlett(cor(iris_num), n = nrow(iris_num))
bart
# Very significant p-value so worth it

# fit the pcs model:
pca <- prcomp(iris_num, center = TRUE, scale. = TRUE)
summary(pca)
# Can't calculate more PCs than variables in dataset
# Gives proportion of how much variance is described by each PC

eig <- pca$sdev^2
pve <- eig / sum(eig)

pca_var_table <- data.frame(
  PC = paste0("PC", 1:length(eig)),
  Eigenvalue = round(eig, 3),
  PVE = round(pve, 3),
  CumPVE = round(cumsum(pve), 3)
)
pca_var_table

plot(eig, type = "b", pch = 19,
     xlab = "Principal component",
     ylab = "Eigenvalue",
     main = "Scree plot (iris PCA)")
# Based on graph might only take PC1 and 2 (above elbow)
# Can test which to use by using a broken stick test

# test
broken_stick <- function(p) sapply(1:p, function(k) sum(1/(k:p)) / p)
bs <- broken_stick(ncol(iris_num))

retain <- data.frame(
  PC = paste0("PC", 1:length(pve)),
  ObservedPVE = round(pve, 3),
  BrokenStick = round(bs, 3),
  Keep = pve > bs
)
retain
# Tells you to only take 1 but we're going to take 2 anyway

head(pca$x)

scores <- as.data.frame(pca$x)
scores$Species <- iris_species

plt <- ggplot(scores, aes(PC1, PC2, color = Species)) +
  geom_point(size = 2.6, alpha = 0.85) +
  theme_minimal() +
  labs(title = "PCA on iris", subtitle = "PCA is unsupervised; species used only for coloring")

plt + stat_ellipse() # 95% CI

# PCA itself is unsupervised. But after PCA, you can test whether known groups differ in the reduced space.
man <- manova(cbind(PC1, PC2) ~ Species, data = scores)
summary(man, test = "Pillai")

# random forest model
set.seed(42)
id_train <- sample(seq_len(nrow(iris)), size = 0.7 * nrow(iris))
train <- iris[id_train, ] # Training dataset for training the model
test  <- iris[-id_train, ] # Testing dataset - new data to model and it won't know group membership
# Traditionally 70% training and 30% testing
train
test

set.seed(123)
rf <- randomForest(
  Species ~ ., data = train, # Period means all other data
  ntree = 500, # Number of tress made based on hardness
  mtry = 2, # Number of features selected in our bootstrapping - rule of thumb is sqrt of # of features you have
  importance = TRUE
)
rf
# OOB is out of bag error
# Confusion matrix is whether algorithm got group classification correct, want to see all 0s with diagonal fully populated

# Knew group membership the whole time, now putting new data into same model
pred <- predict(rf, newdata = test)
conf <- table(Observed = test$Species, Predicted = pred)
conf

# Checking accuracy
acc <- mean(pred == test$Species)
acc

# oob plot
plot(rf, main = "Random forest OOB error vs number of trees")
# Becomes mostly horizontal very quickly, means we could've only done like 100 trees

# importance
importance(rf)
# Mean decrease accuracy is how well each variable contributed to prediction power
# Gini is how well it contributed to separation into each class
# This all tells you how much each variable matters

varImpPlot(rf)
