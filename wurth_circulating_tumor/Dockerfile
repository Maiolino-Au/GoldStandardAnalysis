# Dockerfile for wurth_circulating_tumor
# Würth, R., Donato, E., Michel, L.L. et al. Circulating tumor cell plasticity determines breast cancer therapy resistance via neuregulin 1–HER3 signaling. Nat Cancer 6, 67–85 (2025). https://doi.org/10.1038/s43018-024-00882-2


# Bulk RNA-seq analysis
# Bcl2fastq2 2.20 was used for conversion. Reads were trimmed for adapter sequences and aligned to the 1000 Genomes Phase 2 assembly of the Genome 
# Reference Consortium human genome (build 37, version hs37d5) with STAR53 (v2.5.3a) using the following parameters: alignIntronMax: 500,000; 
# alignMatesGapMax: 500,000; outSAMunmapped: within; outFilterMultimapNmax: 1; outFilterMismatchNmax: 3; outFilterMismatchNoverLmax: 0.3; 
# sjdbOverhang: 50; chimSegmentMin: 15; chimScoreMin: 1; chimScoreJunctionNonGTAG: 0 and chimJunctionOverhangMin: 15. GENCODE gene annotation 
# (GENCODE release 19) was used for building the index. BAM files were sorted using SAMtools54 (v1.6), and duplicates were marked with Sambamba55 (v0.6.5). 
# Raw counts were generated using featureCounts56 (Subread version 1.5.3).

# For calculation of normalized counts, mitochondrial RNA, tRNA, rRNA and all transcripts from the Y and X chromosomes were removed, 
# and normalization was performed in analogy to transcripts per million.

# Differential gene expression analysis was performed using DESeq2 (ref. 56; v1.26.0). The lfcshrink function was used to define differentially expressed 
# genes (| log2 (fold change) |) of ≥1, adjusted P value of ≤0.05). The log2 (fold change) values (nonshrinked) were used for GSEA with clusterProfiler57 
# and the Molecular Signatures Database v7.411 as reference gene sets. Data handling was performed in R (v3.6.0) using RStudio (v1.4).


# scRNA-seq analysis
# Raw data processing was performed with kallisto59 (v0.43.0). The kallisto index file was generated with a hg38 transcriptome fasta file (release-98) 
# downloaded from Ensembl, and reads were then pseudoaligned to the transcriptome with kallisto in quant mode. The R package tximport60 (v1.14.2) 
# was used to perform gene-level summaries, and the resulting count matrix was imported as a SingleCellExperiment object in R.
# 
# The R packages scater61 (v1.14.6) and scran62 (v1.14.6) were used to calculate quality control metrics and remove cells with less than 1 × 105 total counts, 
# less than 2,500 detected features or a percentage of mitochondrial genes higher than 20%. Normalization and log transformation of the data were performed with 
# the functions computeSumFactors and logNormCounts. Cells not expressing the epithelial marker EpCAM or expressing the leukocyte marker CD45 were removed, 
# leaving 318 putative CTCs.
# 
# Cells were then separated into ERBB3hi and ERBB3lo populations based on the results of a k-means clustering (k = 2) on ERBB3 expression values (Fig. 3d). 
# To define a HER3 signature, genes that were not expressed in at least 20% of cells were removed. Differentially expressed genes between the 
# ERBB3hi and ERBB3lo populations were then computed using the pairwiseWilcox function from scran (FDR < 0.1). Resulting significant genes were intersected with 
# genes whose expression showed a significant Pearson correlation (FDR < 0.1) with the expression of ERBB3 and protein-coding genes, yielding 592 upregulated 
# genes and 6 downregulated genes (Supplementary Table 3). To see if the HER3 signature could be used to separate the ERBB3hi and ERBB3lo populations in the three 
# individuals, z scores were computed for each signature gene for the two populations ((x-mu)/epsilon), and the mean over all genes was calculated. 
# For better UMAP visualization and coloring of expression of different genes (Fig. 6a and Extended Data Figs. 6b,c and 10a), data were integrated with 
# mutual nearest neighbors, as implemented in the fastMNN() function from the batchelor63 (v1.2.4) R package.

# Versions
# kallisto59 (v0.43.0)
# tximport60 (v1.14.2)
# scater61 (v1.14.6) 
# scran62 (v1.14.6)
# batchelor63 (v1.2.4)
