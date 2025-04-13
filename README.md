# Credit Card Default Prediction

## Contributors/Authors
- Daniel Park
- Yiting Sun
- Jellia Ma
- Han Qin


## Project Summary
This project aims to predict whether a customer will default on a credit card payment based on various financial and demographic features. The dataset used includes information about customers’ credit history, payment status, demographic data, and other relevant factors. We will use machine learning models to predict the likelihood of a customer defaulting.

The goal is to build a reliable model that can classify whether a customer is at risk of default, which can help financial institutions make more informed lending decisions.

## Data Description
The data used to build our model contains customer information, including payment history, demographic details, and financial behavior. The dataset was collected from the **UCI Machine Learning Repository** and is specifically referred to as the "Default of Credit Card Clients Dataset." This dataset contains information about credit card clients in Taiwan and is available for download at the following URL:

- [Kaggle - Default of Credit Card Clients Dataset](https://www.kaggle.com/datasets/uciml/default-of-credit-card-clients-dataset)


## How to Run the Data Analysis

### 1. Prerequisites

Ensure Docker Desktop (version 3.3.0 or later) is installed and is able to run properly.

### 2. Clone the Repository

Clone the repository and navigate into the project directory:
```bash
git clone https://github.com/DSCI-310-2025/dsci-310-group-12-g12.git
cd dsci-310-group-12-g12
```

### 3. Set up environment
Run the docker container
 

`docker-compose up`

### 4. Access RStudio and Run the Analysis

Once the services are up, open your web browser and navigate to [http://localhost:8787](http://localhost:8787).

### 5. Makefile Command

You can render the analysis in terminal:

`quarto render("analysis.qmd")`

After rendering:

`open analysis.html`


## List of Dependencies
The following dependencies are required to run the project:

- Docker
- Git 
- R packages: 
    - `tidyverse`
    - `janitor`
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


















