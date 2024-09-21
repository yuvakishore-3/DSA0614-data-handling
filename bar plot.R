sales_data <- data.frame(
  Product = c("A", "B", "C", "D", "E"),
  Sales = c(300, 450, 500, 350, 400)
)
ggplot(sales_data, aes(x = Product, y = Sales, fill = Product)) +
  geom_bar(stat = "identity") +
  labs(title = "Sales by Product",
       x = "Product",
       y = "Sales") +
  theme_minimal()
