## R Programming Language
## Predicted Churn and find accuracy, recall, precission and F1-score
## Used churn.csv
library(tidyverse)

# Import data churn.csv
churn <- read.csv("churn.csv")

# Explore Dataset
glimpse(churn)
sum(is.na(churn))

churn %>%
  group_by(churn) %>%
  count()

# Convert Data to Factor
churn$churn <- factor(churn$churn)

# Split Data (Skip)

# Train Data
Log_model <- glm(churn ~ ., data = churn, family = "binomial")

# Test Data
churn$churn_prob <- predict(Log_model, type = "response")
churn$churn_preb <- if_else(churn$churn_prob >= 0.5, "Yes", "No")
mean(churn$churn_preb == churn$churn)

#Find accuracy, recall, precission and F1-score by Confusion Matrix
churn_table <- table(churn$churn, churn$churn_preb, dnn=c("Actual", "Predicted"))

accuracy <- (churn_table[1,1]+churn_table[2,2])/ sum(churn_table)
recall <- churn_table[2,1]/ sum(churn_table[2, ])
precission <- churn_table[2,2]/ sum(churn_table[,2])
F1 <- 2*((precission*recall)/ (precission+recall))
