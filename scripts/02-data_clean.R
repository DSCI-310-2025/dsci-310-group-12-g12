library(tidyverse)
library(docopt)
source("R/clean_data.R")

doc <- "Usage: 02-data_clean.R --file_path=<file_path> --output_path=<output_path>"

args <- docopt(doc)

df <- read_csv(args$file_path) %>% clean_column_names()

df <- df %>% select(-id)  # Remove ID column

split <- split_data(df)
train_df <- compute_avg_amounts(split$train)
test_df <- compute_avg_amounts(split$test)

train_df <- rename(train_df, CREDIT_LIMIT = limit_bal)
test_df <- rename(test_df, CREDIT_LIMIT = limit_bal)

write_csv(train_df, args$output_path)
write_csv(test_df, gsub(".csv", "_test.csv", args$output_path))
