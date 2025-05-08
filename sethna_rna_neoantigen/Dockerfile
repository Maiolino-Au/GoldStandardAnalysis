# Dockerfile for sethna_rna_neoantigen
# Sethna, Z., Guasp, P., Reiche, C. et al. RNA neoantigen vaccines prime long-lived CD8+ T cells in pancreatic cancer. Nature 639, 1042–1051 (2025). https://doi.org/10.1038/s41586-024-08508-4



# Single-cell RNA and TCR sequencing

# As reported1, we prepared libraries for single-cell immune profiling, sequenced and post-processed raw data at the 
# Epigenomics Core at Weill Cornell Medicine.

# Sample preparation

# To analyse the gene expression of vaccine-induced clones, bulk T cells from patient-derived PBMCs were purified by fluorescence-activated 
# cell sorting and sequenced as previously reported1. In brief, we purified single T cells and prepared scRNA-seq libraries as per company 
# specifications prior to performing single-cell immune profiling (10x Genomics, guide CG000330). Each cellular suspension at 97% viability 
# and at 950 cells per μl was loaded onto to a Chromium X to generate Gel Beads-in-Emulsion (GEM) targeting 10,000 single cells per sample.

# Sequencing and data processing

# To generate 5 P expression libraries, we enzymatically fragmented an aliquot of the cDNA (~50 ng), and end-repaired, A-tailed, 
# subjected to a double-sided size selection with SPRI select beads (Beckman Coulter), and ligated to adaptors. We then introduced a unique 
# sample index for each library through 14 cycles of PCR amplification using the indexes (98 °C for 45 s; 98 °C for 20 s, 54 °C for 30 s and 72 °C 
# for 20 s × 14 cycles; 72 °C for 1 min; held at 4 °C), subjected indexes to a second double-sided size selection, and quantified libraries using 
# Qubit fluorometric quantification (Thermo Fisher Scientific). We assessed quality on an Agilent Bioanalyzer 2100, obtaining an average library 
# size of 460 bp. To generate full-length TCR VDJ regions, we subjected cDNA aliquots (5 ng) to nested PCR amplification with specific VDJ outer 
# and inner primer pairs (98 °C for 45 s; 98 °C for 20 s, 67 °C for 30 s and 72 °C for 20 s × 8 cycles; 72 °C for 1 min; held at 4 °C), 1-sided 
# size selection using SPRI select beads, and assessed quality and quantity of the VDJ region using an Agilent Bioanalyzer 2100. The average library 
# size was 620 bp.

# We then clustered gene expression and TCR libraries on an Illumina Novaseq pair end flow cell sequenced for 28-10-10-91, to obtain about 350 million 
# clusters per sample. We processed sequencing images using Illumina’s Real Time Analysis software (RTA). We used 10x Genomics Cell Ranger Single Cell 
# Software suite v6.0.0 (https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger) to demultiplex, 
# align (hg19), filter, UMI count, and single-cell 5′ end gene count samples, assemble TCRs, annotate paired VDJ, and perform quality control per 
# manufacturer’s parameters.



# Statistical analyses

# Sample sizes (n) represent the number of patients, samples, clones or cells. We analysed survival curves by log-rank (Mantel–Cox) test, 
# compared two groups using unpaired two-tailed Mann–Whitney test, paired groups with two-tailed paired t-test or two-tailed Wilcoxon matched-pairs 
# signed rank test, multiple groups with Kruskal–Wallis test, categorical variables by chi-squared test, and correlated parameters with Spearman correlation. 
# We compared longitudinal clonal expansion by two-tailed Fisher’s exact test, and in vitro clonal activation by binomial test with Bonferroni correction. 
# For differential gene-expression analysis, we used Wilcoxon rank sum without any multiple hypothesis correction. 
# P < 0.05 was considered statistically significant. All analyses were performed using GraphPad Prism (version 10.1.1) or Python (version 3.11.6).

# Versions
# Python (version 3.11.6)


FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y
RUN apt install nano curl -y

# Install stuf
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
    libsqlite3-dev


# Python
RUN apt update && apt install -y wget \
    && wget https://www.python.org/ftp/python/3.11.6/Python-3.11.6.tgz \
    && tar -xvzf Python-3.11.6.tgz \
    && cd Python-3.11.6 \
    && ./configure --enable-optimizations \
    && make -j$(nproc) \
    && make altinstall \
    && cd .. \
    && rm -rf Python-3.11.6 Python-3.11.6.tgz

# Install pip and venv
RUN apt install -y python3-pip python3-venv

# Create a virtual environment
RUN python3.11 -m venv /opt/venv

# Activate virtual environment and install JupyterLab
RUN /opt/venv/bin/pip install --upgrade pip \
    && /opt/venv/bin/pip install jupyterlab

# Set the virtual environment as the default Python path
ENV PATH="/opt/venv/bin:$PATH"






# Python libraries
#RUN pip install -r sethna_rna_neoantigens_python_libraries.txt
RUN pip install numpy scipy matplotlib





# Cell Ranger
#RUN cd /
#RUN mkdir yard
#RUN cd yard
#RUN mkdir /yard/apps
#RUN cd /yard/apps
#RUN curl -o cellranger-6.0.2.tar.gz "https://cf.10xgenomics.com/releases/cell-exp/cellranger-6.0.2.tar.gz?Expires=1745897506&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA&Signature=ol3ky15f3CevMFtG5w1SkIyhMtc7Dqr2y7zfoDoHonjOk-3kMxbxIKDtpxTM1qM7Usp9Cb0BfVL~PKfLB5km-Vrm0wZcfzFzL02L3dGFc0Xwhyq9WC0ppNyEEttHRmEYJ3E6nN70j9SosW0FTwuhVar4fYPcCPNYzxSLfIVyb2KQCzSKu4KLLUjaOYxyg4HddYnt0tbIIBNPWhQO54Md7dKl23ITKBRH1epK0BIzUe7OruqOeM-XjTwkqkGf~cjNc~-NcwBGzkE~UKEXOEGDf85lDPR30LzJmMsh7M5PNS~T0XUZG0dq1hH2gbkGQx16LPiaKc8DJg1~UHucnYeoCQ__"
#RUN tar -zxvf cellranger-6.0.2.tar.gz
#RUN cd cellranger-6.0.2
#RUN PATH=.:$PATH



#RUN cd /





















ENV SHELL=/bin/bash

CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --ServerApp.allow_origin='*' --ServerApp.token='' #last one disables the token
#CMD ["/bin/bash"]

