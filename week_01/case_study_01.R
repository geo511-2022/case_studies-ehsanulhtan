#load the iris data set
data("iris")

#Calculate mean of the Petal.length field 
petal_lenth_mean <- mean(iris$Petal.Length)

#Plot the distribution of the Petal.length
hist(iris$Petal.Length,col = "red", main = "Histogram of Petal Length", xlab = "Petal Length" , ylab = "Frequency" , xlim = c(1,7), ylim = c(0,50))

