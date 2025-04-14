library(tidyverse)
library(janitor)
library(docopt)

library(creditCardTool)

doc <- "Usage: 01-load_clean.R --file_path=<file_path> --output_path=<output_path>"

args <- docopt(doc)

data <- read_csv(args$file_path) %>% clean_column_names()

write_csv(data, args$output_path)
