install.packages("caTools") 
library(caTools) 
library(dplyr)
library(ggplot2)
install.packages("rpart")
install.packages("rpart.plot")
library(rpart)
library(rpart.plot)
library(ggcorrplot)
library(randomForest)
library(caret)
install.packages("caTools")  # Install caTools 

h_df=USA_Housing_Dataset
housing_data = USA_Housing_Dataset
View(housing_data)
dim(housing_data)
head(housing_data)
str(housing_data)
summary(housing_data)
#checking if any names are duplicated and if any duplicate are found, removing it
housing_data[duplicated(housing_data), ]
#checking if any data is missing.
sum(is.na(housing_data))
# Remove rows where the price is 0
housing_data <- housing_data %>%
  filter(price != 0)
housing_data <- housing_data%>% select(-statezip,-street)
#Making necessary columns as vectors
max(housing_data$price)
housing_data$city <- as.factor(housing_data$city)

# Convert the waterfront variable to a factor
housing_data$waterfront <- as.factor(housing_data$waterfront)
#creating a renovated col
housing_data<- housing_data %>%
  mutate(renovated = ifelse(yr_renovated > 0, 1, 0))
# Convert the `renovated` column to a factor
housing_data <- housing_data %>%
  mutate(renovated = as.factor(renovated))
#creating a col showing the age of house
housing_data$oldbuilt <- as.integer(format(Sys.Date(), "%Y")) - housing_data$yr_built
housing_data<- housing_data %>%
  mutate(oldbuilt)
drops <- c("yr_built")


# Check which columns are not numeric
non_numeric_cols <- names(housing_data)[!sapply(housing_data, is.numeric)]
numeric_cols <- names(housing_data)[sapply(housing_data, is.numeric)]
# Display non-numeric columns
print(non_numeric_cols)
print(numeric_cols)
# Check the updated dataset
head(housing_data)
maindf <- housing_data[,c("price","bedrooms","bathrooms","sqft_living","floors",
                  "sqft_lot", "condition", "view", "yr_built","sqft_above","sqft_basement","yr_renovated","oldbuilt")]



# 1. Combine 'sqft_living' and 'sqft_basement' into a total square footage feature
housing_data <- housing_data %>%
  mutate(total_sqft = sqft_living + sqft_basement)

# 2. Create a feature for price per square foot
housing_data <- housing_data %>%
  mutate(price_per_sqft = price / total_sqft)

# 3. Create interaction term: bedrooms * bathrooms
housing_data <- housing_data %>%
  mutate(bed_bath_interaction = bedrooms * bathrooms)


# Preview the new features
head(housing_data %>% select(total_sqft, price_per_sqft, bed_bath_interaction))
head(housing_data)
#Plot Correlation matrix
cor(maindf)

corr <- round(cor(maindf), 1)

# Plot
ggcorrplot(corr,
           type = "lower",
           lab = TRUE, 
           lab_size = 5,  
           colors = c("tomato2", "white", "springgreen3"),
           title="Correlogram of Housing Dataset", 
           ggtheme=theme_bw)
pairs(~bedrooms + sqft_living + floors + condition+yr_built, data = maindf,
      main = "Scatterplot Matrix")
par(mfrow=c(2, 3))  # divide graph area in 2 columns
boxplot(maindf$bedrooms, main="Bedrooms")
boxplot(maindf$sqft_living, main="sqft_living")
boxplot(maindf$floors, main="floors")
boxplot(maindf$condition, main="condition")
boxplot(maindf$view, main="view")
boxplot(maindf$oldbuilt, main="oldbuilt")
## Checking for outliers in variables using boxplot
#For price

ggplot(housing_data, aes(x = renovated)) +
  geom_bar(fill = "skyblue") +
  labs(title = "Number of Renovated vs. Not Renovated Houses", x = "Renovation Status", y = "Count") +
  theme_minimal()

# Calculate the average price for each category of 'renovated'
average_price <- housing_data %>%
  group_by(renovated) %>%
  summarise(avg_price = mean(price, na.rm = TRUE))

# Create the bar graph
ggplot(average_price, aes(x = renovated, y = avg_price, fill = renovated)) +
  geom_bar(stat = "identity") +
  labs(title = "Average House Price by Renovation Status",
       x = "Renovated",
       y = "Average Price") +
  theme_minimal()
## bargraph for yr_built
ggplot(housing_data, aes(x=yr_built )) +
  geom_bar(color="red", width = 0.50, fill = "red")+
  labs(x= "yr_built", y= "Number of houses built" )+
  theme(plot.title = element_text(size=9.05, color = "grey", face = "bold"), 
        axis.title.x = element_text(size = 9, color = "grey", face = "bold"),
        axis.title.y = element_text(size = 9, color = "grey", face = "bold"))

## bargraphs for sqft_living
ggplot(housing_data, aes(x=sqft_living )) +
  geom_bar(color="red", width = 0.50, fill = "red")+
  labs(x= "sq", y= "Number of houses" , title = "Age of CardHolders")+
  theme(plot.title = element_text(size=9.05, color = "grey", face = "bold"), 
        axis.title.x = element_text(size = 9, color = "grey", face = "bold"),
        axis.title.y = element_text(size = 9, color = "grey", face = "bold"))

#Bar Graph of Average Price by City
ggplot(housing_data, aes(x = city, y = price)) +
  stat_summary(fun = mean, geom = "bar", fill = "skyblue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Average Price by City", x = "City", y = "Average Price")
#Bar Graph of Waterfront
ggplot(housing_data, aes(x = waterfront, y = price)) +
  stat_summary(fun = mean, geom = "bar", fill = "skyblue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Average Price by Waterfront", x = "City", y = "Average Price")
##Bar Graph of View
ggplot(housing_data, aes(x = view, y = price)) +
  stat_summary(fun = mean, geom = "bar", fill = "skyblue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Average Price by View", x = "City", y = "Average Price")


#  Bar Graph of Price by Number of Bedrooms
ggplot(housing_data, aes(x = as.factor(bedrooms), y = price)) +
  stat_summary(fun = mean, geom = "bar", fill = "lightgreen") +
  labs(title = "Average Price by Number of Bedrooms", x = "Number of Bedrooms", y = "Average Price")

#  Bar Graph of Price by Number of Bathrooms
ggplot(housing_data, aes(x = as.factor(bathrooms), y = price)) +
  stat_summary(fun = mean, geom = "bar", fill = "orange") +
  labs(title = "Average Price by Number of Bathrooms", x = "Number of Bathrooms", y = "Average Price")

# Bar Graph of Price by Condition or Quality (assuming there is a 'condition' column)
ggplot(housing_data, aes(x = condition, y = price)) +
  stat_summary(fun = mean, geom = "bar", fill = "pink") +
  labs(title = "Average Price by Condition", x = "Condition", y = "Average Price")


#  Bar Graph Showing Price Range Frequency
housing_data$price_range <- cut(housing_data$price, breaks = seq(0, max(housing_data$price), by = 100000))
ggplot(housing_data, aes(x = price_range)) +
  geom_bar(fill = "red") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Frequency of Price Ranges", x = "Price Range", y = "Frequency")

# Bar Graph of Price by year built (assuming there is an 'age' column)
housing_data$age_group <- cut(housing_data$yr_built, breaks = c(0, 5, 10, 20, 50, Inf), labels = c("0-5 years", "5-10 years", "10-20 years", "20-50 years", "50+ years"))
ggplot(housing_data, aes(x = yr_built, y = price)) +
  stat_summary(fun = mean, geom = "bar", fill = "cyan") +
  labs(title = "Average Price by Age of House", x = "Age Group", y = "Average Price")


# Split data into training and validation
set.seed(135)
split <- sample.split(housing_data$price, SplitRatio = 0.8)
training_data <- subset(housing_data, split == TRUE)
validation_data <- subset(housing_data, split == FALSE)
head(validation_data)

# Calculate Q1 and Q3
Q1 <- quantile(housing_data$price, 0.25, na.rm = TRUE)
Q3 <- quantile(housing_data$price, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1

# Define the outlier limits
lower_limit <- Q1 - 1.5 * IQR
upper_limit <- Q3 + 1.5 * IQR

# Identify outliers
outliers <- housing_data %>% 
  filter(price < lower_limit | price > upper_limit)
par(mfrow=c(2, 2))

# Visualize with a boxplot
ggplot(housing_data,aes(x= city,y = price))+geom_boxplot()

# Define models
model1 <- lm(price ~ bedrooms+bathrooms+sqft_living+sqft_lot+floors+waterfront+view+condition
             +sqft_above+yr_built+yr_renovated+city+renovated, data = training_data)
model2 <- lm(price ~ bedrooms+bathrooms+total_sqft+ price_per_sqft+sqft_living+renovated+waterfront,data = training_data)
model3 <- lm(price ~ bedrooms * bathrooms + sqft_living, data = training_data)
model4<- lm(price ~ poly(sqft_living, 2) + poly(bathrooms, 2), data = training_data)

colnames(housing_data)
# Function to evaluate models
evaluate_model <- function(model) {
  predictions <- predict(model, newdata = validation_data)
  mse <- mean((validation_data$price - predictions)^2)
  r_squared <- summary(model)$r.squared
  linear_reg_rs<-r_squared
  return(data.frame(MSE = mse, R_squared = r_squared))
}

# Collect results
model_results <- data.frame(Model = c("Model 1","Model 2", "Model 3", "Model 4"), stringsAsFactors = FALSE)
model_results <- cbind(model_results, do.call(rbind, lapply(list(model1,model2, model3, model4), evaluate_model)))

# Print results
print(model_results)

# Select the best model based on criteria
best_model <- model_results[which.max(model_results$R_squared),]
print(best_model)

# View model summary
summary(best_model)

# Make predictions on the adjusted validation data
predictions <- predict(model, newdata = validation_data)

# View predictions
head(predictions)
mse <- mean((validation_data$price - predictions)^2)
rmse <- sqrt(mse)

# Print error metrics
cat("Mean Squared Error (MSE):", mse, "\n")
cat("Root Mean Squared Error (RMSE):", rmse, "\n")

# Create a new dataframe for actual vs predicted values
results <- data.frame(Actual = validation_data$price, Predicted = predictions)

# Create the scatter plot
ggplot(results, aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.5, color = "blue") + 
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") + 
  labs(title = "Actual vs Predicted House Prices",
       x = "Actual Prices",
       y = "Predicted Prices") +
  theme_minimal()

#a. Create a model using  a random forest on  partitioned data

# Train a random forest model on the training data
rf_model <- randomForest(price ~  bedrooms+bathrooms+total_sqft+ price_per_sqft+
                           sqft_living+renovated+waterfront,data = training_data)

# Predict on the validation data
rf_predictions <- predict(rf_model, newdata = validation_data)
# Create a new dataframe for actual vs predicted values
rf_results <- data.frame(Actual = validation_data$price, Predicted = rf_predictions)

# Create the scatter plot
ggplot(rf_results, aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.5, color = "green") + 
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") + 
  labs(title = "Actual vs Predicted House Prices (Random Forest)",
       x = "Actual Prices",
       y = "Predicted Prices") +
  theme_minimal()
# Evaluate the model
mse <- mean((validation_data$price - rf_predictions)^2)
mae <- mean(abs(validation_data$price - rf_predictions))
# Calculate residuals and total sum of squares
residuals <- validation_data$price - rf_predictions
SS_res <- sum(residuals^2)  # Sum of squares of residuals
SS_tot <- sum((validation_data$price - mean(validation_data$price))^2)
# Calculate R-squared
r_squared <- 1 - (SS_res / SS_tot)
# Print R-squared value
# Print the error measures
print(paste("R-squared:", r_squared))
print(paste("MSE:", mse))
print(paste("MAE:", mae))



# Build the decision tree model
decision_tree_model <- rpart(price ~ total_sqft+ price_per_sqft+sqft_living+renovated+waterfront,
                             data = training_data)
# Print the summary of the model
summary(decision_tree_model)
                             
# Plot the decision tree
# Plot the decision tree with expanded node sizes and customized appearance
rpart.plot(decision_tree_model, 
           main = "Decision Tree for House Price Prediction",
           cex = 1.2,                # Increase text size
           cex.main = 1.5,          # Increase title size
           box.col = "lightblue",   # Change box color
           branch.lty = 1,          # Line type for branches
           shadow.col = "gray",     # Add shadow color
           split.border.col = "darkblue")  # Border color for split labels

# Make predictions on the validation data
dt_predictions <- predict(decision_tree_model, newdata = validation_data)

# Evaluate the model
dt_mse <- mean((validation_data$price - dt_predictions)^2)
dt_mae <- mean(abs(validation_data$price - dt_predictions))


# Calculate residuals and total sum of squares
dt_residuals <- validation_data$price - dt_predictions
dt_SS_res <- sum(dt_residuals^2)  # Sum of squares of residuals
dt_SS_tot <- sum((validation_data$price - mean(validation_data$price))^2)  # Total sum of squares

# Calculate R-squared
dt_r_squared <- 1 - (dt_SS_res / dt_SS_tot)

# Print R-squared value
# Print the error measures
print(paste("Decision Tree R-squared:", dt_r_squared))
print(paste("Decision Tree MSE:", dt_mse))
print(paste("Decision Tree MAE:", dt_mae))

# Create a data frame for actual vs. predicted values
comparison_df <- data.frame(
  Actual = validation_data$price,
  Predicted = dt_predictions
)

# Create the scatter plot
ggplot(comparison_df, aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.5, color = "blue") +  # Points for actual vs predicted
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +  # Line for perfect prediction
  labs(title = "Decision Tree: Actual vs Predicted House Prices",
       x = "Actual Prices",
       y = "Predicted Prices") +
  theme_minimal() +
  xlim(0, max(comparison_df$Actual, na.rm = TRUE)) +
  ylim(0, max(comparison_df$Predicted, na.rm = TRUE))
linear_reg_rs<-max(model_results$R_squared)
#comparing the R square
print(paste("Regression",linear_reg_rs))
print(paste("Descion tree",dt_r_squared))
print(paste("Random Forest",r_squared))
#comparing the MSE
print(paste("Regression",min(model_results$MSE)))
print(paste("Descion Tree",dt_mse))
print(paste("Randon forest",mse))
