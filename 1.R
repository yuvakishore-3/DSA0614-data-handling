library(ggplot2)
weight_height_data<-data.frame(
weight=c(60,65,70,72,75),
height=c(170,175,168,180,178)
)
ggplot(weight_height_data,aes(x=weight,y=height))+
  geom_point(color="blue",size=3)+
  labs(title="weights vs heights",
       x="weight(kg)",
       y="height(cm)")+
  theme_minimal()
