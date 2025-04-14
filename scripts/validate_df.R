
#' DataFrame Validation Functions
#'
#' Validates the raw input dataframe after import, including structure, missing values, and column integrity.
#' Keep this separate from split/train-test validations.

assert_dataframe <- function(df) {
  if (!is.data.frame(df) || nrow(df) == 0) {
    stop("Input is not a valid, non-empty dataframe.")
  }
}

check_required_columns <- function(df, required_cols = c("default_payment_next_month", "CREDIT_LIMIT", "AVG_BILL_AMT", "AVG_PAY_AMT", "pay_0", "age")) {
  missing_cols <- setdiff(required_cols, colnames(df))
  if (length(missing_cols) > 0) {
    stop(paste(" Missing required columns:", paste(missing_cols, collapse = ", ")))
  }
}

check_missing_values <- function(df) {
  if (any(is.na(df))) {
    stop("Dataset contains missing values.")
  }
}

check_binary_target <- function(df, target_col = "default_payment_next_month") {
  if (!all(unique(df[[target_col]]) %in% c(0, 1))) {
    stop(paste("Target variable '", target_col, "' contains non-binary values."))
  }
}

check_class_balance <- function(df, target_col = "default_payment_next_month", min_prop = 0.1) {
  class_dist <- prop.table(table(df[[target_col]]))
  if (any(class_dist < min_prop)) {
    warning("Class imbalance: one class < 10% of total.")
  }
}

check_duplicates <- function(df) {
  if (any(duplicated(df))) {
    warning("Duplicate rows found in the dataset.")
  }
  cat("No duplicate rows.
")
}

