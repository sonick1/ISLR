library(MASS)
library(ISLR2)

# Show dataset
head(Boston)

# We want to predict medv using all predictors
?Boston

lm.fit <- lm(medv ~ lstat , data = Boston)
summary(lm.fit)
names(lm.fit)

# Coefficient
coef(lm.fit)


# Confidence Interval
confint(lm.fit)

# make prediction for given value of lstat
predict(lm.fit , data.frame(lstat = (c(5, 10, 15))),
        interval = "confidence")
predict(lm.fit , data.frame(lstat = (c(5, 10, 15))),
         interval = "prediction")

# Plot medv and lstat
attach(Boston)
plot(lstat , medv)
abline(lm.fit,lwd = 3,col = "red")

# Plotting Diagnostic Plots
par(mfrow = c(2,2))
plot(lm.fit)
# Alternatively,
plot(predict (lm.fit), residuals (lm.fit))

# Getting Leverage Statistics
plot(hatvalues (lm.fit))
which.max (hatvalues (lm.fit))


# ----------------------------------------------------
# Multiple Linear Regression

lm.fit <- lm(medv ~ lstat + age , data = Boston)
summary(lm.fit)

lm.fit <- lm(medv ~ ., data = Boston)
summary (lm.fit)

# Lets check VIF Values to see if there is any multicollinearity
library(car)
vif(lm.fit)


# Removing Age variable since it has high p value
lm.fit <- lm(medv ~ . - age - indus, data = Boston)
summary(lm.fit)

# Include Interaction term along with main components
summary(lm(medv ~ lstat * age , data = Boston))


#Non Linear Transformation of Predictors
lm.fit2 <- lm(medv ~ lstat + I(lstat^2))
summary(lm.fit2)
lm.fit <- lm(medv ~ lstat)
anova (lm.fit , lm.fit2)
# Anova Indicates that new model fits the data significantly different than previous model


par (mfrow = c(2, 2))
plot (lm.fit2)

# Create higher order polynomials
lm.fit5 <- lm(medv ~ poly (lstat , 5))
summary(lm.fit5)


# Qualitative Predictors
library(ISLR2)
head(Carseats)
lm.fit <- lm(Sales ~ . + Income:Advertising + Price:Age ,
             data = Carseats)
summary(lm.fit)


# R coding for dummy variable
attach(Carseats)
contrasts(ShelveLoc)
# Relative to bad both good and medium have higher coefficients


# Exercises -------------------------------
# Applied
head(Auto)

lm.fit <- lm(mpg ~ horsepower, data = Auto)
summary(lm.fit)

# Predict mpg at horsepower 98
predict(lm.fit,data.frame(horsepower = 98),interval = "confidence")
predict(lm.fit,data.frame(horsepower = 98),interval = "prediction")

# Plot response and Predictor
attach(Auto)
plot(mpg,horsepower)
abline(lm.fit)
par(mfrow=c(2,2))
plot(lm.fit)

# Scatterplot matrix for Auto data
plot(Auto)

head(Auto)

Auto_num <- Auto[,-which(colnames(Auto) %in% c('name'))]
cor(Auto_num)

# Predict mpg with all predictors except name
lm.fit <- lm(data = Auto_num, formula = mpg ~ .)
summary(lm.fit)
coef(lm.fit)

# Diagnostic plot
par(mfrow = c(2,2))
plot(lm.fit)

# We see some non- linearity in residual plots and some non leverage points also 
# Fit plot with interaction terms 
lm.fit <- lm(data = Auto_num, formula = mpg ~ . * .)
summary(lm.fit)

# Try log and sqrt transformations as well
lm.fit <- lm(data = Auto_num, formula = mpg ~ log(.) * .)
summary(lm.fit)
Auto_log <- lapply(Auto_num,log)
head(Auto_log)

lm.fit <- lm(data = Auto_log, formula = mpg ~ . * .)
summary(lm.fit)
plot(lm.fit)

Auto_sqrt <- lapply(Auto_num,sqrt)
lm.fit <- lm(data = Auto_sqrt, formula = mpg ~ . * .)
summary(lm.fit)
plot(lm.fit)


# Carsets data
library(ISLR2)
head(Carseats)
attach(Carseats)
lm.fit <- lm(Sales ~ Price + Urban + US)
summary(lm.fit)
lm.fit <- lm(Sales ~ Price + US)
summary(lm.fit)
confint(lm.fit,level = 0.95)
par(mfrow = c(2,2))
plot(lm.fit)

# Since Interpretation using graph can be difficult, using cooks distance
library(dplyr)
library(broom)
library(rownames_to_column)
broom::augment(lm.fit) %>%
  tibble::rownames_to_column("rowid") %>%
  arrange(desc(.cooksd)) %>% 
  select(Sales, Price, US, .std.resid, .hat, .cooksd)


# Testing Null hypothesis with Zero intercept
set.seed(1)
x <- rnorm(100)
y <- 2 * x + rnorm(100)

lm.fit <- lm(y ~ x + 0)
summary(lm.fit)
lm.fit <- lm(x ~ y + 0)
summary(lm.fit)


# Create Simulated data
x <- rnorm(100,mean = 0, sd = 1)
eps <- rnorm(100,mean = 0, sd = 0.5) 
y <- -1 + 0.5*x + eps
lm.fit <- lm(y ~ x)
summary(lm.fit)


library(ggplot2)
p1 <- ggplot(data = NULL, aes(x,y)) + geom_point()
p1

p1 +  geom_abline(aes(intercept = -1, slope = 0.5,col = "Population")) + 
  geom_abline(aes(intercept = lm.fit$coefficients[1], 
                  slope = lm.fit$coefficients[2],col = "Modelled"))

lm.fit <- lm(y ~ x + I(x^2))
summary(lm.fit)



# Collinearity Problem
x1 <- runif (100)
x2 <- 0.5 * x1 + rnorm (100) / 10
y <- 2 + 2 * x1 + 0.3 * x2 + rnorm (100)
lm.fit <- lm(y ~ x1 + x2)
summary(lm.fit)

cor(x1,x2)
par(mfrow = c(1,1))
plot(x1,x2)
lm.fit <- lm(y ~ x1)
summary(lm.fit)
lm.fit <- lm(y ~ x2)
summary(lm.fit)


# mismeasured observation
x1 <- c(x1 , 0.1)
x2 <- c(x2 , 0.8)
y <- c(y, 6)
lm.fit <- lm(y ~ x1)
summary(lm.fit)
lm.fit <- lm(y ~ x2)
summary(lm.fit)
lm.fit <- lm(y ~ x1)
summary(lm.fit)
lm.fit <- lm(y ~ x1 + x2)
summary(lm.fit)
par(mfrow = c(2,2))
plot(lm.fit)


#Boston Dataset
head(Boston)

# Run Model for all variables in boston 
R2 <- c()
P_value <- c()
Slope <- c()       
y <- Boston$crim
for(i in 1:ncol(Boston)){
  x <- Boston[,i]
  if(!identical(x,y)){
    R2[i] <- summary(lm(y~x))$r.squared
    P_value[i] <- summary(lm(y ~ x))$coefficients[2, 4]
    Slope[i] <- summary(lm(y ~ x))$coefficients[2, 1]
  } else {
    R2[i] <- NA
    P_value[i] <- NA
    Slope[i] <- NA
  }
}                      
    

crime_preds <- data.frame(varname = names(Boston), 
                          R2 = round(R2,2),
                          P_Value = round(P_value,2),
                          Slope = round(Slope,2)) %>% arrange(desc(R2))                 
crime_preds

lm.fit <- lm(data = Boston,formula = crim ~ .)
summary(lm.fit)

model_coef <- data.frame(lm.fit$coefficients) 
model_coef$varname   <- row.names(model_coef)
model_coef <- model_coef[-1,]

joined_df <- merge(crime_preds,model_coef,by ="varname")                                                    
joined_df


ggplot(joined_df, aes(x = Slope ,y = lm.fit.coefficients,col = factor(varname))) + geom_point()

# Run Model with Cubic term to check for non linearity
R2 <- c()
P_value_x <- c()
P_value_x2 <- c()
P_value_x3 <- c()
Slope <- c()       
y <- Boston$crim
for (i in 1:ncol(Boston)) {
  x <- Boston[ ,i]
  if (is.numeric(x)) { 
    model <- lm(y ~ x + I(x^2) + I(x^3))
    if (!identical(y, x)) {
      P_value_x[i] <- summary(model)$coefficients[2, 4]
      P_value_x2[i] <- summary(model)$coefficients[3, 4]
      P_value_x3[i] <- summary(model)$coefficients[4, 4]
      R2[i] <- summary(model)$r.squared 
    }
  } else {
    P_value_x[i] <- NA
    P_value_x2[i] <- NA
    P_value_x3[i] <- NA
    R2[i] <- NA
  }
}
head(Boston)
x <- Boston[ ,'chas']
model <- lm(y ~ x + I(x^2) + I(x^3))
P_value_x[i] <- summary(model)$coefficients
summary(model)


data.frame(varname = names(Boston),
           R2 = round(R2, 5),
           P_value_x = round(P_value_x, 10),
           P_value_x2 = round(P_value_x2, 10), 
           P_value_x3 = round(P_value_x3, 10))%>%
  arrange(desc(R2)) %>%
  mutate(relationship = case_when(P_value_x3 < 0.05 ~ "Cubic", 
                                  P_value_x2 < 0.05 ~ "Quadratic", 
                                  P_value_x < 0.05 ~ "Linear", 
                                  TRUE ~ "No Relationship"))
