# R environment and software versions

This document records an **author-provided R session snapshot** associated with the melanoma immunotherapy research project. It is historical environment metadata, **not a lockfile or a guarantee that every figure can be reproduced by installing these versions**.

## R and system environment

| Component | Recorded value |
| --- | --- |
| R | 4.4.1 (2024-06-14) |
| Platform | x86_64-apple-darwin20 |
| Operating system | macOS 15.6 |
| BLAS | macOS Accelerate framework |
| LAPACK | 3.12.0 |
| Session timezone | Australia/Melbourne |

## Selected direct analytical packages

These package versions were identified from the supplied session snapshot. The **session state** does not by itself establish which individual package was used for a particular final figure.

| Package | Recorded version | Historical relevance |
| --- | --- | --- |
| edgeR | 4.4.2 | Gene-expression preprocessing / CPM and TMM |
| limma | 3.62.2 | Differential expression modelling |
| EDASeq | 2.40.0 | Relative log-expression visualisation |
| biomaRt | 2.62.1 | Gene ID and ortholog mapping |
| immunedeconv | 2.1.0 | Immune deconvolution, including BASE exploratory/final selection |
| EPIC | 1.1.7 | Exploratory immune deconvolution |
| xCell | 1.1.0 | Exploratory immune deconvolution |
| quantiseqr | 1.14.0 | Exploratory immune deconvolution |
| ggplot2 | 3.5.2 | Plotting |
| ggExtra | 0.10.1 | Marginal plot visualisation |
| pheatmap | 1.0.13 | Immune-score heatmaps |
| dplyr | 1.1.4 | Data manipulation |
| tidyr | 1.3.1 | Data manipulation |
| tibble | 3.3.0 | Data frames |
| reshape2 | 1.4.4 | Data reshaping |
| org.Mm.eg.db | 3.20.0 | Mouse annotation |
| AnnotationDbi | 1.68.0 | Bioconductor annotation |
| DESeq2 | 1.46.0 | Loaded namespace; not claimed as the final DE method |
| RUVIIIPRPS | 0.0.0.9000 | Exploratory RUV analysis |
| ruv | 0.9.7.1 | Exploratory RUV analysis |
| Seurat | 5.3.0 | Present in session; not a claim that it was used for this bulk RNA-seq final analysis |

**Source distinctions:** Some packages above were *attached* in the session (e.g., `limma`, `immunedeconv`, `ggplot2`); other packages were *loaded via namespaces* (e.g., `edgeR`, `EDASeq`, `DESeq2`, `RUVIIIPRPS`, `Seurat`). A loaded namespace may be a dependency or reflect other work and should **not** automatically be treated as direct usage.

## Provenance and reproducibility

- Source: R `sessionInfo()` text exported from the author's research environment and supplied on 26 October 2026. The snapshot itself does not include an execution date, so the software versions are **not claimed to be the exact versions used for every 2025 analysis step**.
- The project combines original code excerpts from interactive RStudio sessions, including exploratory analyses and historical dependencies. Running the four notebook files independently is **not guaranteed**.
- The public data source is [GEO GSE160788](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE160788). Files derived from private paths or installed local packages have not been redistributed.
- DAVID and KEGG were also used for pathway interpretation, but this R session does **not** record their website/database versions.
- See [code navigation](../research-notebook/README.md), [methodology](methodology.md), and [original untouched annotated R code](../archive/original_annotated_code.R).

## Full package inventory

The source `sessionInfo()` listing includes many additional transitive dependencies beyond the named analytical libraries. To avoid falsely calling all of them direct project requirements, the table above is intentionally selective. For an exact environment recreation attempt, retain the original session dump alongside this interpretation.
