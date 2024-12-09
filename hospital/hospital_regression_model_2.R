# 필요한 변수만 추출
data_subset <- mydata[, c("Age", "Commun")]

# 결측값 처리
data_subset <- na.omit(data_subset)

library(ggplot2)

#산점도 및 선형 (=> 결론 : 나이가 오를수록 소통점수가 떨어진다)
ggplot(data_subset, aes(x = Age, y = Commun)) +
  geom_point(aes(color = Age), size = 3) +  # 나이에 따라 색상 변경
  geom_smooth(method = "lm", color = "red") +  # 선형 회귀선 추가
  labs(title = "Age vs. Communication Improvement Score",
       x = "Age", y = "Communication Improvement Score") +
  theme_minimal()


#상관분석 (음에 가까울수록 나이가 많을수록 소통개선점수가 낮다)
cor(data_subset$Age, data_subset$Commun)

model <- lm(Commun ~ Age, data = data_subset)

# 회귀 분석 결과 확인
summary(model)
