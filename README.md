# Credit Card Default Prediction

## Contributors/Authors
- Daniel Park
- Yiting Sun
- Jellia Ma
- Han Qin


## Project Summary
This project aims to predict whether a customer will default on a credit card payment based on various financial and demographic features. The dataset includes information about customers’ credit history, payment status, demographic data, and other relevant factors. We use machine learning models, specifically K-Nearest Neighbors (KNN), to predict the likelihood of a customer defaulting.

We built a modular R package — [`creditCardTool`](https://github.com/DSCI-310-2025/creditCardTool) — to handle preprocessing, visualization, and modeling tasks. This package is now used throughout the analysis.
We use version 0.0.0.9000 of creditCardTool, installed via pak.

## Data Description
The dataset used in this project is from the **UCI Machine Learning Repository** and is referred to as the "Default of Credit Card Clients Dataset." It contains information about credit card clients in Taiwan from April to September 2005.

- [Kaggle - Default of Credit Card Clients Dataset](https://www.kaggle.com/datasets/uciml/default-of-credit-card-clients-dataset)

## How to Run the Data Analysis

You can reproduce the entire analysis using Docker or `make`.

---

### Option 1: Reproduce with Docker (Recommended)

Ensure Docker Desktop (v3.3.0 or later) is installed and running.

```bash
# Clone this repository
git clone https://github.com/DSCI-310-2025/dsci-310-group-12-g12.git
cd dsci-310-group-12-g12

# Build the container and run analysis
docker build -t credit-default .
docker run --rm -v $PWD:/home/rstudio/project credit-default make
```

This will render analysis.qmd and output analysis.html.

### Option 2: Run Locally
1.	Make sure you have **R**, **Quarto**, and **pak** installed
2.	Install dependencies with:

```r
pak::pak("DSCI-310-2025/creditCardTool")
```
3.	Run the full analysis:

```bash
make
```

4.	Or manually render:
```r
quarto::quarto_render("analysis.qmd")
```
Then open analysis.html.

## Data Validation

We implemented validation checks to ensure the integrity, quality, and robustness of our dataset and model inputs.
You can validate the cleaned dataset using the script in the `scripts/` folder.


### 1. Raw Data Validation

Validate the cleaned dataset for structure, missing values, class imbalance, and duplicates using:

```bash
Rscript scripts/run_validate_df.R --file_path=data/clean/UCI_Credit_Card_processed.csv
```

### 2. Split & Normalization Validation

Validate that the train-test split, normalization, and duplicate handling are correct using:

```bash
Rscript scripts/run_validate_split.R --full_data=data/clean/UCI_Credit_Card_processed.csv
```

#### Optional: Use Makefile

```bash
make validate
```

## List of Dependencies
The following dependencies are required to run the project:

- Docker
- Git 
- R packages: 
    - `creditCardTool`
    - `tidyverse`
    - `docopt`
    - `ggplot2`
    - `caret`
    - `class`
    - `knitr`
    - `testthat`


## License

This repository contains two types of licenses:

- **Code assets** (e.g., R scripts, Quarto files, functions in the `R/` folder):  
  Licensed under the [MIT License](./LICENSE.md).

- **Non-code assets** (e.g., report text, figures, analysis results, data documentation):  
  Licensed under the [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

This dual-licensing ensures that code can be reused freely with attribution, and non-code materials can be shared and adapted with proper credit.


















