# 03_eda.R

# Load required libraries
library(tidyverse)
library(docopt)
library(ggplot2)

# Define docstring for command-line argument parsing
doc <- "
This script performs exploratory data analysis (EDA) and generates visualizations
on the given dataset and saves them to files.

Usage:
  03_exploratory_analysis.R --file_path=<file_path> --output_path_prefix=<output_path_prefix>

Options:
  --file_path=<file_path>            Path to the cleaned data CSV file.
  --output_path_prefix=<output_path_prefix>  Prefix for saving the output files (e.g., results/this_eda).
"

# Parse command-line arguments
args <- docopt(doc)

# Load the cleaned data from the specified file path
df <- read_csv(args$file_path)

# Convert the target variable to a factor for better visualization
df$default_payment_next_month <- as.factor(df$default_payment_next_month)

# Create a bar plot for the distribution of the target variable (default_payment_next_mont)
target_dis <- ggplot(df, aes(x = default_payment_next_month)) +
  geom_bar(fill = "steelblue") +
  labs(title = "Distribution of Default Payments", x = "Default (0 = No, 1 = Yes)", y = "Count") +
  theme_minimal()

# Save the target distribution plot to file
target_dis_file <- paste0(args$output_path_prefix, "_default_payment_distribution.png")
ggsave(target_dis_file, plot = target_dis, width = 10, height = 6)

# Reshape the dataset for facet grid visualization
df_long <- df %>% 
  pivot_longer(cols = c(CREDIT_LIMIT, age, AVG_BILL_AMT, AVG_PAY_AMT, pay_0),
               names_to = "Feature", values_to = "Value")

# Scatter plots using facet grid with color for default class and trend lines
scatter_plot <- ggplot(df_long, aes(x = Value, y = default_payment_next_month, color = default_payment_next_month)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  facet_wrap(~ Feature, scales = "free_x") +
  labs(title = "Scatter Plots of Numeric Features vs Default Payment",
       x = "Feature Value", y = "Default Payment (0 = No, 1 = Yes)",
       color = "Default Status")  +
  theme(strip.text = element_text(size = 14),   
        axis.text = element_text(size = 12),    
        axis.title = element_text(size = 14),   
        legend.text = element_text(size = 12),  
        legend.title = element_text(size = 14))

# Save the scatter plot with facets to file
scatter_plot_file <- paste0(args$output_path_prefix, "_scatter_facet_plots.png")
ggsave(scatter_plot_file, plot = scatter_plot, width = 20, height = 15)

# Display the plots
print(target_dis)
print(scatter_plot)
