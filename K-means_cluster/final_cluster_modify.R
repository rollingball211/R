# 필요한 라이브러리 로드
library(ggplot2)
library(cluster)

# 데이터 불러오기
weather_data_wd <- read.csv(file = "C:/Users/jinhyeon/Desktop/겅부/SCC300 PROJECT/libraries/kmeans2.csv", header = TRUE, sep = ",")
View(weather_data_wd)

# 데이터 구조 확인
str(weather_data_wd)

# 데이터 복사 및 정규화
weather_data <- weather_data_wd
weather_norm <- scale(weather_data, center = TRUE, scale = TRUE)

# K-means 클러스터링 수행
set.seed(123)  # 결과 재현성을 위해 시드 설정
results <- kmeans(weather_norm, 8)

# 클러스터 결과 확인
results
results$size
results$withinss

# 정규화된 중심값을 원래 값으로 복원
centers_norm <- as.data.frame(results$centers)
centers <- centers_norm
for (col in colnames(weather_data)) {
  centers[[col]] <- centers_norm[[col]] * attr(weather_norm, "scaled:scale")[col] + attr(weather_norm, "scaled:center")[col]
}

# 클러스터 결과를 원본 데이터에 추가
weather_data$cluster <- factor(results$cluster)

# 산점도 시각화 (클러스터 중심을 진한 검은 점으로 표시)
ggplot(data = weather_data, aes(x = temperature, y = humidity, color = cluster)) +
  geom_point() + 
  geom_point(data = centers, aes(x = temperature, y = humidity), 
             color = "black", size = 6, alpha = 1) +
  labs(title = "Cluster Scatter Plot with Centers",
       x = "Temperature", y = "Humidity") +
  theme_minimal()

# 클러스터 중심과 사용자가 입력한 값 간 거리 계산
val <- as.data.frame(centers)
temp <- as.numeric(readline(prompt = "Enter Temperature (original value): "))
humidity <- as.numeric(readline(prompt = "Enter Humidity (original value): "))

i <- 1
while (i <= max(results$cluster)) {
  num_1 <- val[i, 1]
  num_2 <- val[i, 2]
  print(paste0("Cluster No.", i))
  print(sqrt((temp - num_1)^2 + (humidity - num_2)^2))
  i <- i + 1
}
