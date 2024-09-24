library(ggplot2)
library(plotly)
library(reshape2)
financial_data <- data.frame(
  Date = as.Date(c("2023-01-01", "2023-01-02", "2023-01-03", "2023-01-04", "2023-01-05")),
  StockPrice = c(100, 102, 98, 105, 108),
  VolumeTraded = c(2.5, 3.0, 2.2, 2.8, 3.5),
  MarketCap = c(500, 510, 490, 525, 540)
)
cor(financial_data[, c("StockPrice", "VolumeTraded", "MarketCap")])
plot_ly(data = financial_data, x = ~VolumeTraded, y = ~MarketCap, z = ~StockPrice, type = "scatter3d", mode = "markers") %>%
  layout(title = "3D Scatter Plot of Stock Price, Volume Traded, and Market Cap",
         scene = list(xaxis = list(title = 'Volume Traded (millions)'),
                      yaxis = list(title = 'Market Cap ($)'),
                      zaxis = list(title = 'Stock Price ($)')))
price_seq <- seq(min(financial_data$StockPrice), max(financial_data$StockPrice), length.out = 50)
volume_seq <- seq(min(financial_data$VolumeTraded), max(financial_data$VolumeTraded), length.out = 50)
grid <- expand.grid(StockPrice = price_seq, VolumeTraded = volume_seq)
model <- lm(MarketCap ~ StockPrice + VolumeTraded, data = financial_data)
grid$MarketCap <- predict(model, newdata = grid)
plot_ly(data = grid, x = ~StockPrice, y = ~VolumeTraded, z = ~MarketCap, type = "surface") %>%
  layout(title = "3D Surface Plot of Market Cap",
         scene = list(xaxis = list(title = 'Stock Price ($)'),
                      yaxis = list(title = 'Volume Traded (millions)'),
                      zaxis = list(title = 'Market Cap ($)')))
plot_ly(data = financial_data, x = ~VolumeTraded, y = ~StockPrice, z = ~MarketCap, type = "scatter3d", mode = "markers") %>%
  layout(title = "Stock Price vs Volume Traded",
         scene = list(xaxis = list(title = 'Volume Traded (millions)'),
                      yaxis = list(title = 'Stock Price ($)'),
                      zaxis = list(title = 'Market Cap ($)')))
plot_ly(data = financial_data, x = ~MarketCap, y = ~StockPrice, z = ~VolumeTraded, type = "scatter3d", mode = "markers") %>%
  layout(title = "Stock Price vs Market Cap",
         scene = list(xaxis = list(title = 'Market Cap ($)'),
                      yaxis = list(title = 'Stock Price ($)'),
                      zaxis = list(title = 'Volume Traded (millions)')))
