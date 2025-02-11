## Data Analytics project

### Project Overview
This project uses a dataset of student performance to build a linear regression model that predicts GPA based on various factors like parental education, study time, tutoring, parental support, and absences. The goal is to evaluate and choose the best model for predicting GPA, using statistical tests and visualizations to ensure the model is valid.

### Libraries Used
Pandas: For handling data
NumPy: For numerical calculations
Matplotlib & Seaborn: For visualizations
Statsmodels: For building and evaluating regression models
SciPy: For statistical tests

### What I did
In this project, I first imported the dataset and explored its structure to understand the data. I then visualized the relationships between the variables and the target (GPA) using scatterplots and pairplots. Next, I built three different regression models using various subsets of predictors. After that, I evaluated each model by comparing key metrics like R-squared, AIC, and BIC to determine the best-performing one. I also checked the assumptions of the model, testing for multicollinearity, normality of residuals, and heteroskedasticity to ensure the model's reliability. Finally, I used the best model to make predictions for new data. Based on the evaluation, the best model was chosen for its higher R-squared and lower AIC/BIC values. Additionally, the residuals passed the normality tests, and no multicollinearity issues were detected. Outliers were also identified and reviewed through standardized residuals.

### Conclusion
This project shows how to predict GPA (or housing prices, depending on the dataset) using a linear regression model. The best model was chosen based on statistical metrics, and I checked the assumptions to ensure the model’s validity.

Feel free to experiment with your own dataset or make adjustments to improve the model!