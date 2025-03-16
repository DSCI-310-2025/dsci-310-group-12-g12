.PHONY: all clean report

all:
	make clean
	make report

# Data cleaning
data/clean/UCI_Credit_Card_clean.csv: scripts/02-data_clean.R data/raw/UCI_Credit_Card.csv
	Rscript scripts/02-data_clean.R --file_path=data/raw/UCI_Credit_Card.csv --output_path=data/clean/UCI_Credit_Card_clean.csv
	
# EDA
results/eda_default_payment_distribution.png results/eda_scatter_facet_plots.png: scripts/03-eda.R data/clean/UCI_Credit_Card_clean.csv
	Rscript scripts/03-eda.R data/clean/UCI_Credit_Card_clean.csv results/eda_default_payment_distribution.png results/eda_scatter_facet_plots.png

# Modeling
results/modeling_confusion_matrix.csv results/modeling_k_value_selection.png results/modeling_performance_metrics.txt: scripts/04-modeling_process.R data/clean/UCI_Credit_Card_clean.csv
	Rscript scripts/04-modeling_process.R data/clean/UCI_Credit_Card_clean.csv results/modeling_confusion_matrix.csv results/modeling_k_value_selection.png results/modeling_performance_metrics.txt

# Generate the final report
analysis.html: analysis.qmd results/eda_default_payment_distribution.png results/eda_scatter_facet_plots.png results/modeling_confusion_matrix.csv results/modeling_k_value_selection.png results/modeling_performance_metrics.txt
	quarto render analysis.qmd --to html

report:
	make analysis.html

# Clean target
clean:
	rm -f results/*
	rm -f data/clean/UCI_Credit_Card_clean.csv
	rm -f analysis.html