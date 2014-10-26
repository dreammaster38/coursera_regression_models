# Planung:
# ========
# 
# Part 1: Executive summary
# -------------------------
#   * eine Einführung (erledigt)
# 
# Part 2: Explorative checks
# --------------------------
#   * Boxplot mit Erklärung (erledigt)
# * scatterplot?
# * pair plot?
 #
# Part 3: Inference
# -----------------
# * t-Test mit Erklärung
# * Shapiro-Wilkons-Test mit Erklärung
# * (multi)colinearity checken
# 
# Part 4: Quantification:
# -----------------------
# * simple linear regression mit Erklärung
# * multivariate linear regression (stepAIC)
# * glm????????
# * Modelle vergleichen
# 
# Part 4a: Diagnostics
# --------
# * linear model diagnostics plot mit Interpretation
# 
# Part 5: Conclusion and assumptions
# ----------------------------------
# * Schlussfolgerungen und Annahmen
# 
# Part 6: Appendix
# ----------------
# * Bilder und R output



# A data frame with 32 observations on 11 variables.
# 
# [, 1]  mpg	 Miles/(US) gallon
# [, 2]	 cyl	 Number of cylinders
# [, 3]	 disp	 Displacement (cu.in.)
# [, 4]	 hp	 Gross horsepower
# [, 5]	 drat	 Rear axle ratio
# [, 6]	 wt	 Weight (lb/1000)
# [, 7]	 qsec	 1/4 mile time
# [, 8]	 vs	 V/S
# [, 9]	 am	 Transmission (0 = automatic, 1 = manual)
# [,10]	 gear	 Number of forward gears
# [,11]	 carb	 Number of carburetors


library(ggplot2)
library(dplyr)
library(e1071)
library(corrplot)
library(car)

data(mtcars)

#ggplot(tx,aes(x=miles,y=price)) + geom_point() + 
#  stat_smooth(method=lm,se=F)


mtcars.lm <- lm(mpg ~ ., data = mtcars)
best.fit <- step(mtcars.lm, direction="backward", k=2)
print(summary(best.fit))

par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
plot(best.fit)
par(mfrow=c(1,1))

correlationMatrix <- cor(mtcars)
corrplot(correlationMatrix, method = "pie", order = "FPC")

#mtcars <- mutate(mtcars, transmission = am)
#mtcars$transmission[which(mtcars$am == 0)] <- "Automatic"
#mtcars$transmission[which(mtcars$am == 1)] <- "Manual"
#mtcars$transmission <- as.factor(mtcars$transmission)
#mtcars$am <- as.factor(mtcars$am, levels = c("Automatic", "Manual"))

# reshape mtcars$am as factor with a better transmission explanation
mtcars$am <- factor(mtcars$am, levels = c(0, 1), labels = c("Automatic", "Manual"))


# data for manual tranmission is right skewed, that means the miles per gallon for lower consumption are closer together
p <- ggplot(mtcars, aes(am, mpg, fill=am)) +
  geom_boxplot() +
  coord_cartesian(ylim=c(10,34)) +
  xlab("Type of transmission") +
  ylab("Miles per gallon") +
  ggtitle("Miles per gallon by type of transmission") +
  theme(plot.title = element_text(color="blue", size=12, vjust=1.0))
print(p)


#qqp(colMeans(sapply(rep(10,100),rchisq,df=1)),xlab='Sample mean',main='')


skew <- skewness(mtcars$mpg)
# skew is approx. 0.6404399. Because 0.64 > 0.005 we have to reject hyposthesis that this samples are
# normal distributed, but we cannot make any assumption on the population mean.
kurt <- kurtosis(mtcars$mpg)


slr <- lm(mpg ~ am, data=mtcars)










# # Basic linear model with one main effect, vehicle weight (wt)
# fit <- lm(mpg~wt , data=mtcars)
# confint(fit) # Confidence intervals of parameters
# 
# # Plot data with fitted line as well as confidence bands
# # using formula interface
# plot(mpg~wt, data=mtcars, xlab="Weight (lb/1000)", ylab="MPG")
# abline(fit, lwd=2) # Add fitted line
# 
# # Use predict() to evaluate the model at each value of new,
# # this way we get a smooth line across the graph
# new <- data.frame(wt=seq(0, 6, len=20))
# conf.band <- predict(fit, new, interval="confidence")
# lines(new$wt, conf.band[,2], col="blue", lwd=2) # Add lower CI band
# lines(new$wt, conf.band[,3], col="blue", lwd=2) # Add upper CI band