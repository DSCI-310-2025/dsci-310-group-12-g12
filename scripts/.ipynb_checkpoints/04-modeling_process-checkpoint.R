# 04_modeling_process.R

# Load required libraries
library(tidyverse)
library(caret)
library(class)  # For KNN algorithm
library(docopt)
library(ggplot2)

# Define docstring for command-line argument parsing
doc <- "
This script performs modeling on the provided dataset and generates 
summary results, which are written to both figures and tables.

Usage:
  04_modeling.R --file_path=<file_path> --output_path_prefix=<output_path_prefix>

Options:
  --file_path=<file_path>            Path to the cleaned data CSV file.
  --output_path_prefix=<output_path_prefix>  Path and filename prefix for saving the figure(s) and table(s).
"

# Parse arguments
args <- docopt(doc)

# Load the data from the second script (cleaned data)
data <- read_csv(args$file_path)

# Separate features and target variable
train_df <- data[1:round(0.8 * nrow(data)), ]  # Train data: 80% of data
test_df <- data[(round(0.8 * nrow(data)) + 1):nrow(data), ]  # Test data: 20% of data

# Define normalization function
normalize <- function(x) { (x - min(x)) / (max(x) - min(x)) }

# Select only numeric columns for normalization (excluding the target variable)
numeric_columns <- sapply(train_df, is.numeric)

# Extract target variable BEFORE normalization
train_labels <- as.factor(train_df$default_payment_next_month) 
test_labels <- as.factor(test_df$default_payment_next_month)    

# Apply normalization only to numeric columns (excluding the target variable)
train_df_norm <- as.data.frame(lapply(train_df[, numeric_columns], normalize))
test_df_norm <- as.data.frame(lapply(test_df[, numeric_columns], normalize))

# Remove the target variable from the normalized data (it should NOT be included in knn predictors)
train_df_norm <- train_df_norm[, colnames(train_df_norm) != "default_payment_next_month"]
test_df_norm <- test_df_norm[, colnames(test_df_norm) != "default_payment_next_month"]

# Try different k values and store accuracy results
k_values <- seq(1, 20, by = 1)  # Testing k from 1 to 20
accuracy_results <- data.frame(k = k_values, accuracy = NA)

for (i in 1:length(k_values)) {
  knn_pred <- knn(train = train_df_norm, test = test_df_norm, cl = train_labels, k = k_values[i])
  
 # Calculate accuracy
  accuracy_results$accuracy[i] <- sum(knn_pred == test_labels) / length(test_labels)
}

# Find the best k (highest accuracy)
best_k <- accuracy_results$k[which.max(accuracy_results$accuracy)]
cat("Best k value:", best_k, "\n")

# Plot accuracy vs. k to visualize the best k choice
ggplot(accuracy_results, aes(x = k, y = accuracy)) +
  geom_line(color = "blue") +
  geom_point(size = 3, color = "red") +
  labs(title = "K-Value Selection for KNN",
       x = "Number of Neighbors (k)",
       y = "Accuracy") +
  theme_minimal()

# Save the plot to a file
ggsave(paste0(args$output_path_prefix, "_k_value_selection.png"))


# Train KNN Model with the best k
knn_model <- knn(train = train_df_norm, test = test_df_norm, cl = train_labels, k = best_k)

# Evaluate Model Performance
conf_matrix <- table(Predicted = knn_model, Actual = test_labels)
print(conf_matrix)

# Compute Accuracy, Precision, and Confusion Matrix
confusion <- confusionMatrix(as.factor(knn_model), as.factor(test_labels))
print(confusion)

# Save the confusion matrix to a CSV file
write.csv(as.data.frame(conf_matrix), paste0(args$output_path_prefix, "_confusion_matrix.csv"))

# Save the performance metrics (accuracy, precision, recall, F1) to a text file
write.table(confusion$overall, paste0(args$output_path_prefix, "_performance_metrics.txt"), sep = "\t")
