library(hexbin)
xy_data <- data.frame(
  X = c(1, 2, 3, 4, 5),
  Y = c(2, 3, 4, 5, 6)
)
ggplot(xy_data, aes(x = X, y = Y)) +
  geom_hex() +
  labs(title = "Hexbin Plot",
       x = "X",
       y = "Y") +
  theme_minimal()
