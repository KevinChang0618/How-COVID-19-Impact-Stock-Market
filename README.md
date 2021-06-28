# Project Goal
We would like to know how COVID-19 affect the US stock market. Because of COVID-19, the world economic was got the big hit. Therefore, we want to know the US market's situation.

# Methods
We choose daily confirmed cases, daily deaths, and daily vaccinations to be our independent variables. And choose daily NASQAD index to be response variable.  
1.Use linear regression to test how does the COVID-19 affect US market.  
2.Check residual plot and find heteroskedasticity problem and use Breusch-Pagan test to check. Then Use Weight Least Square to fix it.  
3.Use Durbin- Watson test to check Series correlation problem and use Lagging to fix it.  

# Result
When the daily cases increases, the stock price also increases. However, this result was conflict to we thought.  
Usually, we thought the severe pandemic will bring the big issues to our economic, but in our project is not. One of the reason may be we didn't consider that different industry
will have different situation during pandemic. Because those industry need to work in-person might be having big influence. Such as medical, school, or vender...etc.
On the other hand, those no need to work in-person's industry perhaps won't have big affect. Therefore, if we want to improve our result to be more precise, we need to collect
different industy's stock index then run the model again.

