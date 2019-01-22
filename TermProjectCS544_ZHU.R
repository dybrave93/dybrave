# Termproject_Dongyu Zhu
# Preparing and preprocessing data
# Read the Boda Borg data that contains visitng history of November 2017 and keep the propoer formats
data <- read.csv('C:/Users/Dongyu Zhu/Desktop/BodaBorg_FP.csv', header = TRUE, stringsAsFactors = FALSE, colClasses = c('Zip.Code' = 'character'))

# Remove meaningless rows and useleless columns
data <- data[which(data$Age > 10 & data$Age < 70 & data$Distance > 0), c('Age', 'Day', 'Distance')]

# Round the Age variable and categorize the Day variable with ordinal levels
data$Age <- round(data$Age)
data$Day <- factor(data$Day, levels = c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'))

# Analyzing the data
# 1
# Plots of categorical variable: Day
catg <- data$Day
pie(table(catg), col = rainbow(7), main = 'Pie Chart of Monthly Visits by Day')
barplot(table(catg), col = 'cyan', main = 'Barplot of Monthly Visits by Day', xlab = 'Day of the Week', ylab = 'Frequency')

# Plot of numerical variable: Age
bodanum <- data$Age
boxplot(bodanum, col = hcl(0), xaxt = "n", xlab = "Age", horizontal = TRUE)
axis(side = 1, at = fivenum(bodanum), labels = TRUE, las = 2)
text(fivenum(bodanum), rep(1.2, 5), srt = 90 , adj = 0, labels = c("Min", "Lower Hinge", "Median", "Upper Hinge", "Max"))

# 2
# Plot of a set of two numerical variables: Age & Distance
plot(data$Age, data$Distance, xlab = 'Age', ylab = 'Distance')

# 3
# Fit the distribution of data using expotential distribution with proper parameters
hist(data$Age, probability = TRUE, breaks = 5, main = 'Distribution of Age', xlab = 'Age', ylim = c(0, 0.06))
curve(dexp(x - 10, rate = 0.06, log = FALSE), add = TRUE, col = 'red', ylim = c(0, 0.06))

# 4 5
# Applicability of Central Limit Theorem for Age variable under different sampling methods
library(sampling)
mean(data$Age)
sd(data$Age)

# Simple Random Sampling with replacement
population <- nrow(data)
par(mfrow = c(2, 2))
for (i1 in 1:4) {
  size1 <- 25 * i1
  mean1 <- numeric()
  for (j1 in 1:population) {
    s1 <- srswr(size1, population)
    rows1 <- (1:nrow(data))[s1 != 0]
    data1 <- data[rows1, ]
    mean1[j1] <- mean(data1$Age, na.rm = TRUE)
  }
  title1 <- paste('Sample Size = ', as.character(size1), sep = '')
  hist(mean1, probability = TRUE, xlim = c(15, 35), xlab = 'Sample Mean', main = title1)
}

# Simple Random Sampling without replacement
population <- nrow(data)
par(mfrow = c(2, 2))
for (i2 in 1:4) {
  size2 <- 25 * i2
  mean2 <- numeric()
  for (j2 in 1:population) {
    s2 <- srswr(size2, population)
    rows2 <- (1:nrow(data))[s2 != 0]
    data2 <- data[rows2, ]
    mean2[j2] <- mean(data2$Age, na.rm = TRUE)
  }
  title2 <- paste('Sample Size = ', as.character(size2), sep = '')
  hist(mean2, probability = TRUE, xlim = c(15, 35), xlab = 'Sample Mean', main = title2)
}

# Systematic Sampling
population <- nrow(data)
par(mfrow = c(2, 2))
for (i3 in 1:4) {
  size3 <- 25 * i3
  k <- ceiling(population / size3)
  mean3 <- numeric()
  for (j3 in 1:population) {
    rows3 <- seq(sample(k, 1), by = k, length = size3)
    data3 <- data[rows3, ]
    mean3[j3] <- mean(data3$Age, na.rm = TRUE)
  }
  title3 <- paste('Sample Size = ', as.character(size3), sep = '')
  hist(mean3, probability = TRUE, xlim = c(15, 35), xlab = 'Sample Mean', main = title3)
}
