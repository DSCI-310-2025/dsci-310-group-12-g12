library(tidyverse)
library(docopt)

# Load dataset from argument
file_path <- args$file_path
data <- read_csv(file_path)


# 1. Check if the data is a data frame and non-empty
if (!is.data.frame(data) || nrow(data) == 0) {
  stop("Input data is not a valid non-empty data frame.")
}

# 2. Check for required columns
required_cols <- c("default_payment_next_month", "CREDIT_LIMIT", "AVG_BILL_AMT", "AVG_PAY_AMT", "pay_0", "age")
missing_cols <- setdiff(required_cols, colnames(data))
if (length(missing_cols) > 0) {
  stop(paste("Missing required columns:", paste(missing_cols, collapse = ", ")))
}

# 3. Check for missing values
if (any(is.na(data))) {
  stop("Dataset contains missing values. Please handle them before proceeding.")
}

# 4. Check that target variable is binary (0 or 1)
if (!all(unique(data$default_payment_next_month) %in% c(0, 1))) {
  stop("Target variable 'default_payment_next_month' contains values other than 0 or 1.")
}

# 5. Validate class balance (no extreme imbalance)
class_dist <- prop.table(table(data$default_payment_next_month))
if (any(class_dist < 0.1)) {
  warning("Class imbalance detected. One class has less than 10% representation.")
}

# 6. Check that train-test split is valid
if (nrow(train_df) + nrow(test_df) != nrow(data)) {
  stop("Train/test row counts do not add up to total data.")
}
if (!identical(colnames(train_df), colnames(test_df))) {
  stop("Column names of train and test sets do not match.")
}

# 7. Validate normalized feature values are in expected range
combined_norm <- rbind(train_df_norm, test_df_norm)
if (any(combined_norm < -0.1 | combined_norm > 1.1, na.rm = TRUE)) {
  stop("Detected out-of-bound values in normalized features.")
}

# 8. Check for duplicate rows
if (any(duplicated(data))) {
  warning("Duplicate rows found in the dataset.")
}

cat("All data validation checks passed.\n")
