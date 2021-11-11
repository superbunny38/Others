#기말 데이터 분석 과제
#류채은

####################  패키지 설치 및 로드하기  ###################
install.packages("tidyverse")
library(tidyverse)
library(dplyr)
library(tidyr)
library(ggplot2)
install.packages("tbl_vars")
library(tbl_vars)
install.packages("reshape")
library(reshape)
library(plyr)
install.packages("rlang")
library(rlang)
install.packages("RColorBrewer")#color palettes
library("RColorBrewer")
library(scales)
install.packages("plotrix")
library(plotrix)
install.packages("hrbrthemes")
library(hrbrthemes)
install.packages("viridis")
library(viridis)
install.packages("ggExtra")
library(ggExtra)
install.packages("ggcharts")
library(ggcharts)
install.packages("ggridges")
library(ggridges)
install.packages("fmsb")
library(fmsb)

#working directory setting
getwd()
setwd("C:/Users/LG/Desktop/2020/3-1/DataScience&R")
getwd()

#################데이터 불러오기

raw_crime<- read.csv("crime.csv")

#############3데이터 검토하기

crime <- raw_crime
head(crime)
tail(crime)
View(crime)
dim(crime)
str(crime)
summary(crime)
colnames(crime)
names(crime)
class(crime$X.2008년.)
packageVersion("rlang")

#################변수명 바꾸기

crime <- as.tibble(crime)
#요인
typeof(crime)
class(crime)
crime <- dplyr::rename(crime, charge=X.2008년.)

crime$charge
colnames(crime)
#남자
crime <- dplyr::rename(crime, M_below_6 = X.남.6세이하.,
                M_7_12 = X.남.12세이하.,
                M_13_15 = X.남.15세이하.,
                M_16_20 = X.남.20세이하.,
                M_21_30 = X.남.30세이하.,
                M_31_40 = X.남.40세이하.,
                M_41_50 = X.남.50세이하.,
                M_51_60 = X.남.60세이하.,
                M_above_60 = X.남.60세초과.,
)

#여자

crime <- dplyr::rename(crime, F_below_6 = X.여.6세이하.,
                F_7_12 = X.여.12세이하.,
                F_13_15 = X.여.15세이하.,
                F_16_20 = X.여.20세이하.,
                F_21_30 = X.여.30세이하.,
                F_31_40 = X.여.40세이하.,
                F_41_50 = X.여.50세이하.,
                F_51_60 = X.여.60세이하.,
                F_above_60 = X.여.60세초과.,
)
colnames(crime)

#불상
crime<-dplyr::rename(crime, unknown = X.불상.)

colnames(crime)

###################  이상치 확인  >>


table(is.na(crime))#NA185개
nrow(crime)#row 개수와 같음(21 column에 쏠려있음)

#NA 없애기
ncol(crime)#21행에 NA이 쏠려있음
crime<- crime%>%
  select(c(1:20))

#NA 없음 확인
head(crime)
table(is.na(crime))

#이상치 없애기 "-"
crime_r <- crime
head(crime)
nrow(crime)
ncol(crime)

crime<-as.tibble(crime)

class(crime$M_below_6)#character
#char->numeric으로 강제 형 변환
#이 과정에서 없음(0)을 나타내던 '-'이 NA로 바뀜
crime$M_below_6 <-crime$M_below_6%>%
  as.numeric(crime$M_below_6)
crime$M_7_12 <-crime$M_7_12%>%
  as.numeric(crime$M_7_12)
crime$M_13_15 <- crime$M_13_15%>%
  as.numeric(crime$M_13_15)
crime$M_16_20 <- crime$M_16_20%>%
  as.numeric(crime$M_16_20)
crime$M_21_30 <- crime$M_21_30%>%
  as.numeric(crime$M_21_30)
crime$M_31_40 <- crime$M_31_40%>%
  as.numeric(crime$M_31_40)
crime$M_41_50<- crime$M_41_50%>%
  as.numeric(crime$M_41_50)
crime$M_51_60<- crime$M_51_60%>%
  as.numeric(crime$M_51_60)
crime$M_above_60<- crime$M_above_60%>%
  as.numeric(crime$M_above_60)

crime$F_below_6 <-crime$F_below_6%>%
  as.numeric(crime$F_below_6)
crime$F_7_12 <-crime$F_7_12%>%
  as.numeric(crime$F_7_12)
crime$F_13_15 <- crime$F_13_15%>%
  as.numeric(crime$F_13_15)
crime$F_16_20 <- crime$F_16_20%>%
  as.numeric(crime$F_16_20)
crime$F_21_30 <- crime$F_21_30%>%
  as.numeric(crime$F_21_30)
crime$F_31_40 <- crime$F_31_40%>%
  as.numeric(crime$F_31_40)
crime$F_41_50<- crime$F_41_50%>%
  as.numeric(crime$F_41_50)
crime$F_51_60<- crime$F_51_60%>%
  as.numeric(crime$F_51_60)

crime$F_above_60<- crime$F_above_60%>%
  as.numeric(crime$F_above_60)
crime$unknown <- crime$unknown %>%
  as.numeric(crime$unknown)


#char->numeric 형변환에 의해 생긴 NA를 0으로 대체
crime[is.na(crime)]<-0
head(crime)#확인

#NA 없음을 다시 확인
table(is.na(crime))

#마지막 열 의미 없어서 지움
crime <- crime[-185,]

##################################################################
##############################성별로 보는 범죄####################
##################################################################


#성별 기준 데이터 나누기

#여성 범죄 데이터

women_crime <- crime %>%select(charge|contains("F"))
colnames(women_crime)

#남성 범죄 데이터
men_crime <- crime %>%select(charge|contains("M"))
colnames(men_crime)

#총 여성 범죄 수와 총 남성 범죄 수 비교 누가 더 많을까? 얼마나 차이가 날까?

#나이 별로 성별 간 범죄 수 차이는?
head(women_crime)
colnames(women_crime)#wormen crime다 있는지 확인
women_crime_without_char <- women_crime[,-1]
head(women_crime_without_char)
sum_women<- mapply(sum,women_crime_without_char)
sum_women

men_crime_without_char <- men_crime[,-1]
sum_men<-mapply(sum,men_crime_without_char)
sum_men
colnames(crime)
sum_women
sum_men
sum_age<-bind_cols(sum_women,sum_men)
sum_age
age_range <- c("below_6","0_12","13_15","16_20","21_30",
               "31_40","41_50","51_60","above60")
sum_age<- bind_cols(age_range,sum_age)
colnames(sum_age)<-c("Age","Female","Male")#column이름 추가
sum_age
holistic_df <- df
df <- gather(sum_age, gender, sum_of_crime, Female:Male)#정렬 형태 변형

#######################시각화

#비교하기 쉽게 시각화(남성+여성 비교) bar

########## bar
df
plot <- ggplot(df, aes(Age,sum_of_crime, fill = gender))
plot <- plot + geom_bar(stat = "identity",position = 'dodge')
plot  + coord_flip()#보기 쉽게 flip함

#########  plot

ggplot(data = holistic_df,mapping = aes(x=Age, y=sum_of_crime, group = gender, color = gender, fill = gender))+ geom_line(size = 1.5) + scale_color_viridis(discrete = TRUE) +
  geom_point(shape=21,fill="#69b3a2", size = 5)+
  ggtitle("연령에 따른 성별간 범죄량 분석") +
  theme_ipsum()+
  ylab("총합 범죄량")


##########only 여성 연령에 따른 범죄량 시각화 bar

female_bar <- ggplot(data = sum_age, aes(x=Age, y = Female))+geom_col(fill="pink")+ theme_ipsum()

###########only남성 연령에 따른 범죄량 시각화 bar

male_bar <- ggplot(data = sum_age, aes(x=Age, y = Male))+geom_col(fill="lightblue")+theme_ipsum()

####총 범죄수는 성별 기준 얼마나 차이가 날까? bar
tmpdf <- df
tmpdf2 <- tmpdf

df <- tmpdf %>%
  group_by(gender) %>%
  summarise(SUM = sum(sum_of_crime), n  = n())

df <- tapply(tmpdf$sum_of_crime, tmpdf$gender, FUN=sum)
df <- t(df)
df <- t(df)

colnames(df) <- "count"

ggplot(data = df, aes(x = rownames(df), y = count, fill=rownames(df))) + geom_bar(position = 'dodge', stat = 'identity') + geom_text(aes(label=count), vjust = 0, color = "black", size= 7, position = position_dodge(width = 0.9)) + removeGrid() +xlab("gender")+ylab("total number of crimes") +theme(axis.ticks.y = element_blank(), axis.text.y = element_blank())+labs(fill = "Gender")

#범죄 항목 별로는 성별 간 얼마나 차이가 날까?

##########범죄항목 위주로 보기위한 전처리 과정########

head(crime)
crime_reason <-t(crime)#요인별로 보기 위해 형태태 바꿈
colnames(crime_reason)<-crime_reason[1,]#첫 열 없앰앰
crime_reason <- crime_reason[-1,]
crime_reason <- subset(crime_reason,select=-186)#마지막 가로 아무 것도 없어서 지움
crime_reason <- subset(crime_reason,select=-ncol(crime_reason))#맨 마지막줄도 지움

##########행 전처리 완료
colnames(crime_reason)

head(crime_reason)
age <- rownames(crime_reason)
rownames(crime_reason) <-NULL
crime_reason <- cbind(age,crime_reason)
head(crime_reason)
crime_reason<-as.data.frame(crime_reason)

##########group_by gender

#성별 간 합 구하기 위해 group_by 하려고 mutate
crime_reason <- crime_reason %>% mutate(gender = ifelse(grepl("M",age),"Male",
                                                        ifelse(grepl("F",age),"Female","Unknown")))
colnames(crime_reason)
#성별 기준 어떤 범죄를 가장 많이 일으킬까?

##############for 문 사용하여 character을 numeric으로 바꿈

for (i in 2:185){
  crime_reason[,i] <- crime_reason[,i]%>%
    as.numeric(crime_reason[,i])
}

colnames(crime_reason)

##전체에선 어떤 범죄를 가장 많이 일으킬까?
crime_reason_r <-crime_reason

for(i in 2:185){
  cat(i,typeof(crime_reason[,i]),"\n")
}

#범죄순위
crime_reason<-crime_reason_r

rownames(crime_reason)  
colnames(crime_reason)

#시각화


#성별 고려했을 때 범죄순위 

head(crime_reason)
total_crime <- crime_reason %>% group_by(gender)

crime_reason[1]
head(crime)

df2 <- as.data.frame(0*c(2:185))

df2<- t(df2)

for(i in 2:185){
  df2[,i-1]<-sum(crime_reason[,i])
}

colnames(df2) <- head(crime$charge,184)#df2의 이름 
colnames(df2)
rownames(df2)
rownames(df2)<-NULL
df2[1,]
#bar 전체
class(df2)#double이라서 data.frame으로 바꾸기
df2<-as.data.frame(df2)

t_df2 <- t(df2)

dim(t_df2)

rownames(t_df2)
t_df2%>% head()
t_df2 <- cbind(rownames(t_df2),t_df2[,1])

t_df3<-cbind(rownames(t_df2),t_df2)
t_df3 %>% head()
t_df3 <- t_df3[,c(2:3)]

colnames(t_df3)
rownames(t_df3)
t_df3[,2]
colnames(t_df3)<-c("Charge","total_sum")
t_df3 %>% head()
#전처리 완료

###################전체 범죄 bar graph로 그렸더니 난잡..

t_df3<-as.data.frame(t_df3)
messy<- t_df3
messy
ggplot(data=messy)+geom_bar(mapping=aes(x=Charge, y=total_sum),stat="identity")


###################범죄 종류 중에 뭐가 제일 많이 일어날까?

#성별 상관 x 범죄순위

t_df3 <- as.data.frame(t_df3)
t_df3$total_sum <- as.numeric(t_df3$total_sum)#숫자형태로 바꿈

ten_rank <- t_df3 %>% arrange(desc(total_sum))%>%  head(10)
ten_rank#범죄량 많은 순서대로 10위까지

####################파이그래프로 범죄량 많은 10위까지 그려보기

################파이그래프

ggplot(ten_rank, aes(x = "", y = total_sum, fill = Charge)) + geom_bar(stat = "identity",width=1) + coord_polar("y", start=0) + geom_text(aes(label = total_sum), color = "white", size = 5,position = position_stack(vjust = 0.5))+ labs(x = NULL, y = NULL, fill = NULL, title = "TOP 10 범죄 유형") + scale_fill_manual(values=c("#55DDE0", "#33658A", "#2F4858", "#F6AE2D", "#F26419", "#999999", "lightblue","pink","red","green")) +theme_classic()+ theme(axis.line = element_blank(),axis.text = element_blank(), axis.ticks = element_blank(),plot.title = element_text(hjust = 0.5, color = "#666666"))

#######가로형 bar graph

ten_rank$Charge <- factor(ten_rank$Charge, levels = ten_rank$Charge)

ggplot(ten_rank, aes(x=Charge, y = total_sum, fill = Charge))+geom_bar(position = position_dodge(), stat = "identity")+geom_col()+coord_flip()+xlab("") + theme_minimal()

##########group_by 형량

crime_reason$gender
head(crime_reason)
colnames(crime_reason)
names(crime)

################범죄 분류 crime_classification에 넣기(순서대로)
##12개유형
finance <- "재산범죄"
sexual <- "성범죄"
brutal <- "강력범죄"
work <- "노동범죄"
life <- "생활범죄"
mistake <- "과실범죄"
drug <- "마약관련범죄"
traffic <-"교통범죄"
law <- "질서범죄"
security <- "안보범죄"
etc <- "기타범죄"
military <- "병역범죄"

crime_classification <- finance
for(i in 1:8){
  crime_classification <- c(crime_classification,finance)
}

crime_classification <- c(crime_classification,sexual)

for(i in 1:8){
  crime_classification <- c(crime_classification,brutal)
}

for(i in 1:2){
  crime_classification <- c(crime_classification,finance)
}

for(i in 1:4){
  crime_classification <- c(crime_classification,work)
}

for(i in 1:2){
  crime_classification <- c(crime_classification,finance)
}

for(i in 1:3){
  crime_classification <- c(crime_classification,sexual)
}

crime_classification <- c(crime_classification,finance)

crime_classification <- c(crime_classification,life)


for(i in 1:3){
  crime_classification <- c(crime_classification,mistake)
}

crime_classification <- c(crime_classification,life)

for(i in 1:2){
  crime_classification <- c(crime_classification,work)
}

crime_classification <- c(crime_classification,life)
for(i in 1:2){
  crime_classification <- c(crime_classification,brutal)
}


crime_classification <- c(crime_classification,life)
crime_classification <- c(crime_classification,drug)
crime_classification <- c(crime_classification,traffic)
crime_classification <- c(crime_classification,work)

for(i in 1:2){
  crime_classification <- c(crime_classification,brutal)
}

crime_classification <- c(crime_classification, law)
crime_classification <- c(crime_classification, life)
crime_classification <- c(crime_classification, security)

for(i in 1:2){
  crime_classification <- c(crime_classification,life)
}
crime_classification <- c(crime_classification,etc)
crime_classification <- c(crime_classification,brutal)

for(i in 1:12){
  crime_classification <- c(crime_classification,law)
}

crime_classification <- c(crime_classification,traffic)

for(i in 1:14){
  crime_classification <- c(crime_classification,law)
}
for(i in 1:5){
  crime_classification <- c(crime_classification,traffic)
}
for(i in 1:4){
  crime_classification <- c(crime_classification,law)
}
for(i in 1:4){
  crime_classification <- c(crime_classification,drug)
}
for(i in 1:6){
  crime_classification <- c(crime_classification,law)
}
crime_classification <- c(crime_classification,military)

for(i in 1:7){
  crime_classification <- c(crime_classification,finance)
}

crime_classification <- c(crime_classification,law)
for(i in 1:2){
  crime_classification <- c(crime_classification,work)
}
for(i in 1:6){
  crime_classification <- c(crime_classification,law)
}

crime_classification <- c(crime_classification,sexual)
crime_classification <- c(crime_classification,law)
crime_classification <- c(crime_classification,life)
for(i in 1:15){
  crime_classification <- c(crime_classification,law)
}
crime_classification <- c(crime_classification,finance)
for(i in 1:3){
  crime_classification <- c(crime_classification,law)
}
crime_classification <- c(crime_classification,sexual)
for(i in 1:10){
  crime_classification <- c(crime_classification,law)
}
crime_classification <- c(crime_classification,security)
for(i in 1:2){
  crime_classification <- c(crime_classification,law)
}

for(i in 1:2){
  crime_classification <- c(crime_classification,finance)
}
for(i in 1:4){
  crime_classification <- c(crime_classification,law)
}

for(i in 1:3){
  crime_classification <- c(crime_classification,finance)
}
crime_classification <- c(crime_classification,work)

for(i in 1:3){
  crime_classification <- c(crime_classification,work)
}

crime_classification <- c(crime_classification,sexual)
for(i in 1:17){
  crime_classification <- c(crime_classification,law)
}
crime_classification <- c(crime_classification,etc)

crime_classification
###########분류순서대로저장끝

#crime과 crime_classification 합침
crime <- cbind(crime,crime_classification)

#통합
crime$total = rowSums(crime[,c(2:20)])

##범죄 분류별 합 구함
crime %>% head()

crime_class_abbreviation <- crime %>% group_by(crime_classification)%>%
  summarise(sum = sum(total))

crime_class_abbreviation <- tapply(crime$total, crime$crime_classification, FUN=sum)
crime_class_abbreviation <- as.data.frame(crime_class_abbreviation)

crime_class_abbreviation <- cbind(rownames(crime_class_abbreviation),crime_class_abbreviation)
rownames(crime_class_abbreviation)<- NULL
crime_class_abbreviation
colnames(crime_class_abbreviation)<- c("types","number_of_cases")

#%만들기
df_2 <- as.data.frame(crime_class_abbreviation) %>%
  mutate(pct = percent(number_of_cases / sum(number_of_cases)))
df_2

#############파이그래프

ggplot(df_2, aes(x = "", y = number_of_cases, fill = types)) + geom_bar(stat = "identity",width=1) + coord_polar("y", start=0) + geom_text(aes(label = pct), color = "white", size = 5,position = position_stack(vjust = 0.5))+ labs(x = NULL, y = NULL, fill = NULL, title = "유형별 범죄 비율") + scale_fill_manual(values=c("#55DDE0", "#33658A", "#2F4858", "#F6AE2D", "#F26419", "#999999", "lightblue","pink","red","green", "blue", "black")) +theme_classic()+ theme(axis.line = element_blank(),axis.text = element_blank(), axis.ticks = element_blank(),plot.title = element_text(hjust = 0.5, color = "#666666"))

##거미 그래프로 시각화해보기
spider_data <- t(df_2)
spider_data<-as.data.frame(spider_data)
colnames(spider_data)<- NULL

colnames(spider_data)<-spider_data[1,]
spider_data<-spider_data[c(2:3),]
spider_data


spider_data <- rbind(rep(500000,10),rep(0,10),spider_data)
spider_data<-as.data.frame(spider_data)
spider_data
class(spider_data[3,2])
spider_data<- spider_data[c(1:3),]
spider_data <- as.data.frame(spider_data)
j<-1
for(i in 1:3){
  for(j in 1:12){
    spider_data[i,j]<-as.numeric(spider_data[i,j])
  }
}

spider_data<-as.numeric(spider_data)
spider_data <- rbind(as.numeric(spider_data[1,]),as.numeric(spider_data[2,]),as.numeric(spider_data[3,]))#숫자형으로 강제 변환
colnames(spider_data)<- df_2$types
spider_data<-as.data.frame(spider_data)

radarchart(spider_data, axistype = 2,
           pcol = rgb(0.2,0.5,0.5,0.9),
           pfcol = rgb(0.2,0.5,0.5,0.5),
           plwd=5 , 
           cglcol = "grey", cglty = 1,
           axislabcol="grey", caxislabels=seq(0,500000,30), cglwd=0.8,
           vlcex = 1.2)

#######가로형 bar graph
crime

df_2$pct <- factor(df_2$pct, levels = ten_rank$pct)
bar_types <- ggplot(df_2, aes(x=types, y = number_of_cases, fill = types))+geom_bar(position = position_dodge(), stat = "identity")+geom_col()+coord_flip()+ylab("범죄 유형별 건수") + theme_minimal()+removeGridX() + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())+scale_x_discrete(limits = (df_2$types)) + geom_text(aes(label = number_of_cases),color = "black", vjust=-0.7)+xlab("범죄 유형")

bar_types+scale_fill_brewer(palette = "Spectral")

#######################연령으로 보는 범죄 현황

###male_young, male_middle, male_old
crime<-tmp_crime
crime <- crime[,c(1:22)]

crime <- as.data.frame(crime)
colnames(crime)
crime %>% head()
#male age gap 나누기
crime$male_young = rowSums(crime[,c(2:6)])#young: ~30세 미만
crime$male_middle = rowSums(crime[,c(7:9)])#middle: 30~60
crime$male_old = crime[,10]

###female_young, female_middle, female_old
crime$female_young = rowSums(crime[,c(11:15)])#young
crime$female_middle=rowSums(crime[,c(16:18)])
crime$female_old = crime[,19]
crime
names(crime)
crime[1]
tmp_crime <- crime

female_agegap <- data.frame(young = sum(crime$female_young),middle=sum(crime$female_middle),old=sum(crime$female_old))

female_agegap

male_agegap <- data.frame(young = sum(crime$male_young),middle=sum(crime$male_middle),old=sum(crime$male_old))

male_agegap

age<-c("young_male","middle_male","old_male")

##BIND 그래프 위해서 준비
male_agegap<-rbind(male_agegap,age)
male_agegap <- t(male_agegap)
colnames(male_agegap)<-c("crime","age")
male_agegap<-cbind(male_agegap,gender="male")

age<-c("young_female","middle_female","old_female")

female_agegap<-rbind(female_agegap,age)
female_agegap <- t(female_agegap)
colnames(female_agegap)<-c("crime","age")
female_agegap<-cbind(female_agegap,gender="female")

agegap = rbind(male_agegap,female_agegap)
agegap
##################연령대 별 그리기

agegap <- as.data.frame(agegap)
dim(agegap)
agegap$crime <- as.numeric(agegap$crime)

######시각화
typeof(agegap$crime)
options(scipen=10000)
sex_agegap_crime <- ggplot(data = agegap, aes(x=age, y = crime, fill=gender))+geom_col()+scale_x_discrete(limits=c("young_female","young_male","middle_female","middle_male","old_female","old_male"))

sex_agegap_crime 

#######################궁금증 해결 및 인사이트

names(crime)
crime$crime_classification

sexual_crime <- crime %>% filter(crime_classification == "성범죄")%>%select(where(is.numeric))
sexual_crime_name <- crime %>% filter(crime_classification == "성범죄")

sexual_crime_name <- sexual_crime_name[,1]
sexual_crime_name
sexual_crime
names(sexual_crime)
male_sexual_crime <- rowSums(sexual_crime[,c(21:23)])
male_sexual_crime_total <-cbind(sexual_crime_name,male_sexual_crime)
male_sexual_crime_total <- as.data.frame(male_sexual_crime_total)

female_sexual_crime <- rowSums(sexual_crime[,c(24:26)])
female_sexual_crime_total <- cbind(sexual_crime_name, female_sexual_crime)
female_sexual_crime_total<-as.data.frame(female_sexual_crime_total)

male_sexual_crime_total
female_sexual_crime_total
crime %>% select(where(is.numeric))%>%colSums()
cbind(male_sexual_crime_total,female_sexual_crime_total)

sum_sexual_crime<-colSums(sexual_crime)
sum_sexual_crime<-t(sum_sexual_crime)
sum_sexual_crime<-as.data.frame(sum_sexual_crime)
sum_sexual_crime
sum_sexual_crime<-t(sum_sexual_crime)
sum_sexual_crime<-as.data.frame(sum_sexual_crime)
sum_sexual_crime <- cbind(rownames(sum_sexual_crime),sum_sexual_crime$V1)

sexual_crime_agegap <- sum_sexual_crime[c(21:26),]
sexual_crime_agegap<-as.data.frame(sexual_crime_agegap)
sexual_crime_agegap

colnames(sexual_crime_agegap)<-c("age","number_of_cases")

sexual_crime_agegap$age<-factor(sexual_crime_agegap$age, levels = c("female_young","male_young","female_middle","male_middle","female_old","male_old"))
gender<- c("M","M","M","F","F","F")
cbind(sexual_crime_agegap,gender)
sexual_crime_agegap
############성범죄 분석 시각화

sexual_crime_plot <- ggplot(sexual_crime_agegap,aes(x=age,y=number_of_cases,fill=gender))+geom_bar(stat="identity")+labs(x="Age gap",y = "Nmber of sexual crime cases",color="Gender")
sexual_crime_plot+ggtitle("SEXUAL CRIME ANALYSIS")

#나이가 들수록 성적 생활에 제약이 있어서 성범죄를 저지를 확률이 높을 것 같습니다. 
#그래서 제 가정이 옳은지 알아보기 위해 연령과 성범죄는 관련이 있는지 알아보고 싶습니다

F_old <- cbind(crime$charge, crime$female_old)

M_old <- cbind(crime$charge, crime$male_old)

F_old <- as.data.frame(F_old)
names(F_old)<-c("charge","number_of_cases")

M_old <- as.data.frame(M_old)
names(M_old)<-c("charge","number_of_cases")

F_old$number_of_cases <- as.numeric(F_old$number_of_cases)

topten_female_old <- F_old %>%
  arrange(desc(number_of_cases))%>%head(10)##여성의 경우 가설 틀림

M_old$number_of_cases <- as.numeric(M_old$number_of_cases)

topten_male_old<- M_old %>%
  arrange(desc(number_of_cases))%>%head(10)##남성의 경우 가설 틀림
###시각화

#female old
ggplot(topten_female_old, aes(x=charge, y = number_of_cases, fill = charge))+geom_bar(position = position_dodge(), stat = "identity")+geom_col()+coord_flip()+ylab("범죄 유형별 건수") + theme_minimal()+removeGridX() + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())+scale_x_discrete(limits = (topten_female_old$charge)) + geom_text(aes(label = number_of_cases),color = "black", vjust=-0.7)+xlab("범죄 유형")+scale_fill_brewer(palette = "Set3")

#male old
ggplot(topten_male_old, aes(x=charge, y = number_of_cases, fill = charge))+geom_bar(position = position_dodge(), stat = "identity")+geom_col()+coord_flip()+ylab("범죄 유형별 건수") + theme_minimal()+removeGridX() + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())+scale_x_discrete(limits = (topten_male_old$charge)) + geom_text(aes(label = number_of_cases),color = "black", vjust=-0.7)+xlab("범죄 유형")+scale_fill_brewer(palette = "Paired")

topten_female_old
topten_male_old

#여성은 주로 범죄의 피해를 입는 쪽인데, 가해자 중 여성은 어떤 종류의 범죄를 가장 많이 저지를지 궁금합니다.
#맞는지 다시 보기!!!!!!!!!!!!!!!
female_crime <- rowSums(crime[,c(24:26)])#F만 모음

female_crime <- cbind(crime[,1],female_crime)#범죄명 갖고 옴

female_crime <- as.data.frame(female_crime)

names(female_crime)<-c("charge","number_of_cases")#이름 바꿈

female_crime$number_of_cases <- as.numeric(female_crime$number_of_cases)#숫자로바꿈

topten_female_crime <- female_crime %>%
  arrange(desc(number_of_cases))%>%head(10)#답
topten_female_crime

#여성 범죄 시각화
ggplot(topten_female_crime, aes(x=charge, y = number_of_cases, fill = charge))+geom_bar(position = position_dodge(), stat = "identity")+geom_col()+coord_flip()+ylab("범죄 유형별 건수") + theme_minimal()+removeGridX() + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())+scale_x_discrete(limits = (topten_female_crime$charge)) + geom_text(aes(label = number_of_cases),color = "black", vjust=-0.7)+xlab("범죄 유형")+scale_fill_brewer(palette = "PiYG")+ggtitle("여성 범죄 TOP10 유형 시각화화")

#남성이 가해자일 경우, 힘이 가장 센 시기인(30~40대) 정도에 범죄를 가장 많이 저지를 것 같은데, 저의 생각이 실제로 맞는지 궁금합니다.

#sexual_crime_plot <- ggplot(sexual_crime_agegap,aes(x=name,y=sexual_crime_agegap,fill=gender))+geom_bar(stat="identity")+labs(x#="Age gap",y = "Nmber of sexual crime cases",color="Gender")
#sexual_crime_plot#아놔? 앓아누울듯..
number_of_male_cases

number_of_male_cases <- as.data.frame(number_of_male_cases)
number_of_male_cases <- cbind(rownames(number_of_male_cases),number_of_male_cases$number_of_male_cases)

colnames(number_of_male_cases)<-c("age","number_of_cases")
number_of_male_cases<-as.data.frame(number_of_male_cases)
number_of_male_cases$number_of_cases <- as.numeric(number_of_male_cases$number_of_cases)

#세분화된 나이
number_of_male_cases<- colSums(crime[,c(2:9)])

names(number_of_male_cases) <- c("age","number_of_male_cases")
male_age <- rownames(number_of_male_cases)

male_crime <- rbind(male_age,number_of_male_cases$number_of_male_cases)
male_crime<-cbind(male_crime[c(1:9)],male_crime[c(10:18)])

colnames(male_crime)<-c("age","number_of_cases")
male_crime<-as.data.frame(male_crime)
male_crime$number_of_cases <- as.numeric(male_crime$number_of_cases)
male_crime

####시각화


ggplot(male_crime,aes(x = age,y = number_of_cases)) + 
  geom_bar(aes(fill = age),stat = "identity",show.legend = TRUE) + 
  scale_fill_manual(values = colorRampPalette(brewer.pal(9,"PuBu"))(9))+xlab("연령")+ylab("범죄 건수")+ggtitle("남성 연령별 범죄 건수 분석")

#41에서 50세 사이가 가장 범죄율이 높았다.

#나이가 많으면 힘이 약해지기에 신체적 힘을 요하는 범죄를 행할 가능성이 낮을 것 같은데, 저의 생각이 실제로 맞는지 궁금합니다.

young <- cbind(crime$male_young,crime$female_young)
young <- cbind(crime$charge, young)
colnames(young)<-c("charge","male_y","female_y")
young<-as.data.frame(young)
young$male_y <- as.numeric(young$male_y)
young$female_y <- as.numeric(young$female_y)

young <- young %>% mutate(total = female_y+male_y)
top10young <- young %>%
  select(charge,total)%>%
  arrange(desc(total))%>%
  head(10)
top10young#young하다는 기준을 너무 높게 잡은 것 같다. 20대는 내가 생각한 아이가 아니다.

##높게잡은 아이 시각화
ggplot(top10young, aes(x=charge, y = total, fill = charge))+geom_bar(position = position_dodge(), stat = "identity")+geom_col()+coord_flip()+ylab("범죄 유형별 건수") + theme_minimal()+removeGridX() + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())+scale_x_discrete(limits = (top10young$charge)) + geom_text(aes(label = total),color = "black", vjust=-0.7)+xlab("범죄 유형")+scale_fill_brewer(palette = "Pastel1")



#그렇기에 20 이하의 아이들을 조사해 보았다.
names(crime)
m_children <- crime[,c(2:5)]
f_children<- crime[,c(11:14)]
children <- cbind(m_children, f_children)
children <- cbind(crime$charge, children)
children <- as.data.frame(children)
names(children)
children <- children %>% 
  replace(is.na(.),0)%>%
  mutate(total = rowSums(.[2:9]))


names(children)

children <- children %>%
  dplyr::rename(charge = "crime$charge")

children%>%head()
top10children <- children %>%
  select(charge,total)%>%
  arrange(desc(total))%>%
  head(10)

top10children<-as.data.frame(top10children)
top10children#내 예상이 틀렸다. 오히려 사춘기라서 더 날뛰는 것 같다.

###시각화
ggplot(top10children, aes(x=charge, y = total, fill = charge))+geom_bar(position = position_dodge(), stat = "identity")+geom_col()+coord_flip()+ylab("범죄 유형별 건수") + theme_minimal()+removeGridX() + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())+scale_x_discrete(limits = (top10children$charge)) + geom_text(aes(label = total),color = "black", vjust=-0.7)+xlab("범죄 유형")+scale_fill_brewer(palette = "Pastel2")



#어린 아이들은 범죄의 타깃이 주로 되곤 하는데, 어린 아이들은 어떤 범죄를 가장 많이 저지를지 궁금합니다.

m_really_young <- cbind(crime$M_below_6,crime$M_7_12)#12세 이하
f_really_young <- cbind(crime$F_below_6,crime$F_7_12)
really_young <- cbind(m_really_young,f_really_young)
really_young <- cbind(crime$charge, really_young)
really_young <- as.data.frame(really_young)
really_young

really_young$V2 <- as.numeric(really_young$V2)
really_young$V3 <- as.numeric(really_young$V3)
really_young$V4 <- as.numeric(really_young$V4)
really_young$V5 <- as.numeric(really_young$V5)

really_young <- really_young %>%
  replace(is.na(.),0)%>%
  mutate(total = rowSums(.[2:5]))
  
really_young_top_10<- really_young%>%
  select(V1,total)%>%
  arrange(desc(total))%>%
  head(10)

colnames(really_young_top_10)<-c("charge","total")

really_young_top_10#요즘 애들이 무섭다더니... 강간.. 음주운전.. 난리네..

##시각화
really_young_top_10 %>%
  mutate(charge = fct_reorder(charge,total))%>%
  arrange(charge = factor(charge, levels = charge))%>%
  ggplot(aes(x=charge, y = total))+
  geom_segment( aes(xend=charge, yend=0)) +
  geom_point( size=4, color="orange") +
  coord_flip() +
  theme_bw() +
  ylab("범죄건수")+
  xlab("범죄명")

#60세 이상의 여성은 힘이 없고 성욕도 감퇴할 것 같아서 경제 범죄를 가장 많이 저지를 것 같은데, 저의 생각이 맞는지 궁금합니다.
really_old_female <- crime$F_above_60
really_old_female <- cbind(crime$charge, really_old_female)
really_old_female<- as.data.frame(really_old_female)
colnames(really_old_female)<- c("charge","number_of_cases")
really_old_female$number_of_cases <- as.numeric(really_old_female$number_of_cases)
really_old_female_top10 <- really_old_female %>%
  arrange(desc(number_of_cases))%>%
  head(10)

really_old_female_top10#맞긴 하지만... 6위에 폭행이 있긴 하다


##시각화
really_old_female_top10 %>%
  mutate(charge = fct_reorder(charge,number_of_cases))%>%
  arrange(charge = factor(charge, levels = charge))%>%
  ggplot(aes(x=charge, y = number_of_cases))+
  geom_segment( aes(xend=charge, yend=0)) +
  geom_point( size=4, color="red") +
  coord_flip() +
  theme_bw() +
  ylab("범죄건수")+
  xlab("범죄명")
