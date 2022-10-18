library(ISLR2)
library(ggplot2)
data(College)


# Confirming number of rows and column from Exercise
dim(College)

# View the data
View(College)

# Summary of the data
summary(College)


# Scater plots of the variables
pairs(College[,1:10])


#Boxplot for outstate vs Private
plot(College$Private,College$Outstate)

# Divide universities interms of students 
Elite <- rep("No",nrow(College))
Elite[College$Top10perc > 50] <- "Yes"
Elite <- as.factor(Elite)
college <- data.frame(College,Elite)
View(college)

summary(college$Elite)
plot(college$Elite,college$Outstate)

# Produce histogrames with various binning
par(mfrow = c(2, 3))
hist(college$Accept)
hist(college$Outstate)
hist(college$Enroll)
hist(college$Apps)
hist(college$Top10perc)
hist(college$Top25perc)

# Continue Exploration

# Check correlation
library(ggcorrplot)

ggcorrplot(cor(college[,names(college)[sapply(college, is.numeric)]]))

# Plot bar plot for categorical variables
par(mfrow = c(1, 2))

plot(college$Elite) # Data looks unbalanced if we use elite as a y
plot(college$Private)


# Auto Data Exploration 

# Range of each Quantitive variable
Auto_numeric <- Auto[,names(Auto)[sapply(Auto, is.numeric)]]
dim(Auto_numeric)
# Apply Range on all coluumns
lapply(Auto_numeric,range,2)
lapply(Auto_numeric,mean,2)
lapply(Auto_numeric,sd,2)

# Remove 10th to 85 observation
lapply(Auto_numeric[c(1:10,11:392),],range,2)
lapply(Auto_numeric[c(1:10,11:392),],mean,2)
lapply(Auto_numeric[c(1:10,11:392),],sd,2)

# Plot variables
pairs(Auto)

ggcorrplot(cor(Auto[,names(Auto)[sapply(Auto, is.numeric)]])) 
# We observe strong correlation among lot of variables

par(mfrow = c(2, 3))
hist(Auto$mpg)
hist(Auto$cylinders)
hist(Auto$displacement)
hist(Auto$horsepower)
hist(Auto$weight)
hist(Auto$acceleration)

par(mfrow = c(1,1))
plot(as.factor(Auto$cylinders),Auto$mpg) # Clear difference among classes
# Using matrix
ggcorrplot(cor(Auto[,names(Auto)[sapply(Auto, is.numeric)]]))  # We can use variables highly correlated with MPG
# Cylinder, displacement, horsepower,weight
# Since weight horse poew displacement and cylinder are also highly correlated, we may choose only 1


# Boston Dataset
data(Boston)

# Number of rows and columns
dim(Boston)
View(Boston)

# To check variable association, creating correlation matrix
ggcorrplot(cor(Boston[,names(Boston)[sapply(Boston, is.numeric)]])) 

