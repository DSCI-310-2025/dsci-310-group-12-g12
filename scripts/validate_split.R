
#' Split and Normalization Validation Functions
#'
#' Validates train/test split integrity and data normalization properties.

validate_split_data <- function(df, train, test, target_col = NULL) {
  stopifnot(is.data.frame(train), is.data.frame(test))

  if (nrow(train) <= 0) stop(" Train set is empty.")
  if (nrow(test) <= 0) stop(" Test set is empty.")
  if ((nrow(train) + nrow(test)) != nrow(df)) stop(" Train + Test row counts ≠ original data.")
  if (!identical(colnames(train), colnames(test))) stop(" Column mismatch between train and test.")

  if (!is.null(target_col)) {
    cat("Class Distribution:
")
    cat("- Original:
"); print(prop.table(table(df[[target_col]])))
    cat("- Train:
");    print(prop.table(table(train[[target_col]])))
    cat("- Test:
");     print(prop.table(table(test[[target_col]])))
  }

  cat("Split validation passed.
")
}

eval_norm_outliers <- function(train_norm, test_norm, lower = -0.1, upper = 1.1) {
  stopifnot(is.data.frame(train_norm), is.data.frame(test_norm))
  combined <- rbind(train_norm, test_norm)
  outlier_mask <- combined < lower | combined > upper
  outlier_counts <- colSums(outlier_mask, na.rm = TRUE)
  total_outliers <- sum(outlier_counts)

  if (total_outliers > 0) {
    print(outlier_counts[outlier_counts > 0])
    stop(paste(" Detected", total_outliers, "out-of-bound normalized values."))
  }

  cat(" Normalized values are within range.
")
}

eval_factor_levels <- function(train_labels, test_labels, min_count = 5) {
  if (!is.factor(train_labels) || !is.factor(test_labels)) {
    stop(" Both train/test labels must be factors.")
  }

  if (!setequal(levels(train_labels), levels(test_labels))) {
    stop(" Factor levels mismatch between train and test.")
  }

  label_counts <- table(train_labels)
  low_support <- label_counts[label_counts < min_count]
  if (length(low_support) > 0) {
    warning("Low-support classes in training data:")
    print(low_support)
  }

  cat("Factor level validation passed.
")
}

warn_on_duplicates <- function(train, test) {
  dup_train <- any(duplicated(train))
  dup_test  <- any(duplicated(test))

  if (dup_train || dup_test) {
    warning(" Duplicates detected:")
    if (dup_train) cat("  - In training set
")
    if (dup_test)  cat("  - In test set
")
  } else {
    cat(" No duplicates in train/test.
")
  }
}
