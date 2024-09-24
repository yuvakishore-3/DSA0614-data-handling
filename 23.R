library(ggplot2)
library(plotly)
library(dplyr)
library(reshape2)
survey_data <- data.frame(
  Product = c("A", "B", "C", "D", "E"),
  Price = c(50, 70, 60, 45, 55),
  Rating = c(4.2, 3.8, 4.0, 4.5, 3.9),
  AgeGroup = factor(c("25-35", "35-45", "18-25", "45-55", "25-35"), 
                    levels = c("18-25", "25-35", "35-45", "45-55"))
)
summary(survey_data)
cor(survey_data$Price, survey_data$Rating)
plot_ly(data = survey_data, x = ~Price, y = ~Rating, z = ~AgeGroup, 
        type = "scatter3d", mode = "markers", 
        marker = list(size = 5)) %>%
  layout(title = "3D Scatter Plot of Product Ratings",
         scene = list(xaxis = list(title = 'Price ($)'),
                      yaxis = list(title = 'Rating (out of 5)'),
                      zaxis = list(title = 'Age Group')))
price_seq <- seq(min(survey_data$Price), max(survey_data$Price), length.out = 50)
age_seq <- levels(survey_data$AgeGroup)
grid <- expand.grid(Price = price_seq, AgeGroup = age_seq)
model <- lm(Rating ~ Price + AgeGroup, data = survey_data)
grid$Rating <- predict(model, newdata = grid)
plot_ly(data = grid, x = ~Price, y = ~AgeGroup, z = ~Rating, type = "surface") %>%
  layout(title = "3D Surface Plot of Product Ratings",
         scene = list(xaxis = list(title = 'Price ($)'),
                      yaxis = list(title = 'Age Group'),
                      zaxis = list(title = 'Rating (out of 5)')))
plot_ly(data = survey_data, x = ~Price, y = ~Rating, z = ~AgeGroup, 
        type = "scatter3d", mode = "markers", 
        marker = list(size = 5)) %>%
  layout(title = "Product Ratings vs Price",
         scene = list(xaxis = list(title = 'Price ($)'),
                      yaxis = list(title = 'Rating (out of 5)'),
                      zaxis = list(title = 'Age Group')))
plot_ly(data = survey_data, x = ~AgeGroup, y = ~Rating, z = ~Price, 
        type = "scatter3d", mode = "markers", 
        marker = list(size = 5)) %>%
  layout(title = "Product Ratings vs Age Group",
         scene = list(xaxis = list(title = 'Age Group'),
                      yaxis = list(title = 'Rating (out of 5)'),
                      zaxis = list(title = 'Price ($)')))
