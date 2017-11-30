setwd("c:/Users/����/Desktop/new_bigdata_set/Final Total Data")
df <- read.csv("Sleeping princess in penguin room.csv")
infl.id <- c(44, 106, 145)
df.1 <- df[-as.numeric(infl.id),]
life.1 <- df.1[[3]]
gdp.1 <- df.1[[4]]; sani.1 <- df.1[[5]]; pre.1 <- df.1[[6]]; pri.1 <- df.1[[7]]
sec.1 <- df.1[[8]]; ter.1 <- df.1[[9]]; smo.1 <- df.1[[11]]; ob.1 <- df.1[[12]]
al.1 <- df.1[[13]]; co2.1 <- df.1[[14]]; hiv.1 <- df.1[[15]]

n.1 <- nrow(df.1); p <- ncol(df.1) - 4
library(corrplot); library(DAAG)
#### cp ...... c pal
reg.r <- lm(life.1~gdp.1+sani.1+pre.1+pri.1+ter.1+smo.1+ob.1+hiv.1)
df.r <- as.data.frame(cbind(life = life.1, gdp = gdp.1, sani = sani.1, pre = pre.1,
              pri = pri.1, ter = ter.1, smo = smo.1, ob = ob.1, hiv = hiv.1))
plot(df.r)
cor1.matrix <- matrix(0,8,8)
colnames(cor1.matrix) <- rownames(cor1.matrix) <- colnames(df.r)[-1]
for(i in 1:8){
  for(j in 1:8){
    a <- cor(df.r[,i+1], df.r[,j+1])
    cor1.matrix[i,j] <- a
  }
}
round(cor1.matrix, 4)
vif(reg.r)

#### cp ...... log c pal
log.gdp <- log(gdp.1, 10); log.co2 <- log(co2.1, 2); log.hiv <- log(hiv.1, 2)
reg.logr <- lm(life.1~log.gdp+sani.1+pre.1+pri.1+ter.1+smo.1+log.co2+log.hiv)
df.logr<- as.data.frame(cbind(life = life.1, log.gdp = log.gdp, sani = sani.1, pre = pre.1,
                              pri = pri.1, ter = ter.1, smo = smo.1, log.co2 = log.co2, log.hiv = log.hiv))
plot(df.logr)

corrplot(df.r, method="number")
cor.matrix <- matrix(0,8,8)
colnames(cor.matrix) <- rownames(cor.matrix) <- colnames(df.logr)[-1]
cor(sani.1, log.co2)
for(i in 1:8){
  for(j in 1:8){
    a <- cor(df.logr[,i+1], df.logr[,j+1])
    cor.matrix[i,j] <- a
  }
}
round(cor.matrix, 4)
cor.matrix[which(cor.matrix > 0.5)]
vif(reg.logr)  ##10 or 4�� ������ ������ �ִٰ� �����Ѵ�.
#why log transformation's the vip is lower than the vip?
###########################################################
anova(reg.r, reg.logr)
AIC(reg.r, reg.logr)
BIC(reg.r, reg.logr)
summary(reg.r); summary(reg.logr)
plot(df[,-c(1,2,10)])