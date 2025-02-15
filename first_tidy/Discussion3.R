
city <- data.frame(
  porto = rnorm(100),
  aberdeen = rnorm(100),
  nairobi = c(rep(NA, 10), rnorm(90)),
  genoa = rnorm(100)
)

plot(city$porto, city$genoa)

hist(city$porto)


my_x <- 1:10
my_y <- seq(from = 1, to = 20, by = 2)
par(mfrow = c(2, 2))
plot(city$porto, city$genoa)
plot(city$nairobi, city$porto)
plot(city$aberdeen, city$nairobi)
plot(city$genoa, city$aberdeen)

dens <- density(city$porto)
hist(city$porto, freq = FALSE)
lines(x = dens,col = "red")

#put box plots in

#figure out how to save in a png
save.image(file ="pairs_graph")
pairs(city[, c("porto","aberdeen","nairobi","genoa")])

#Homework: put all of this on github
#boxplots and what i understand
#ggplot facets 
#legends





