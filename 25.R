library(ggplot2)
library(plotly)
library(dplyr)
library(reshape2)
academic_data <- data.frame(
  Student = c("A", "B", "C", "D", "E"),
  MathScore = c(85, 72, 90, 78, 88),
  ScienceScore = c(78, 85, 80, 75, 82),
  Attendance = c(95, 92, 98, 85, 93)
)
summary(academic_data)
cor(academic_data[, c("MathScore", "ScienceScore", "Attendance")])
plot_ly(data = academic_data, x = ~MathScore, y = ~ScienceScore, z = ~Attendance, 
        type = "scatter3d", mode = "markers", 
        marker = list(size = 5)) %>%
  layout(title = "3D Scatter Plot of Academic Performance",
         scene = list(xaxis = list(title = 'Math Score'),
                      yaxis = list(title = 'Science Score'),
                      zaxis = list(title = 'Attendance (%)')))
math_seq <- seq(min(academic_data$MathScore), max(academic_data$MathScore), length.out = 50)
attendance_seq <- seq(min(academic_data$Attendance), max(academic_data$Attendance), length.out = 50)
grid <- expand.grid(MathScore = math_seq, Attendance = attendance_seq)
model <- lm(ScienceScore ~ MathScore + Attendance, data = academic_data)
grid$ScienceScore <- predict(model, newdata = grid)
plot_ly(data = grid, x = ~MathScore, y = ~Attendance, z = ~ScienceScore, type = "surface") %>%
  layout(title = "3D Surface Plot of Science Scores",
         scene = list(xaxis = list(title = 'Math Score'),
                      yaxis = list(title = 'Attendance (%)'),
                      zaxis = list(title = 'Science Score')))
plot_ly(data = academic_data, x = ~MathScore, y = ~ScienceScore, z = ~Attendance, 
        type = "scatter3d", mode = "markers", 
        marker = list(size = 5)) %>%
  layout(title = "Science Scores vs Math Scores",
         scene = list(xaxis = list(title = 'Math Score'),
                      yaxis = list(title = 'Science Score'),
                      zaxis = list(title = 'Attendance (%)')))
plot_ly(data = academic_data, x = ~Attendance, y = ~ScienceScore, z = ~MathScore, 
        type = "scatter3d", mode = "markers", 
        marker = list(size = 5)) %>%
  layout(title = "Science Scores vs Attendance",
         scene = list(xaxis = list(title = 'Attendance (%)'),
                      yaxis = list(title = 'Science Score'),
                      zaxis = list(title = 'Math Score')))
