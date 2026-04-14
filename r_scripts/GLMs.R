# GLMs
# For lm, you need continuous y variable
# For glm, you can use categorical variables as your y variable
# glmms are mixed models and give random effects

# Looking at GLMs with a bee dataset
# C Forman
# 14 April 2026

library(tidyverse)
library(lubridate)
library(lme4)
library(car)

bee_dat <- read_csv("data/Burnham_field_data_pathogens_wide.csv")

bee_dat <- bee_dat %>%
  mutate(
    sampling_date = mdy(sampling_date),
    site_code = factor(site_code),
    field_id = factor(field_id),
    bee_caste = factor(bee_caste),
    bombus_spp = factor(bombus_spp),
    host_plant = factor(host_plant),
    sampling_event = factor(sampling_event),
    sampling_event_num = as.numeric(as.character(sampling_event)),
    log10_BQCV_load = log10(BQCV_pathogen_load + 1),
    log10_DWV_load = log10(DWV_pathogen_load + 1),
    log10_Nosema_load = log10(Nosema_pathogen_load + 1)
  )

glimpse(bee_dat)

# filter for only pos:
df_filtered <- bee_dat[bee_dat$log10_DWV_load > 0 & bee_dat$log10_BQCV_load > 0, ]

hist(df_filtered$log10_DWV_load)

# continuous y, cont. x - use scatterplot, traditional gaussian lm
m_cont_cont <- lm(data = df_filtered, log10_DWV_load~log10_BQCV_load) # y~x
summary(m_cont_cont)

qplot(
  x = log10_BQCV_load,
  y = log10_DWV_load,
  data = df_filtered) +
geom_smooth(method = "lm", se = TRUE)

# cont y, cat x - use boxplot, anova lm

m_cont_cat <- lm(data = df_filtered, log10_BQCV_load~bombus_spp)
summary(m_cont_cat)

# categorical y, cont x - use logistic curve, glm
m_cat_cont <- glm(data = bee_dat, DWV_pathogen_binary~log10_BQCV_load,
family = binomial(link="logit"))
summary(m_cat_cont)

# cat y, cat x - use grouped proportions, glm
m_cat_cat <- glm(data = bee_dat, DWV_pathogen_binary~bee_caste,
family = binomial(link="logit"))
summary(m_cat_cat)

# testing for significance

# build some models
bin_mod <- glm(data = bee_dat, DWV_pathogen_binary~bombus_spp * sampling_event + host_plant, 
family = binomial(link = "logit"))

gaus_mod <- lm(data = bee_dat, log10_Nosema_load~sampling_event * host_plant) # lm assumes gaussian
summary(bin_mod)
summary(gaus_mod)

# using the car package for sig
Anova(bin_mod)
Anova(gaus_mod)

# likelihood ratio test
m_dwv_null <- lm(data = df_filtered, log10_DWV_load ~ 1) # null model because x is just 1
m_dwv_full <- lm(data = df_filtered, log10_DWV_load ~ sampling_event + host_plant)
# This asks whether the predictors improve fit compared with a model containing only an intercept.

anova(m_dwv_null, m_dwv_full, test = "LRT")

# reduced model
m_dwv_reduced <- lm(data = df_filtered, log10_DWV_load ~ sampling_event) # removed host plant
# comparing full model to reduced model to see how important host plant is
anova(m_dwv_reduced, m_dwv_full, test = "LRT")

# random effects
# GLMMs extend GLMs by adding random effects, which account for grouped or non-independent observations.

g_bqcv_site <- lmer(
  log10_BQCV_load ~ bombus_spp + sampling_event + (1 | site_code),
  data = df_filtered)

Anova(g_bqcv_site)

g_bqcv_site <- lmer(
  log10_BQCV_load ~ bombus_spp + sampling_event + (1 | site_code) + (1 | day),
  data = df_filtered)

# gamma distributions
# continuous and positive, generally right-skewed

# make pos only nosema
nosPos <- bee_dat[bee_dat$Nosema_pathogen_load > 0,]

# gamma
nos_gamma <- lmer(
  log10_Nosema_load ~  bombus_spp * sampling_event + (1 | site_code),
  data = nosPos)
Anova(nos_gamma)
