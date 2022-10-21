library(ISLR2)

Advertising <- read.csv("C:/Users/SONICK/Desktop/Main/Data Science/Data/Advertising/Advertising.csv")

# View the dataset

View(Advertising)
head(Advertising)

# Since X is Serial number, removing this column

Advertising <- Advertising[,2:5]
