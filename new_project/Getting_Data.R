
data("mtcars") #Lazy loading
dim(mtcars)

write.csv(x= mtcars, file = "mtc.csv")

#after making csv file, I erased everything

mt_cars <- read.csv("mtc.csv") #data frame woooooooooooow
View(mt_cars)
head(mt_cars)


mt_cars$drat #use $ to get into data frames
mt_cars[,6]
mt_cars[,"drat"]
mt_cars[3, "drat"]

summary.data.frame(mt_cars)
mt_cars$cyl <- factor(mt_cars$cyl) #just made strings that map to integers
str(mt_cars$cyl)


plot(x = mt_cars$disp, y= mt_cars$mpg) #plotting time
text(150,15,"Bad milage =>")

hist(mt_cars$mpg)

#Simulations
#I need a cdf and a uniform random number generator

rand_un <- runif(10)
# runif, dunif, punif, quinf (random, density, probability, quantile)





