
#!/usr/bin/env Rscript

library(tidyverse)
library(docopt)
source("scripts/validate_df.R")

doc <- "
Data Validation Script

Usage:
  run_validate_df.R --file_path=<path>
Options:
  --file_path=<path>   Path to the cleaned input .csv file.
"

args <- docopt(doc)
df <- read_csv(args$file_path)

# Run validations
assert_dataframe(df)
check_required_columns(df)
check_missing_values(df)
check_binary_target(df)
check_class_balance(df)
check_duplicates(df)

cat(" All raw data validations passed.\n")
