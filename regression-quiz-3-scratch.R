data(mtcars)

df <- mtcars
df$cyl <- factor(df$cyl)

fit1 <- lm(mpg ~ cyl + wt, data=df)
fit2 <- update(fit1, lm(mpg ~ cyl * wt, data=df))

anova(fit1, fit2)

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
influence.measures(lm(y ~ x))

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
influence.measures(lm(y ~ x))

