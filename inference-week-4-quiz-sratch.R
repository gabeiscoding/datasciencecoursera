#q1 0.087
before <- c(140, 138, 150, 148, 135)
after <- c(132, 135, 151, 146, 130)
#Consider testing the hypothesis that there was a mean reduction in blood pressure? Give the P-value for the associated two sided T test.
t.test(before, after, paired=TRUE, alternative="two.sided")
# 
# Paired t-test
# 
# data:  before and after
# t = 2.2616, df = 4, p-value = 0.08652
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#     -0.7739122  7.5739122
# sample estimates:
#     mean of the differences 
# 3.4 

n <- 9
sd <- 30
mu_0 <- 1100
#What is the set of values that would fail two-sided t-test with alpha = 0.05
mu_0 + c(-1,1) * qt(0.975, df=n-1) * ( sd / sqrt(n) )
#1077 to 1123

pbinom(2, 4, prob = 0.5, lower.tail=FALSE)


bench_rate = 1/100
rate = 10/1787
lambda = ceiling(bench_rate * 1787)
1-ppois(10, lambda, lower.tail=FALSE)
#0.03

n <- 9 #9 in each group
diff_mu_treated <- -3
diff_mu_control <- 1
diff_sd_treated <- 1.5
diff_sd_control <- 1.8
# hypothesis of difference, common population variance
# p value for two-sided test

#T= (mX - m0) / (S/sqrt(n)) 
T <- diff_mu_treated - diff_mu_control / sqrt( diff_sd_treated^2 / n + diff_sd_control^2 / n )
pt(T, df=n-1, lower.tail=FALSE)
#less than 0.01

#q6, not reject

n <- 100
mu_diff <- 0.01 #mm^2 four year brain loss
sd <- 0.04 #sd of four year brain losss
alpha <- 0.05
#power for one-sided test versus null of no loss
power.t.test(n, delta=mu_diff, sd=sd, type="one.sample", alt = "one.sided")$power
#0.8

#same, but what is n if
power <- 0.90
power.t.test(power=0.9, delta=mu_diff, sd=sd, type="one.sample", alt = "one.sided")$n
#140




