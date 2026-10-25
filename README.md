# Melanoma immunotherapy bulk RNA-seq analysis

**Research project:** Exploring Differential Gene Expression in Melanoma Under Combined Checkpoint Inhibitor and Anti-inflammatory Treatment  
**Author:** Tzer Ray Su | Master of Bioinformatics, University of Melbourne (2025)

## Overview

This repository is being curated from the original master's research thesis, supplementary figures/tables, and an annotated R analysis script. It examines bulk RNA-seq expression profiles from a mouse melanoma model receiving:

- Vehicle control
- Anti-PD-1
- EP2/EP4 antagonists (EPAT)
- Anti-PD-1 + EPAT (combination)

The study examines treatment-associated differential gene expression, with a focus on how estimated tumour purity and immune-cell composition affect downstream analysis.

**Status: work in progress.** The original annotated analysis script contains exploratory attempts, intermediate R-session variables, and some inconsistent code. The curated, independently runnable pipeline is **not yet validated**. Please do not interpret the present repository as a fully reproducible or independently re-executed analysis.

## Dataset

The thesis describes 39 samples across day 2 and day 5 following treatment (19 and 20 samples, respectively), with 39,179 genes in the initial raw count matrix.

- GEO: [GSE160788](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE160788)
- BioProject: [PRJNA674507](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA674507)

Original data are not redistributed in this repository. The thesis reports filtering the count matrix to **14,917 genes**, using **CPM ≥ 0.5 in at least 3 samples**. This is the confirmed final filtering criterion; an earlier exploratory script block instead used CPM ≥ 1.

## Thesis analysis outline

1. Import count matrix and annotate treatment/sample groups.
2. Filter low-expression genes and perform edgeR TMM normalisation; compute log2-CPM.
3. Check sample structure and relative expression distributions using PCA and RLE plots.
4. Estimate tumour purity with ESTIMATE after mouse-to-human ortholog mapping.
5. Estimate immune composition using immune deconvolution (including BASE).
6. Review positive-control and housekeeping-gene behaviour.
7. Fit treatment contrasts using limma under alternative covariate-adjustment models.
8. Interpret differentially expressed genes with KEGG enrichment analysis.

See [methods notes](docs/methodology.md) and [reproducibility checklist](docs/reproducibility.md).

## Planned repository layout

```text
scripts/           Curated final-analysis stages (not yet validated)
exploratory/       Trial methods not selected for the final analysis
docs/              Methodology, reproducibility, decisions and limitations
results/figures/   Selected thesis figures (only when permission/attribution is clear)
```

## Important scientific distinctions

- Tumour purity is an **estimate**, not a directly measured tumour-cell fraction.
- Immune deconvolution reflects algorithm-specific estimates or scores; different methods need not be directly comparable.
- Differences between covariate-adjusted and unadjusted models should not automatically be interpreted as causal.
- Scripts will be revised against the thesis, but any modifications affecting statistical outputs will be documented instead of silently changing historical findings.

## Data access and reproducibility

To reproduce the published study analysis, download the referenced expression dataset from GEO and consult the original study's metadata. The exact sample-to-treatment correspondence and exclusion criteria must be verified from source files before the curated scripts are described as runnable end-to-end.

## Attribution

This is a portfolio-oriented reconstruction of the author's 2025 master's research project using previously published transcriptomic data. The underlying dataset and external software remain subject to their original citations and licences. A software licence has **not yet been selected**.
