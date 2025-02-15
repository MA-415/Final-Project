library(tidyverse)
library(palmerpenguins)
library(ggthemes)

ggplot(data=penguins)

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
       geom_point(mapping = aes(color = species, shape = island),
                  size = 2) +
         geom_smooth(method = "lm") +
         scale_color_colorblind() + 
         theme_economist()

ggplot(penguins, aes(x=species)) + geom_bar(mapping = color = species) #this dont work
  

max(penguins$body_mass_g, na.rm=TRUE)
min(penguins$body_mass_g, na.rm=TRUE)

max(penguins$flipper_length_mm, na.rm=TRUE)
min(penguins$flipper_length_mm, na.rm=TRUE)


