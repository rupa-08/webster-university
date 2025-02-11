library(palmerpenguins)
library(ggthemes)
ggplot( data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g) ) + geom_point()
ggplot( data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species) ) + geom_point()
ggplot( data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species) ) + geom_point() +
  geom_smooth(method = "lm")
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth(method = "lm")

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm")

ggplot( data = penguins,
        mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(   title = "Body mass and flipper length",
          subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
          x = "Flipper length (mm)", y = "Body mass (g)",
          color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()

ggplot(penguins, aes(x = species)) +
  geom_bar()

ggplot(penguins, aes(x = fct_infreq(species))) +
  geom_bar()

ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)

ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density(linewidth = 0.75)

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)


ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + geom_point() 
ggsave(filename = "penguin-plot.png")







