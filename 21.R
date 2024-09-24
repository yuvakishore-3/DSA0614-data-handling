library(ggplot2)
library(plotly)
library(reshape2)
weather_data <- data.frame(
  Date = as.Date(c("2023-01-01", "2023-01-02", "2023-01-03", "2023-01-04", "2023-01-05")),
  Temperature = c(10, 12, 8, 15, 14),
  Humidity = c(75, 70, 80, 65, 72),
  WindSpeed = c(15, 12, 18, 20, 16)
)
cor(weather_data[, c("Temperature", "Humidity", "WindSpeed")])
humidity_seq <- seq(min(weather_data$Humidity), max(weather_data$Humidity), length.out = 50)
windspeed_seq <- seq(min(weather_data$WindSpeed), max(weather_data$WindSpeed), length.out = 50)
grid <- expand.grid(Humidity = humidity_seq, WindSpeed = windspeed_seq)
model <- lm(Temperature ~ Humidity + WindSpeed, data = weather_data)
grid$Temperature <- predict(model, newdata = grid)
plot_ly(data = grid, x = ~Humidity, y = ~WindSpeed, z = ~Temperature, type = "surface") %>%
  layout(title = "3D Surface Plot of Temperature",
         scene = list(xaxis = list(title = 'Humidity (%)'),
                      yaxis = list(title = 'Wind Speed (km/h)'),
                      zaxis = list(title = 'Temperature (°C)')))
plot_ly(data = weather_data, x = ~Humidity, y = ~Temperature, z = ~WindSpeed, type = "scatter3d", mode = "markers") %>%
  layout(title = "Temperature vs Humidity",
         scene = list(xaxis = list(title = 'Humidity (%)'),
                      yaxis = list(title = 'Temperature (°C)'),
                      zaxis = list(title = 'Wind Speed (km/h)')))
plot_ly(data = weather_data, x = ~WindSpeed, y = ~Temperature, z = ~Humidity, type = "scatter3d", mode = "markers") %>%
  layout(title = "Temperature vs Wind Speed",
         scene = list(xaxis = list(title = 'Wind Speed (km/h)'),
                      yaxis = list(title = 'Temperature (°C)'),
                      zaxis = list(title = 'Humidity (%)')))
