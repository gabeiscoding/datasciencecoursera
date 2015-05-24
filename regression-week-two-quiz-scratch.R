
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
n <- length(y)

beta1 <- cor(y, x) * sd(y) / sd(x)
beta0 <- mean(y) - beta1 * mean(x)
e <- y - beta0 - beta1 * x
sd(e)
sigma <- sqrt(sum(e^2) / (n-2)) 
ssx <- sum((x - mean(x))^2)
seBeta0 <- (1 / n + mean(x) ^ 2 / ssx) ^ .5 * sigma 
seBeta1 <- sigma / sqrt(ssx)
tBeta0 <- beta0 / seBeta0; tBeta1 <- beta1 / seBeta1
pBeta0 <- 2 * pt(abs(tBeta0), df = n - 2, lower.tail = FALSE)
pBeta1 <- 2 * pt(abs(tBeta1), df = n - 2, lower.tail = FALSE)

fit <- lm(y ~ x); 
summary(fit)$sigma #std error of residuals

#two sided test of whether B1 is == 0

pBeta1 <- 2 * pt(abs(tBeta1), df = n - 2, lower.tail = FALSE)

library(UsingR)
data("mtcars")
fit <- lm(mpg ~ wt, data=mtcars)
summary(fit)
mu = mean(mtcars$wt)
predict(fit, newdata=data.frame(wt=mu), interval="confidence")

predict(fit, newdata=data.frame(wt=c(3.0)), interval="prediction")


sumCoef <- summary(fit)$coefficients
2 * (sumCoef[2,1] + c(-1, 1) * qt(.975, df = fit$df) * sumCoef[2, 2])

sum((predict(fit) - mtcars$mpg)^2) / sum((mean(mtcars$mpg) - mtcars$mpg)^2)
