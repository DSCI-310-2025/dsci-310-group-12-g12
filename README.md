# Credit Card Default Prediction

## Contributors/Authors
- Daniel Park
- Yiting Sun
- Jellia Ma
- Han Qin

## Table of Contents

- [Project Summary](#project-summary)
- [Data Description](#data-description)
- [How to Run the Data Analysis](#how-to-run-the-data-analysis)
  - [Running Outside Docker (Optional)](#running-outside-docker-optional)
  - [Docker Instructions (Recommended)](#docker-instructions-recommended)
- [Dependencies](#dependencies)
- [License](#license)


## Project Summary
This project aims to predict whether a customer will default on a credit card payment based on various financial and demographic features. The dataset used includes information about customers’ credit history, payment status, demographic data, and other relevant factors. We will use machine learning models to predict the likelihood of a customer defaulting.

The goal is to build a reliable model that can classify whether a customer is at risk of default, which can help financial institutions make more informed lending decisions.

## Data Description
The data used to build our model contains customer information, including payment history, demographic details, and financial behavior. The dataset was collected from the **UCI Machine Learning Repository** and is specifically referred to as the "Default of Credit Card Clients Dataset." This dataset contains information about credit card clients in Taiwan and is available for download at the following URL:

- [Kaggle - Default of Credit Card Clients Dataset](https://www.kaggle.com/datasets/uciml/default-of-credit-card-clients-dataset)


## Usage

### Reproducibility and Execution

We use a Docker container image to ensure a consistent and reproducible computational environment for this project. There are two main ways to run the project:

1. **Non-interactive execution**: This method is ideal for those who wish to reproduce the results of our analysis. It allows you to run the project in an automated, non-interactive manner.
   
2. **Interactive execution**: This method is ideal for project developers and collaborators who want to run, edit, and explore the project interactively in Jupyter Lab.

## How to Run the Data Analysis

If you are using Docker (recommended), follow the steps below.  
If you are grading or running the analysis **outside of Docker**, you need to install R packages manually as shown below.

### 🔧 Running Outside Docker (Optional)

If you're running the analysis manually (e.g. from RStudio or terminal), install the required R packages:

```r
install.packages(c(
  "tidyverse", "readr", "dplyr", "ggplot2", "caret",
  "e1071", "caTools", "class", "knitr", "testthat",
  "janitor", "tidyr"
))

1. **Install Docker**

   If Docker is not installed, follow the installation instructions for your operating system:

   - [Install Docker on Windows](https://docs.docker.com/docker-for-windows/install/)
   - [Install Docker on macOS](https://docs.docker.com/docker-for-mac/install/)
   - [Install Docker on Linux](https://docs.docker.com/engine/install/)


2. **Run the Project with Docker Compose**

   Once Docker and Docker Compose are installed, follow these steps:

   - Start the services defined in the `docker-compose.yml` file by running the following command:
     ```bash
     docker-compose up
     ```
     This will start the Docker container with RStudio and make it accessible via `localhost:8787`.

4. **Access RStudio and Run the Analysis**

   Once the services are up, open your web browser and navigate to [http://localhost:8787](http://localhost:8787).

   - Log in with the following credentials:
     - Username: `rstudio`
     - Password: `password` (configured in the `docker-compose.yml` file)
   
   - After logging in, open the `dsci310_group12` folder inside RStudio, and navigate to the `analysis.ipynb` notebook.

   - Open the notebook and run the cells to execute the analysis for predicting credit card defaults.

## Dependencies
The following dependencies are required to run the project:

- Docker: For containerization and creating a reproducible environment.
- R: Programming language used for analysis and modeling.

| Package     | Version     | Description                                   |
|-------------|-------------|-----------------------------------------------|
| tidyverse   | Latest at time of container build | Core data wrangling and plotting packages |
| purrr       | Latest      | Functional programming tools                  |
| knitr       | Latest      | Report generation via R Markdown / Quarto     |
| GGally      | 2.2.1       | Extension to ggplot2 for pairwise plots       |
| tidymodels  | 1.3.0       | Unified modeling framework                    |
| leaps       | 3.1         | Subset selection for regression               |
| mltools     | 0.1.0       | Machine learning helper tools                 |
| janitor     | Latest      | Clean column names and tabulation helpers     |
| caTools     | Latest      | Splitting data sets and ROC AUC tools         |
| class       | Latest      | k-Nearest Neighbors classifier                |
| caret       | Latest      | Classification and regression training        |
| e1071       | Latest      | Misc ML algorithms (used by caret)            |
| testthat    | Latest      | Unit testing framework                        |
- RStudio: IDE used to interact with the R environment.
- renv: For managing R dependencies and project environments.

## License

This repository contains two types of licenses:

- **Code assets** (e.g., R scripts, Quarto files, functions in the `R/` folder):  
  Licensed under the [MIT License](./LICENSE.md).

- **Non-code assets** (e.g., report text, figures, analysis results, data documentation):  
  Licensed under the [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

This dual-licensing ensures that code can be reused freely with attribution, and non-code materials can be shared and adapted with proper credit.


















