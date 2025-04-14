FROM rocker/rstudio:4.4.2

# Install renv and remotes (already included, keep these)
RUN Rscript -e "install.packages('renv', repos = 'https://cloud.r-project.org')"
RUN Rscript -e "install.packages('remotes', repos = 'https://cloud.r-project.org')"

# Install pak
RUN Rscript -e 'install.packages("pak")'

# Install dependencies manually
RUN Rscript -e 'install.packages(c("ggplot2", "tidyr", "dplyr", "janitor", "caret", "class", "testthat", "tibble", "utils"))'

# Then install your GitHub package (now all deps are already present)
RUN Rscript -e 'pak::pak("DSCI-310-2025/creditCardTool")'

# Install specific version of dplyr (if really needed)
RUN Rscript -e "remotes::install_version('dplyr', version = '1.0.10', repos = 'https://cloud.r-project.org')"

# Set working directory inside the container
WORKDIR /home/rstudio

# Copy the entire project into the container
COPY . /home/rstudio