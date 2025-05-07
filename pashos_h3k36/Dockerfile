# Dockerfile for phashos_h3k36
# Pashos, A.R.S., Meyer, A.R., Bussey-Sutton, C. et al. H3K36 methylation regulates cell plasticity and regeneration in the intestinal epithelium. Nat Cell Biol 27, 202–217 (2025). https://doi.org/10.1038/s41556-024-01580-y


# Data Analysis
# ...
# Analysis of raw scRNA-seq data was performed using CellRanger (v3.0.1) to align, filter 
# and count reads per cell. Seurat (v4.3.0) was used for downstream analysis. To remove 
# low-quality cells and potential doublets, we filtered out cells with more than 5% reads 
# mapping to mitochondrial genes and cells expressing less than 200 genes or more than 
# 4,000 genes. We used 50 canonical correlation analysis dimensions throughout the 
# integration, 100 neighbours, 0.75 minimum distance and a resolution of 0.3 for 
# unsupervised clustering. The representative genes for each cluster of cells were identified 
# using FindConservedMarkers() function. To define mature and immature Paneth cell 
# clusters, we used gene signatures defined previously50. The plots were generated in R 
# using the ‘ggplot2’ package.

# Statistics and reproducibility
# Statistical tests are described in the corresponding figure legends. Statistical analyses 
# were carried out using R v4.4.1 or JMP Pro v16.0.0. The data distribution was presumed to 
# be normal, though this was not formally tested. The sample size was not statistically 
# predetermined, but our sample sizes are similar to those reported in previous 
# publications32, and no data were excluded from analyses in this paper. The investigators 
# were not blinded to experimental samples during outcome assessment unless otherwise 
# indicated. The experiments in the following figures were performed the indicated 
# number of times: Fig. 2b, 4 times; Extended Data Fig. 5a, 8 times; Extended Data Fig. 5b, 
# two mice for no dox conditions and three mice for all other conditions; Extended Data 
# Fig. 7b, 6 times; Extended Data Fig. 9a, 5 times; Extended Data Fig. 9b, 13 times; Extended 
# Data Fig. 10d, 3 times.

# Versions (for single cell only R, CellRanger, and Seurat are needed)
# R v4.4.1
# JMP Pro v16.0.0
# CellRanger v3.0.1
# Seurat v.4.3.0
# DiffBlind v3.6.5
# nf-core/rnaseq pipeline v3.8.1
# DEseq2 v1.26.0
# fgsea v1.22.0


# R v4.4.1
FROM rocker/r-ver:4.4.1
#FROM r-base:4.4.1

RUN apt update && apt install -y --no-install-recommends \
    software-properties-common \
    dirmngr \
    gpg \
    curl \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    make \
    cmake \
    gfortran \
    libxt-dev \
    liblapack-dev \
    libblas-dev \
    sudo \
    wget \
    libzmq3-dev \
    libglpk40 \
    libglpk-dev

# Install system and Python packages
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv nano curl && \
    python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip jupyterlab

ENV PATH="/opt/venv/bin:$PATH"

# R libraries
RUN R -e "install.packages(\"IRkernel\")" \
    R -e "IRkernel::installspec(user = FALSE)"

RUN R -e "install.packages( \
    c(\"BiocManager\", \
    \"devtools\", \
    \"dplyr\", \
    \"ggplot2\", \
    \"tibble\", \
    \"gridExtra\", \
    \"data.table\", \
    \"future\", \
    \"cowplot\", \
    \"IRkernel\", \
    \"remotes\" \
    ))"

RUN R -e "BiocManager::install(\"tidyverse\")"

# Seurat v.4.3.0
# SeuratObjec installed 2 times due to unwanted automatic update
RUN R -e "remotes::install_version(\"SeuratObject\", version = \"4.1.4\")" \
    R -e "remotes::install_version(\"Seurat\", version = \"4.3.0\")" \
    R -e "remotes::install_version(\"SeuratObject\", version = \"4.1.4\")" \
    R -e "devtools::install_github('immunogenomics/presto')"

#

CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --ServerApp.allow_origin='*' --ServerApp.token='' #last one disables the token
