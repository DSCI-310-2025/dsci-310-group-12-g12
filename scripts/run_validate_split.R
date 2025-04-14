#!/usr/bin/env Rscript

library(tidyverse)
library(docopt)
source("scripts/validate_split.R")

doc <- "
Run validation checks for train-test split, normalization bounds, and duplicate rows.

Usage:
  run_validate_split.R --df=<df> --train=<train> --test=<test> --train_norm=<train_norm> --test_norm=<test_norm>

Options:
  --df=<df>                 Path to full dataset (cleaned)
  --train=<train>           Path to training set
  --test=<test>             Path to test set
  --train_norm=<train_norm> Path to normalized training set
  --test_norm=<test_norm>   Path to normalized test set
"

args <- docopt(doc)

# Load all datasets
df <- read_csv(args$df)
train <- read_csv(args$train)
test <- read_csv(args$test)
train_norm <- read_csv(args$train_norm)
test_norm <- read_csv(args$test_norm)

# Run all validations
validate_split_data(df, train, test, target_col = "default_payment_next_month")
eval_norm_outliers(train_norm, test_norm)
warn_on_duplicates(train, test)

cat("All validation checks passed.\n")

