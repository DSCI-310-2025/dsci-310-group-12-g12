library(testthat)

# Test normalize()
test_that("normalize correctly scales values between 0 and 1", {
  x <- c(10, 20, 30)
  result <- normalize(x)
  expect_true(all(result >= 0 & result <= 1))
  expect_equal(result[1], 0)
  expect_equal(result[3], 1)
})

test_that("normalize works with constant vector", {
  x <- rep(5, 5)
  result <- normalize(x)
  expect_true(all(is.nan(result)))  # (5-5)/(5-5) = NaN
})

# Test split_dataset()
test_that("split_dataset returns train and test sets of correct sizes", {
  df <- data.frame(x = 1:100, y = rnorm(100))
  splits <- split_dataset(df)

  expect_named(splits, c("train", "test"))
  expect_equal(nrow(splits$train), 80)
  expect_equal(nrow(splits$test), 20)
})

# Test prepare_knn_data()
test_that("prepare_knn_data returns normalized data and label vectors", {
  df <- data.frame(
    default_payment_next_month = sample(0:1, 100, replace = TRUE),
    LIMIT_BAL = runif(100, 10000, 500000),
    AGE = sample(20:60, 100, replace = TRUE)
  )

  splits <- split_dataset(df)
  knn_data <- prepare_knn_data(splits$train, splits$test)

  expect_named(knn_data, c("train", "test", "train_labels", "test_labels"))
  expect_true(all(knn_data$train >= 0 & knn_data$train <= 1))
  expect_equal(length(knn_data$train_labels), nrow(knn_data$train))
})

test_that("prepare_knn_data throws error if target column is missing", {
  df <- data.frame(LIMIT_BAL = runif(10), AGE = runif(10))
  expect_error(
    prepare_knn_data(df, df),
    regexp = "subscript out of bounds"
  )
})

# Test evaluate_k_values()
test_that("evaluate_k_values returns correct structure and accuracy values", {
  df <- data.frame(
    default_payment_next_month = sample(0:1, 50, replace = TRUE),
    LIMIT_BAL = runif(50, 10000, 500000),
    AGE = sample(20:60, 50, replace = TRUE)
  )

  splits <- split_dataset(df)
  knn_data <- prepare_knn_data(splits$train, splits$test)
  acc_df <- evaluate_k_values(knn_data$train, knn_data$test, knn_data$train_labels, knn_data$test_labels, k_values = 1:5)

  expect_s3_class(acc_df, "data.frame")
  expect_named(acc_df, c("k", "accuracy"))
  expect_equal(nrow(acc_df), 5)
  expect_true(all(acc_df$accuracy >= 0 & acc_df$accuracy <= 1))
})

# Test save_accuracy_plot()
test_that("save_accuracy_plot creates a PNG file", {
  tmp <- tempfile(fileext = ".png")
  df <- data.frame(k = 1:3, accuracy = c(0.8, 0.85, 0.9))
  save_accuracy_plot(df, tmp)
  expect_true(file.exists(tmp))
  unlink(tmp)
})

# Test save_model_outputs()
test_that("save_model_outputs creates confusion matrix and metrics file", {
  tmp_prefix <- tempfile()
  actual <- factor(sample(0:1, 50, replace = TRUE))
  predicted <- actual
  save_model_outputs(predicted, actual, tmp_prefix)

  expect_true(file.exists(paste0(tmp_prefix, "_confusion_matrix.csv")))
  expect_true(file.exists(paste0(tmp_prefix, "_performance_metrics.txt")))

  unlink(paste0(tmp_prefix, "_confusion_matrix.csv"))
  unlink(paste0(tmp_prefix, "_performance_metrics.txt"))
})
