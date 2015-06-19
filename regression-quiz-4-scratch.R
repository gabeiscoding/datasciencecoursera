library(MASS)
data(shuttle)
fit <- glm(I(use == "auto") ~ I(wind == 'head'), data=shuttle, family="binomial")
summary(fit)
exp(summary(fit)$coeff[2,1])


fit <- glm(I(use == "auto") ~ I(wind == 'head') + magn, data=shuttle, family="binomial")
summary(fit)
exp(summary(fit)$coeff[2,1])

fit <- glm(I(1 - (use == "auto")) ~ I(wind == 'head'), data=shuttle, family="binomial")
summary(fit)

data(InsectSprays)
fit <- glm(count ~ spray, data=InsectSprays,family="poisson")
1/exp(summary(fit)$coef[2,1])


fit <- glm(count ~ spray, data=InsectSprays,family="poisson")
summary(fit)

fit1 <- glm(count ~ spray, offset=log(rep(10, nrow(InsectSprays))), data=InsectSprays,family="poisson")
summary(fit1)

x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
plot(x, y)
knots = c(0)
splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot))
xMat <- cbind(1, x, splineTerms)
yhat <- predict(lm(y ~ xMat - 1))
plot(x, y, frame = FALSE, pch = 21, bg = "lightblue", cex = 2)
lines(x, yhat, col = "red", lwd = 2)
summary(lm(y ~ xMat - 1))
sum(summary(lm(y ~ xMat - 1))$coeff[2:3,1])

