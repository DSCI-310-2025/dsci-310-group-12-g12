FROM rocker/rstudio:4.4.2

# Install necessary R packages
RUN R -e "install.packages(c('renv', 'remotes', 'reticulate', 'tidyverse'), repos = 'https://cran.rstudio.com/')"

# Install specific version of tidyverse (if needed)
RUN R -e "remotes::install_version('tidyverse', version = '2.0.0', repos = 'https://cran.rstudio.com/')"

# Install pandas for reticulate
RUN R -e "reticulate::py_install('pandas', envname = 'r-reticulate', pip = TRUE)"

# Copy documentation files
COPY README.md /home/rstudio/README.md
COPY CODE_OF_CONDUCT.md /home/rstudio/CODE_OF_CONDUCT.md 
COPY CONTRIBUTING.md /home/rstudio/CONTRIBUTING.md 
COPY LICENSE.md /home/rstudio/LICENSE.md

# Copy data directory
COPY data/ /home/rstudio/data/
