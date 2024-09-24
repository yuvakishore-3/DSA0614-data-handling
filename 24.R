library(ggplot2)
library(plotly)
library(dplyr)
library(reshape2)
environmental_data <- data.frame(
  Location = c("A", "B", "C", "D", "E"),
  Temperature = c(15, 20, 18, 12, 17),
  Humidity = c(65, 70, 68, 60, 72),
  CO2Levels = c(400, 450, 420, 380, 430)
)
summary(environmental_data)
cor(environmental_data[, c("Temperature", "Humidity", "CO2Levels")])
plot_ly(data = environmental_data, x = ~Temperature, y = ~Humidity, z = ~CO2Levels, 
        type = "scatter3d", mode = "markers", 
        marker = list(size = 5)) %>%
  layout(title = "3D Scatter Plot of CO2 Levels",
         scene = list(xaxis = list(title = 'Temperature (°C)'),
                      yaxis = list(title = 'Humidity (%)'),
                      zaxis = list(title = 'CO2 Levels (ppm)')))
temp_seq <- seq(min(environmental_data$Temperature), max(environmental_data$Temperature), length.out = 50)
humidity_seq <- seq(min(environmental_data$Humidity), max(environmental_data$Humidity), length.out = 50)
grid <- expand.grid(Temperature = temp_seq, Humidity = humidity_seq)
model <- lm(CO2Levels ~ Temperature + Humidity, data = environmental_data)
grid$CO2Levels <- predict(model, newdata = grid)
plot_ly(data = grid, x = ~Temperature, y = ~Humidity, z = ~CO2Levels, type = "surface") %>%
  layout(title = "3D Surface Plot of CO2 Levels",
         scene = list(xaxis = list(title = 'Temperature (°C)'),
                      yaxis = list(title = 'Humidity (%)'),
                      zaxis = list(title = 'CO2 Levels (ppm)')))
plot_ly(data = environmental_data, x = ~Temperature, y = ~CO2Levels, z = ~Humidity, 
        type = "scatter3d", mode = "markers", 
        marker = list(size = 5)) %>%
  layout(title = "CO2 Levels vs Temperature",
         scene = list(xaxis = list(title = 'Temperature (°C)'),
                      yaxis = list(title = 'CO2 Levels (ppm)'),
                      zaxis = list(title = 'Humidity (%)')))
plot_ly(data = environmental_data, x = ~Humidity, y = ~CO2Levels, z = ~Temperature, 
        type = "scatter3d", mode = "markers", 
        marker = list(size = 5)) %>%
  layout(title = "CO2 Levels vs Humidity",
         scene = list(xaxis = list(title = 'Humidity (%)'),
                      yaxis = list(title = 'CO2 Levels (ppm)'),
                      zaxis = list(title = 'Temperature (°C)')))
