#!/usr/bin/env Rscript


#source("scripts/04-modeling_process.R")

library(tidyverse)
library(docopt)
library(creditCardTool)
source("scripts/validate_split.R")

doc <- "
Run validation checks for train-test split, normalization bounds, and duplicate rows.

Usage:
  run_validate_split.R --full_data=<full_data>

Options:
  --full_data=<full_data>   Path to the full cleaned dataset
"

# Parse command-line arguments
args <- docopt(doc)

# Load full cleaned dataset
df <- read_csv(args$full_data)

# Split the data
splits <- creditCardTool::split_data(df, 0.8)
train <- splits$train
test <- splits$test

# Convert target column to factor before normalization
train$default_payment_next_month <- as.factor(train$default_payment_next_month)
test$default_payment_next_month <- as.factor(test$default_payment_next_month)

# Normalize the training and testing data
knn_data <- creditCardTool::prepare_knn_data(train, test, target = "default_payment_next_month")
train_norm <- knn_data$train
test_norm <- knn_data$test

# Run all validations
validate_split_data(df, train, test, target_col = "default_payment_next_month")
eval_norm_outliers(train_norm, test_norm)
warn_on_duplicates(train, test)

cat("✅ All validation checks passed.\n")
