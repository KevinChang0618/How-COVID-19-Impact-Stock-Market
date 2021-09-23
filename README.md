# Project Goal
We would like to know how COVID-19 affect the US stock market. Because of COVID-19, the world economic was got the big hit. Therefore, we want to know the US market's situation.

# Methods
We choose daily confirmed cases, daily deaths, and daily vaccinations to be our independent variables. And choose daily NASQAD index to be response variable.  
- Use linear regression to test how does the COVID-19 affect US market.  
- Check residual plot and find heteroskedasticity problem and use Breusch-Pagan test to double check heteroskedasticity problem. (If p-value is siginificant, reject H0 of no heteroskedasticity => heteroscedasticity is present.)
![image](https://user-images.githubusercontent.com/67025904/134563425-3d9f512e-3545-416d-b635-db76d847734c.png)
![image](https://user-images.githubusercontent.com/67025904/134564427-696d0152-3790-48bb-8642-8b07e392c469.png)


- Then we use Weight Least Square to fix it.  
- Use Durbin- Watson test to check Series correlation problem and use Lagging(Adding lagged one day of close into predictors) to fix it. 
![image](https://user-images.githubusercontent.com/67025904/134565476-81d7a377-fc27-42a4-a2a1-0b7cf101b959.png)

- OLS model become WLS model to avoid multicollinearity problems and add lagged one day predictors to avoid Series correlation problem. Then use stepwise to select variables for new model.  
- Also, we create Ridge and LASSO regression to compare which model is the best.  
- Ridge Regression is the best model with the lowest RMSE.  
 

# Result
When the daily cases increases, the stock price also increases. However, this result was conflict to we thought. Usually, we believed the severe pandemic will bring the big issues to our economic, but in our project is not. One of the reason may be we didn't consider that different industry will have different situation during pandemic. Because those industry need to work in-person might be having big influence. Such as medical, school, or vender...etc. On the other hand, those no need to work in-person's industry perhaps won't have big affect. Therefore, if we want to improve our result to be more precise, we need to collect different industy's stock index then run the model again.
