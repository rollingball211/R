# 🏥 Hospital Data 분석 프로젝트

## 🧩 프로젝트 개요
병원 이용자 설문·행동 데이터를 기반으로 
**연령(Age)**, **경력기간(Carr)**, **EMR 사용 기간(Dur)**, **시스템 사용성(SUSM)**,
**디지털 경험(exp_value)**, **만족도(Sat)**,
**커뮤니케이션 개선점수(Commun)**  간의 관계를 탐구하고, 상관관계·회귀분석·ANOVA를 통해 주요 영향 요인을 파악하는 프로젝트

---

## 📦 사용 데이터
- **파일**: mydata.csv  
- **주요 컬럼**  
  - Hospital (A=1, B=2, C=3)  
  - Age (이용자 나이, months)  
  - Carr (경력기간, months)  
  - Dur (EMR 사용 기간, months)  
  - Exp → exp_value (디지털 서비스 경험 점수)  
  - SUSM (시스템 사용성 점수)  
  - Sat (전반적 만족도)  
  - Commun (커뮤니케이션 개선점수)

---

## 🛠️ 사용 기술 & 패키지
- **언어**: R  , Rstuido
- **패키지**:  
  - 시각화: ggplot2  
  - 통계분석: stats (lm, aov), cluster  
  - 데이터 가공: dplyr, subset  
---

## 🔍 핵심 분석 기능

1. **상관관계 분석**  
   - 전체 및 병원(A/B/C)별 Age vs Commun Pearson 상관계수 계산  

2. **EDA & 그룹화**  
   - career_group: 0–50, 51–100, 101–150, 151–200, 200+ (months)  
   - age_group: 20s, 30s, 40s, 50s, 60+  
   - 경력 그룹별 만족도 산점도 + 평균점 표시  
   - EMR 사용 기간 vs 만족도 선형 회귀 시각화

3. **다변량 회귀분석**  
   - 주요 결과: Carr, Dur, SUSM 등이 Sat에 유의미한 영향

4. **ANOVA**  
   - SUSM ~ career_group 간 차이 검정:  
r
     anova_model <- aov(SUSM ~ career_group, data = data)
     summary(anova_model)


5. **단일 회귀분석 (Commun ~ Age)**  
   - 결과: 나이 증가 시 커뮤니케이션 점수 감소 경향

6. **추가 상관·산점도 (Carr vs Sat)**  
   - 전체 및 병원별 Carr vs Sat 시각화 및 상관계수 확인

---

## 📈 시각화 코드

r
# Age vs Commun 산점도
ggplot(mydata, aes(Age, Commun)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", color = "blue") +
  labs(title = "Age vs Communication Improvement Score")

# EMR 사용 기간 vs 만족도 선형 회귀
ggplot(data, aes(Dur, Sat)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "EMR Usage Duration vs Satisfaction")
