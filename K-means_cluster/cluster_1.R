library(cluster)
library(HSAUR)
library(mclust)
library(flexmix)
library(modeltools)
library(prabclus)
library(diptest)
library(robustbase)
library(DEoptimR)
library(trimcluster)
library(kernlab)
library(fpc)
library(mvtnorm)
library(ggplot2)

library(gtable)
library(Rcpp)
library(scales)
library(lazyeval)
library(munsell)
library(colorspace)
library(plyr)
library(rlang)
library(tibble)
library(pillar)
library(crayon)
library(pkgconfig)
library(withr)
library(labeling)
library(digest)





options(max.print = 250000)
weather_data_wd = read.csv(file = "C:/Users/jinhyeon/Desktop/겅부/SCC300 PROJECT/libraries/finalkim_kmeans.csv", header=TRUE, sep=",")
View(weather_data_wd)

str(weather_data_wd)

weather_data = weather_data_wd 



View(weather_data)

weather_norm = scale(weather_data[,], TRUE, TRUE)

#data_norm <- function(x){
#  ((x - min(x)) / (max(x) - min(x)))
#}
#weather_norm <- as.data.frame(lapply(weather_data[,], data_norm))

View(weather_norm)


results1 = kmeans(weather_norm,1)
results1
results2 = kmeans(weather_norm,2)
results2
results3 = kmeans(weather_norm,3)
results3
results4 = kmeans(weather_norm,4)
results4
results5 = kmeans(weather_norm,5)
results5
results6 = kmeans(weather_norm,6)
results6
results7 = kmeans(weather_norm,7)
results7
results8 = kmeans(weather_norm,8)
results8
results9 = kmeans(weather_norm,9)
results9
results10 = kmeans(weather_norm,10)
results10



no_of_clusters = c(results1$withinss,results2$withinss,results3$withinss,results4$withinss,results5$withinss,results6$withinss,results7$withinss,results8$withinss,results9$withinss,results10$withinss)
no_of_clusters
plot(no_of_clusters,type = "p", xlab = "No. of Withss / cluster", ylab = "Value of Withinss")
axis(1, at = seq(1, 55, by = 1), las=2)



results = kmeans(weather_norm,4)
results

results$size
results$withinss

weather_data$cluster = factor(results$cluster)

View(weather_data)

centers=as.data.frame(results$centers)

ggplot(data=weather_data, aes(x=temperature, y=humidity, color=cluster )) + 
  geom_point() + 
  geom_point(data=centers, aes(x=temperature, y=humidity, color='Center')) +
  geom_point(data=centers, aes(x=temperature, y=humidity, color='Center'), size=9, alpha=.1, legend=FALSE)          


val <- data.frame(results$centers)
val
temp <- as.numeric(readline(prompt="Enter Temperature:(scaled value) "))
rainfall <- as.numeric(readline(prompt="Enter Rainfall:(scaled value) "))
humidity <- as.numeric(readline(prompt="Enter Humidity:(scaled value) "))


i = 1


while (i <= max(results$cluster)) 
{
  
  num_1 = val[i,1]
  num_2 = val[i,2]
  num_3 = val[i,3]
  print(paste0("Cluster No.",i))
  
  print(sqrt( (temp-num_1)*(temp-num_1)+ (rainfall - num_2)*(rainfall - num_2)+(humidity - num_3)*(humidity - num_3)))
  i = i+1
}

