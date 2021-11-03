# Project Goal
We would like to know how COVID-19 affects the US stock market. Because of COVID-19, the world economy was got a big hit. Therefore, we want to know the US market's situation. And we build three different models to choose which is the best model.

# Methods
<b>Data Preprocessing</b>  
Because we want to fit the lineat regression, our first step should check our data follow OLS assumptions or not.   
1. Check variables distribution.  
2. Check VIF (X variables are independent).  
3. Check QQ plot (Errors (residuals) are normally distributed).
4. Check Heteroskedasticity (Errors (residuals) variance is constant).  
- In residual plot, we find heteroskedasticity problem and use<b> Breusch-Pagan test</b> to double check heteroskedasticity problem. (If p-value is siginificant, reject H0 of no heteroskedasticity => heteroscedasticity is present)  

![image](https://user-images.githubusercontent.com/67025904/134563425-3d9f512e-3545-416d-b635-db76d847734c.png)
![image](https://user-images.githubusercontent.com/67025904/134564427-696d0152-3790-48bb-8642-8b07e392c469.png)


- Then we use <b>Weight Least Square</b> to fix heteroskedasticity problem.  
5. Check serial problem (Observations are independent).  
- Use <b>Durbin- Watson test</b> to check <b>Serial Correlation</b> problem and use <b>Lagging</b> (Adding lagged one day of close into predictors) to fix it. 
![image](https://user-images.githubusercontent.com/67025904/134565476-81d7a377-fc27-42a4-a2a1-0b7cf101b959.png)

- <b>OLS model</b> become <b>WLS model</b> to avoid heteroskedasticity problems and add <b>lagged one day</b> predictors to avoid Series correlation problem. Then use <b>stepwise</b> to select variables for new model.  
   
<b>Fit the model</b>
- After cross validation on the new model, our new model's RMSE is 244.33.  
- Also, we create Ridge and LASSO regression to compare which model is the best. Ridge model's RMSE is 238.241 and LASSO's RMSE is 238.38.  
- LASSO is the best model with the lowest RMSE.  
 

# Result
When the daily cases increases, the stock price also increases. However, this result was conflict to we thought. Usually, we believed the severe pandemic will bring the big issues to our economic, but in our project is not. One of the reason may be we didn't consider that different industry will have different situation during pandemic. Because those industry need to work in-person might be having big influence. Such as medical, school, or vender...etc. On the other hand, those no need to work in-person's industry perhaps won't have big affect. Therefore, if we want to improve our result to be more precise, we need to collect different industy's stock index then run the model again.
