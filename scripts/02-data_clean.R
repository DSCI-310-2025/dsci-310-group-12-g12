# 02-data_clean.R

# Load required libraries
library(tidyverse)
library(caTools)  # For sample.split
library(docopt)

# Define docopt string for command-line argument parsing
doc <- "
This script reads the cleaned data from the first script and performs additional data cleaning, pre-processing,
transforming, and/or partitioning that needs to happen before exploratory data analysis or modeling takes place.

Usage:
  02-data_clean.R --file_path=<file_path> --output_path=<output_path>

Options:
  --file_path=<file_path>     Path to the cleaned input CSV file.
  --output_path=<output_path> Path and filename for saving the cleaned/processed/partitioned data.
"

# Parse command-line arguments
args <- docopt(doc)

# Load the cleaned data
df <- read.csv(args$file_path)

# 1. Remove unnecessary columns (e.g., ID)
df <- df %>% select(-ID)

# 2. Split the data into training (80%) and testing (20%) sets using simple random sampling
set.seed(123)  # For reproducibility
n <- nrow(df)
train_index <- sample(1:n, size = 0.8 * n)  # 80% for training
train_df <- df[train_index, ]
test_df <- df[-train_index, ]

# Check dimensions of training data
cat("Training data dimensions: ", dim(train_df), "\n")

# Check class distribution in the training data
cat("Class distribution in training data:\n")
print(table(train_df$default_payment_next_month) / nrow(train_df))

# Check summary statistics for missing values in the training data
cat("Summary statistics of training data:\n")
print(summary(train_df))

# Check for missing values in the training data
cat("Missing values in training data: ", sum(is.na(train_df)), "\n")

# 3. Compute the average of BILL_AMT and PAY_AMT columns to make it more organized
train_df$AVG_BILL_AMT <- rowMeans(train_df[, grep("bill_amt", names(train_df))])
train_df$AVG_PAY_AMT <- rowMeans(train_df[, grep("pay_amt", names(train_df))])

test_df$AVG_BILL_AMT <- rowMeans(test_df[, grep("BILL_AMT", names(test_df))])
test_df$AVG_PAY_AMT <- rowMeans(test_df[, grep("PAY_AMT", names(test_df))])


# 4. Remove original BILL_AMT and PAY_AMT columns to make it look clean
train_df <- train_df %>% select(-starts_with("BILL_AMT"), -starts_with("PAY_AMT"))
test_df <- test_df %>% select(-starts_with("BILL_AMT"), -starts_with("PAY_AMT"))

# 5. Rename LIMIT_BAL to CREDIT_LIMIT to make it more readable
train_df <- rename(train_df, CREDIT_LIMIT = limit_bal)
test_df <- rename(test_df, CREDIT_LIMIT = limit_bal)


# Save the processed data to the specified output path
write.csv(train_df, args$output_path, row.names = FALSE)
write.csv(test_df, gsub(".csv", "_test.csv", args$output_path), row.names = FALSE)

# Preview the first few rows of the training data
head(train_df)