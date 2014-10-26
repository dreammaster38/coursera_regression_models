library(car)
library(leaps)
library(MASS)

data(mtcars)

full.lm <- lm(mpg ~ am + cyl + disp + hp + drat + wt + qsec + vs + gear + carb, mtcars)

#leaps <- regsubsets(mpg ~ am + cyl + disp + hp + drat + wt + qsec + vs + gear + carb, data=mtcars, nbest=1)
#leaps <- regsubsets(mpg ~ ., data=mtcars, nbest=2, force.in = "am", force.out = "disp")

leaps <- regsubsets(mpg ~ ., data=mtcars, nbest=4, force.in = "am", nvmax = NULL)
#plot(leaps, scale="adjr2")
plot(leaps, scale="Cp")

subsets(leaps, statistic="cp", legend = FALSE, main="Cp plot for all subsets regression")
abline(a = 1, b = 1,lty=2,col="red")

subsets(leaps, statistic="adjr2", legend = FALSE, main = "Adjusted R^2")


final <- lm(mpg ~ am + disp + hp + wt + qsec, mtcars)
# cp stat
final2 <- lm(mpg ~ am + wt + qsec, mtcars)

summary.out <- summary(leaps)
max.adjr2 <- which.max(summary.out$adjr2)
max.adjr2
summary.out$which[max.adjr2,]
which(summary.out$which[max.adjr2,] == TRUE)

#AIC(final, removed_hp, removed_wt, removed_cyl, removed_disp, full.lm)

print(AIC(final,final2))

par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
plot(final)
par(mfrow=c(1,1))

#qqPlot(final, labels=row.names(mtcars), id.method="identify", simulate=TRUE, main="Q-Q Plot")
#qqPlot(final, labels=row.names(mtcars), simulate=FALSE, main="Q-Q Plot")
#crPlots(final)

qqPlot(final2, labels=row.names(mtcars), simulate=FALSE, main="Q-Q Plot")
#crPlots(final2)


