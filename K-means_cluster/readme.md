# 📊 K-Means Clustering 프로젝트 (기상 데이터 기반 군집화)

## 🧩 프로젝트 개요
기상 데이터를 활용하여 `K-Means` 클러스터링을 적용하고, 군집 간의 차이를 시각화함으로써 패턴을 분석하는 프로젝트입니다. 
다양한 클러스터 수에 따른 Within-Cluster Sum of Squares(WSS)를 비교하여 최적의 클러스터 수를 탐색하고, 사용자 입력값과 각 클러스터 중심 간의 거리도 계산합니다.

## 📦 사용 데이터
- 기온(temperature), 습도(humidity), 강수량(rainfall) 등 기상 관측치가 포함된 `.csv` 파일
- 사전 정규화(scale)된 상태로 K-Means 적용

## 🛠️ 사용 기술 및 패키지
- **언어**: R / R studio
- **주요 패키지**: `cluster`, `ggplot2`, `fpc`, `mclust`, `scale`, `flexmix` 등
- **시각화**: `ggplot2`을 활용한 2D 산점도와 클러스터 중심 표시
---

## 📈 핵심 기능

### ✅ 클러스터 수 테스트
- 클러스터 개수를 1~10까지 변화시키며 `withinss`를 시각화 → Elbow method로 최적 k 추정하여
  최적의 k를 시각화 하는 코드입니다.

1. **Elbow Method (cluster1.r)**  
   - k = 1~10 반복 클러스터링  
   - `withinss` 수집 후 산점도 그리기:  
     ```r
     plot(no_of_clusters, type="p",
          xlab="k (cluster 수)",
          ylab="Within-Cluster SS")
     ```  
   - 뚜렷한 꺾임점(Elbow)에서 최적 k 결정 → k = 4 선택
   **파이프라인 축소형 (kmeans_cluster1.r)**  
   - k = 4 고정, 클러스터링 → 시각화 → 거리 계산 루프를 통합  
   - `weather_norm2` 객체를 재활용하여 코드 간소화
  

### ✅ 클러스터링 수행
- `kmeans()` 함수를 활용하여 클러스터링 수행
- 정규화된 값 기반으로 중심점 계산 및 시각화

2. **기본 군집화 & 시각화 (cluster1.r)**  
   - k = 4로 재실행:  
     ```r
     results <- kmeans(weather_norm, 4)
     ```  
   - 군집 할당(`weather_data$cluster`) 후 2D 산점도:  
     ```r
     ggplot(weather_data, aes(temperature, humidity, color=cluster)) +
       geom_point() +
       geom_point(data=centers,
                  aes(temperature, humidity),
                  color="black", size=9, alpha=0.1)
     ```


### ✅ 사용자 입력 기반 클러스터 유사도 계산
- 사용자가 입력한 `temperature`, `humidity`, `rainfall` 값과 각 클러스터 중심 간의 유클리드 거리 출력

### ✅ 중심 복원 (optional)
- 정규화된 중심을 원본 스케일로 다시 복원하여 실 해석 가능하게 출력
- `set.seed(123)`로 재현성 보장  
 k = 8 클러스터링  
 정규화된 중심값을 원본 스케일로 복원하여 해석 가능하도록 변환  
 복원된 중심과 데이터 포인트를 함께 시각화

---
