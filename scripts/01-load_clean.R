# 01-load_clean.R

library(tidyverse)
library(janitor)
library(docopt)

# Define the docstring for docopt
doc <- "This script downloads
Usage: 01-load_clean.R --file_path=<file_path> --output_path=<output_path>

Options:
--file_path=<file_path>: Path to the input CSV file.
--output_path=<output_path>: Path and filename for saving the cleaned dataset.
"

# Get arguments from docopt
args <- docopt(doc)

# Load the dataset
data <- read_csv(args$file_path)

# Clean the data (you can continue the rest of your script logic here)
data <- janitor::clean_names(data)

# Write the cleaned data to the output path
write_csv(data, args$output_path)
