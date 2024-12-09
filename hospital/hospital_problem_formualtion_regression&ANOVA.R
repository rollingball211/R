mydata <- read.csv("mydata.csv") #전체를 mydata라는 변수로 지정

#결측치 확인

#EXP 이름 변경
mydata$exp_value <- mydata$Exp

#결측치가 얼마나 있는지 확인함 // 여기선 결측치가 없음
colSums(is.na(mydata))

#각 열에 결측치가 몇개 있는지 열별로 합산함 //결측치가 없음
data <- na.omit(mydata)


#경력기간 구간 그룹화 
data$career_group <- cut(data$Carr, 
                         breaks = c(0, 50, 100, 150, 200, Inf),
                         labels = c("1-50 months", "51-100 months", "101-150 months", "151-200 months", "200+ months"),
                         right = FALSE)  # 상한값을 포함하지 않게 하려면 FALSE로 설정
#나이 구간 그룹화
data$age_group <- cut(data$Age, 
                      breaks = c(20, 30, 40, 50, 60, Inf),
                      labels = c("20s", "30s", "40s", "50s", "60+"))
#그룹화 라벨 확인 
#print(data$career_group)

#경력과 디지털 방식 만족도의 관계 (탐색적 데이터 분석 EDA)

#경력 그룹별 만족도 시각화 (산점도)

library(ggplot2)
# 경력 그룹별 평균 만족도 시각화
ggplot(data, aes(x = career_group, y = Sat)) +
  geom_point(aes(color = career_group), size = 3) +  # 데이터 포인트 시각화
  stat_summary(fun = mean, geom = "point", color = "cyan", size = 4) +  # 평균값 추가
  labs(title = "경력 그룹별 만족도 점 그래프", x = "경력 그룹", y = "만족도")

#EMR 방식 사용 기간과 만족도 관계
ggplot(data, aes(x = Dur, y = Sat)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", col = "red") +
  labs(title = "EMR 사용방식 기간 vs. 만족도", 
       x = "EMR 사용방식 기간", 
       y = "만족도")

#회귀 분석



model <- lm(Sat ~ Carr + Age + Dur + SUSM + exp_value, data = data)
summary(model)


anova_model <- aov(SUSM ~ career_group, data = data)
summary(anova_model)







