# --------------------------------------------------#
# Scientific computing
# ICTP/Serrapilheira 2022
# Script to fit linear model in R
# First version 2022-07-18
# --------------------------------------------------#

# loading packages
library(ggplot2)

# reading data
cat <- read.csv("data/raw/crawley_regression.csv")

# Do leaf chemical compounds affect the growth of caterpillars? ----------------

# the response variable
boxplot(cat$growth, col = "darkgreen")

# the predictor variable
unique(cat$tannin)

# creating the lm
mod_cat <- lm(growth ~ tannin, data = cat)

summary(mod_cat)


## ----lm-plot------------------------------------------------------------------
plot(growth ~ tannin, data = cat, bty = 'l', pch = 19)

coef(mod_cat)
a <- coef(mod_cat)[1]
b <- coef(mod_cat)[2]

abline(mod_cat, col = "red", lwd = 2)


## ----lm-ggplot----------------------------------------------------------------
ggplot(data = cat, mapping = aes(x = tannin, y = growth)) +
  geom_point() +             #plot only points
  geom_smooth(method = lm) + #gray: confidence interval, method: linear or even formula
  theme_classic()


## AOV table
summary.aov(mod_cat)


## fitted values
predict(mod_cat)               #what would be the predicted value
cat$fitted <- predict(mod_cat) #creating a column
cat                            #cat now has a column

# Comparing fitted vs. observed values
ggplot(data = cat) +
  geom_point(aes(x = growth, y = fitted)) +
  geom_abline(aes(slope = 1,  intercept = 0)) +
  theme_classic() #checking if the model is really well fitted to the data


## Model diagnostics -----------------------------------------------------------
par(mfrow = c(2, 2))
plot(mod_cat)
par(mfrow = c(1, 1))

#4 plots: checking the assumptions of the linear model
#1 - residuals close to the fitted values >> horizontal line, any pattern is not desired: homogeneity distributed
#2 - normal Q-Q: check if it falls in a normal distribution >> expect all points to be in the line
#3 - scale-location: expect a horizontal line
#4 - residuals vs leverage: how big is the variance of the residuals (Cook's distance), all data within the interval [-2, 2]


# Comparing statistical distributions ------------------------------------------
library(fitdistrplus)

data("groundbeef")
?groundbeef
str(groundbeef)


hist(groundbeef$serving)

plotdist(groundbeef$serving, histo = TRUE, demp = TRUE) #cumulative distribution

descdist(groundbeef$serving, boot = 1000) #returns: skewness (asymmetry), kurtosis, etc.

#fit to weibull, gamma, and log-normal distributions
fw <- fitdist(groundbeef$serving, "weibull") #type of distribution: "weibull"
summary(fw)

fg <- fitdist(groundbeef$serving, "gamma")  #other option of skewness distribution
fln <- fitdist(groundbeef$serving, "lnorm") #other option of skewness distribution

par(mfrow = c(2, 2))
plot_legend <- c("Weibull", "lognormal", "gamma")
denscomp(list(fw, fln, fg), legendtext = plot_legend)
qqcomp(list(fw, fln, fg), legendtext = plot_legend)
cdfcomp(list(fw, fln, fg), legendtext = plot_legend)
ppcomp(list(fw, fln, fg), legendtext = plot_legend)


gofstat(list(fw, fln, fg)) #we can compare the different distributions: parametric tests
