# Methodology mapped to the submitted thesis

This document distinguishes the **thesis final methods** from exploratory code in the original 988-line annotated R script. It is a documentation draft, not a record of successful reruns.

## Input and design

The thesis describes a mouse melanoma bulk RNA-seq study with 39 samples: vehicle (10), anti-PD-1 (9), EPAT (10), and anti-PD-1 + EPAT (10). Samples were collected on days 2 and 5 after treatment. The raw count matrix was described as 39,179 genes by 39 samples.

## 1. Filtering and normalisation

**Confirmed final criterion:** retain genes with CPM >= 0.5 in at least three samples. The thesis reports 14,917 retained genes.

```r
# Illustrative snippet; not yet a tested executable pipeline
keep <- rowSums(edgeR::cpm(raw_counts) >= 0.5) >= 3
filtered_counts <- raw_counts[keep, , drop = FALSE]
dge <- edgeR::DGEList(counts = filtered_counts)
dge <- edgeR::calcNormFactors(dge, method = "TMM")
log_cpm <- edgeR::cpm(dge, log = TRUE)
```

An early section of the original annotated script instead uses CPM >= 1. That setting must **not** be used for final-analysis reconstruction.

## 2. Quality control

PCA is applied to log-expression matrices, with plots coloured by treatment, library size, and estimated tumour purity. RLE plots are used to assess expression distributions. The annotated script contains several duplicate plotting variants and object-name inconsistencies, which need cleaning.

## 3. Tumour purity

The thesis describes mapping mouse Ensembl IDs to mouse gene symbols, mapping to human ortholog symbols using biomaRt, formatting the expression matrix as GCT, and applying ESTIMATE. Tumour purity was calculated using:

```r
purity <- cos(0.6049872018 + 0.0001467884 * estimate_score)
```

Gene mapping must be checked for duplicates and missing orthologs.

## 4. Immune composition

The thesis investigates immune composition estimates/scores, including BASE, and compares methods. The final modelling code uses BASE-related covariates; the precise selected cell-type columns and sample order must be verified before release.

## 5. Control genes

Positive control gene sets for anti-PD-1 and EPAT treatments and housekeeping negative-control genes were examined. Random selection of housekeeping genes requires a fixed seed to reproduce the selection.

## 6. Differential expression

The annotated script fits four limma treatment-comparison models:
- Treatment + BASE + purity
- Treatment + BASE
- Treatment + purity
- Treatment only

Each includes contrasts between treatment groups. The model numbering and objects must be checked against thesis descriptions. The use of logCPM directly with lmFit also requires an explicit assessment of mean-variance weighting and inferential limitations.

## 7. Enrichment

The thesis reports KEGG pathway enrichment analyses. The pipeline must document the gene-selection thresholds, tested universe, gene-ID conversions and multiple-testing correction, and distinguish any web-based DAVID steps from local R code.

## Methods explored but not automatically final

The annotated script includes exploratory RUVg runs at different k values, multiple PCA/RLE variants and additional deconvolution/normalisation approaches. These belong in separate exploratory documentation until the final-method status of each is confirmed.

## Source priority

1. User-confirmed final thresholds and methods.
2. Submitted thesis / appendix for the historical research report.
3. Annotated R code for implementation details.
4. Any newly modified code is a reconstruction and must be validated rather than claimed to match historical results.
