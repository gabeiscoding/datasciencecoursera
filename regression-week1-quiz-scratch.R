# Regression quiz 1
x <- c(0.18, -1.54, 0.42, 0.95)
w <- c(2, 1, 3, 1)
mean(x) 
form <- function(u) { sum( w * (x - u)^2 ) }
form(0.14)


sumsqr <- function(x, y, b, b0=0){
    sum( (y-(b0 + b*x))^2 )
}
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
#slope minimize least squares with intercept of origin
b <- lm(I(y)~ I(x) - 1)$coefficients
plot(y ~ x)
#b = cor(y,x) * sd(y)/sd(x)
#b0 = mean(y) - b*mean(x)
sumsqr(x, y, b)
abline(0, b=b)


data(mtcars) 
lm(mpg ~ wt, data=mtcars)
#See
plot(mpg ~ wt, data=mtcars)
abline(a=lm(mpg~wt, data=mtcars))

sd_x = 0.5
sd_y = 1
cor_y_x = 0.5
b1 = cor_y_x * (sd_y / sd_x)

0.4 * 1.5


x <- c(8.58, 10.46, 9.01, 9.64, 8.86)
x_n <- (x - mean(x))/sd(x)
mean(x_n)
sd(x_n)
x_n[1]

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
lm(y ~ x)


x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
b <- mean(x)
sumsqr(x, x, 1.1)

