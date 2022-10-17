install.packages("ISLR2")
library(ISLR2)

x <- seq (1, 10)
x <- seq (-pi, pi, length = 50)
y <- x
f <- outer (x, y, function (x, y) cos (y) / (1 + x^2))
contour (x, y, f)
contour (x, y, f, nlevels = 45, add = T)
fa <- (f - t(f)) / 2
contour (x, y, fa, nlevels = 15)
image (x, y, fa)
persp (x, y, fa)


data(Auto)

head(Auto)
attach(Auto)
plot (cylinders , mpg)
cylinders <- as.factor(cylinders)
plot (cylinders , mpg)
plot (cylinders , mpg , col = " red ")
plot (cylinders , mpg , col = " red ", varwidth = T)
plot (cylinders , mpg , col = " red ", varwidth = T,
      xlab = " cylinders ", ylab = " MPG ")
hist (mpg)
hist (mpg , col = 2, breaks = 15)
pairs (Auto)
pairs (
  ∼ mpg + displacement + horsepower + weight + acceleration ,
  data = Auto
)
plot (horsepower , mpg)
identify (horsepower , mpg , name)
summary(Auto)
q()
