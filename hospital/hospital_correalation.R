install.packages("ggplot2") #ggplot 설치
library(ggplot2) # ggplot 사용
getwd() #사용할 디렉토리 확인

mydata <- read.csv("mydata.csv") #전체를 mydata라는 변수로 지정
hospital_A_data <- subset(mydata,Hospital == "1") # 전체 데이터에서 Hospital 칼럼의 값이 1인 친구를 추출
hospital_B_data <- subset(mydata,Hospital == "2")
hospital_C_data <- subset(mydata,Hospital == "3")

#View(mydata)

cor(mydata$Age,mydata$Commun, method = "pearson") #전체상관계수
cor(hospital_A_data$Age,hospital_A_data$Commun, method = "pearson") #A병원에 대한 상관계수
cor(hospital_B_data$Age,hospital_B_data$Commun, method = "pearson") #B병원에 대한 상관계수
cor(hospital_C_data$Age,hospital_C_data$Commun, method = "pearson") #C병원에 대한 상관계수


ggplot(mydata, aes(Age,Commun)) + geom_point() + geom_smooth() # geom_point = 산점도 , #geom_smooth(그래프)
ggplot(hospital_A_data, aes(Age,Commun)) + geom_point() + geom_smooth()
ggplot(hospital_B_data, aes(Age,Commun)) + geom_point() + geom_smooth()
ggplot(hospital_C_data, aes(Age,Commun)) + geom_point() + geom_smooth()