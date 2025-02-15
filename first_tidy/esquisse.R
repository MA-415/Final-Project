

airtemp <- readRDS("airtemp.rdata")

aa <- which(airtemp == 999)

airtemp <- airtemp[-aa]

plot(airtemp, type="l")

install.packages("esquisse")
library(esquisse)

esquisser(airtemp)

airtemp <- as.data.frame(airtemp)

at <- cbind(1:3459, airtemp)

colnames(at) <- c("index", "temp")

esquisser(at)

library(ggplot2)

ggplot(at) +
  aes(x = index, y = temp) +
  geom_point(colour = "#112446") +
  theme_minimal()







