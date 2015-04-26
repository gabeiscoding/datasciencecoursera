#q1
n<-9
mu<-1100
s<-30
#95% student T confidence interval for this pop
mu + c(-1,1)*qt(0.975,df=n-1)*(s/sqrt(n))

#q2
#A diet pill is given to 9 subjects over six weeks.
#The average difference in weight (follow up - baseline) is -2 pounds.
#What would the standard deviation of the difference in weight have to be for the upper endpoint of the 95% T confidence interval to touch 0?
n <- 9
mn <- -2
(-mn * sqrt(n)) / qt(0.975, n-1)

#q4
#New System - Old System
#10 ovservations in each
#new system: mu = 3, var=0.6
#old system: mu = 5, var=0.68
#95% CI diff of mean, assume constant variance
s <- sqrt( (0.6 + 0.68)/2 )
(3-5) + c(-1,1) * qt(0.975,df=10+10-2) * s * (1/10 + 1/10)^0.5

#q6 - oingoing from q4
#100 observations in each system
#new system: mu = 4, sd = 0.5
#old system: mu = 6, sd = 2
#Ha = decase with new system (i.e. one sided, less than)
# 95% independent group CI, unequal variances suggest vis a vis this hypothesis
# Use Z instead of T quantile
(6-4) + c(-1,1) * qnorm(0.975) * (0.5^2/100 + 2^2/100)^0.5
#[1] 1.595943 2.404057 does not contain 0, new system effective


#q7
#18 samples, 2 groups
#each sample has before/after measurements
#mean difference was -3 for treatment, 1 for placebo
#sd was 1.5 for treatment, 1.8 for placebo
#assume normality of data, common variance between groups, 
# 90% t confidence interval
# Treated - Placebo (smalles number first)
n <- 9
s <- sqrt( (1.5^2 + 1.8^2)/2 )
(-3-1) + c(-1,1) * qt(0.95,df=n+n-2) * s * (1/n + 1/n)^0.5