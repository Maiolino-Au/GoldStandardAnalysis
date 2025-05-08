# Dockerfile for cui_comp_char
# Cui, X., Yang, H., Cai, C. et al. Comparative characterization of human accelerated regions in neurons. Nature 640, 991–999 (2025). https://doi.org/10.1038/s41586-025-08622-x

# Single-cell RNA-seq
# The iPS cell-induced excitatory neurons were dissociated using Accutase for 20 min. The reaction was neutralized with mTeSR Plus medium, and the cells were then centrifuged at 1,000 rpm for 5 min. 
# The non-viable cells were removed using the Dead Cell Removal Kit (130-090-101, Miltenyi Biotec). The pelleted cells were resuspended in cell suspension buffer and processed according to the 
# manufacturer’s recommendations (Fluent BioSciences). In brief, approximately 20,000 cells were transferred into pre-templated instant partitions (PIPs) for mRNA capture. 
# The integrity and quality of the PIPs/cell emulsions were visually inspected to ensure they met the manufacturer’s standards. mRNA isolation, synthesis of complementary DNA (cDNA), 
# amplification of cDNA, library preparation, library pooling and sequencing were all performed with the PIPseq T2 3′ Single Cell Sequencing Kit. The sequencing of the prepared cDNA libraries was 
# conducted on the NovaSeq 6000 system, utilizing paired-end 150-bp reads. Sequencing data were then aligned, and a gene expression matrix was generated for each cell using the software 
# PIPseeker (Fluent BioSciences) with the hg38 or panTro5 reference genome. The generated matrices were further analysed using the Seurat package (v4.1.1) for detailed downstream analysis. 
# All data processing metrics are reported in Supplementary Table 6.


# Comparing transcriptomes between human, chimpanzee iPS cell-induced excitatory neurons and cells from the developing human cortex
# We compared single-cell RNA-seq (scRNA-seq) results from iPS cell-induced neuron results with a published human cortex single-nucleus RNA-seq dataset23. The Seurat R package (v4.1.1)53 with default 
# settings was applied to the analysis. We used the Seurat Canonical Correlation Analysis to integrate data from different scRNA-seq data. Then, the top 10 principal components were selected for 
# non-linear dimensionality reduction to generate a UMAP plot.

# Versions
# Seurat v4.1.1


# R version was not specified
# Using 4.3.2 for arbitrary reasons 
# The r-base:4.2.0 image is built on Debian Stretch or Buster, which predates full /usr merge adoption. 
# This is what’s causing the base-files conflict. You can fix this cleanly by switching to a newer R base 
# image that uses Debian Bullseye or later (where /usr is already merged).

#date of release being april 2022, the closest to the release of Seurat v4.1.1 (2 may 2022)
FROM r-base:4.3.2


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

# Seurat v.4.1.1
# SeuratObjec installed 2 times due to unwanted automatic update
RUN R -e "remotes::install_version(\"SeuratObject\", version = \"4.1.0\")" 
RUN R -e "remotes::install_version(\"Seurat\", version = \"4.1.1\")" 
RUN R -e "remotes::install_version(\"SeuratObject\", version = \"4.1.0\")" 


#
ENV SHELL=/bin/bash
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --ServerApp.allow_origin='*' --ServerApp.token='' #last one disables the token
