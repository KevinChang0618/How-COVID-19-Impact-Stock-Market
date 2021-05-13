na <- read.csv("NASDAQ2020_2021.csv")  

par(mfrow = c(2,2))
hist(na$Daily_cases)
qqnorm(na$Daily_cases, main = "Daily cases QQ Plot") 
qqline(na$Daily_cases)
hist(na$Daily_deaths)
qqnorm(na$Daily_deaths, main = "Daily deaths QQ Plot") 
qqline(na$Daily_deaths)
hist(na$Daily_vaccinations)
hist(na$Close)
par(mfrow = c(1,2))
# fit OLS model and inspect Normality
reg <- lm(Close~ Daily_cases +Daily_deaths +Daily_vaccinations +Cumulative_cases + Cumulative_deaths, data = na)
summary(reg)
plot(reg,which = 2)

# inspect heteroskedasticity 
library(lmtest)
bptest(reg,data = na)

# fit WLS model
abs.res<-abs(residuals(reg))
fitted.reg<- fitted(reg)
lm.abs.res<-lm(abs.res~fitted.reg)
plot(fitted.reg,abs.res)
abline(lm.abs.res,col="red")

wts <- 1/fitted(lm.abs.res)^2
wls.reg<-lm(Close~ Daily_cases +Daily_deaths +Daily_vaccinations +Cumulative_cases + Cumulative_deaths, data=na,weights = wts)
summary(wls.reg)

# inspect Serial Correlation 
dwtest(reg)
library(DataCombine)
close <- slide(na,Var = "Close", NewVar = "Close.L1", slideBy = -1)

fit2 <- lm(Close~Close.L1+Daily_cases+Cumulative_cases+Daily_deaths+Cumulative_deaths+Daily_vaccinations, data = close)
dwtest(fit2)


# variable selection
wls.reg2 <-lm(Close~ Close.L1+Daily_cases +Daily_deaths +Daily_vaccinations +Cumulative_cases + Cumulative_deaths, data=close,weights = wts)
reduced = lm(Close~1,data = close)
reg.step=step(wls.reg2, scope = list(lower = reduced, upper = wls.reg2),direction="both", test="F")
summary(reg.step)

# final OLS model
close <- close[-1,]
wts <- wts[-1]
reg.final <-lm(Close~ Close.L1 + Daily_cases + Cumulative_deaths, data=close,weights = wts)

# OLS cross-validation
set.seed(123)
n = length(close$Close)
z =sample(n,0.8*n)

reg.cv <-lm(Close~ Close.L1 + Daily_cases + Cumulative_deaths, data=close[z,],weights = wts[z])
test.mse.rs <- mean( (close$Close[-z] - predict(reg.cv, close[-z,]) )^2)# 52869.23
rmse.ols = round(sqrt(test.mse.rs),3)

# Ridge 
library(glmnet)
x = model.matrix(reg.final) 
y = close$Close

set.seed(123)
ridge.cv = cv.glmnet(x[z,], y[z],alpha =0, lambda = seq(0,100,0.01))
ridge.cv$lambda.min

plot(ridge.cv)

ridge = glmnet(x[z,],y[z],alpha =0, lambda = ridge.cv$lambda.min)
Yhat = predict( ridge, ridge.cv$lambda.min, newx = x[-z,] )
ridge.mse = mean((Yhat - y[-z])^2 ) # 51477.54
ridge.rmse = round(sqrt(ridge.mse),3)

# LASSO
set.seed(123)
lasso.cv = cv.glmnet(x[z,], y[z],alpha =1, lambda = seq(0,100,0.01))
lasso.cv$lambda.min

plot(lasso.cv)

lasso = glmnet(x[z,],y[z],alpha =1, lambda = lasso.cv$lambda.min)
Yhat = predict( lasso, lasso.cv$lambda.min, newx = x[-z,] )
lasso.mse = mean((Yhat - y[-z])^2 ) # 52521.01
lasso.rmse = round(sqrt(lasso.mse),3)

rbind(c("OLS RMSE", "Ridge RMSE", "Lasso RMSE"), c(rmse.ols, ridge.rmse,lasso.rmse))


