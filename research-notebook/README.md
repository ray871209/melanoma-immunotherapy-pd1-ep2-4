# Research code guide

The four files in this directory are **organised excerpts** of the author's 2025 annotated R research code. They are arranged for reading, not packaged as independent runnable scripts.

| File | Contents | Historical role |
|---|---|---|
| [01_preprocessing_qc_estimate.R](01_preprocessing_qc_estimate.R) | Import, CPM/TMM, PCA, RLE, gene ID conversion, ESTIMATE | Main analysis / quality control, including early alternatives |
| [02_control_genes_and_exploration.R](02_control_genes_and_exploration.R) | Housekeeping and positive-control genes, nonparametric tests, RUV trials, alternative graphics | Mixed: validation and exploration |
| [03_immune_deconvolution.R](03_immune_deconvolution.R) | quanTIseq/xCell/EPIC testing, mouse-based methods, BASE outputs | Exploration leading to BASE selection |
| [04_limma_and_visualisation.R](04_limma_and_visualisation.R) | Four BASE/purity model variants, treatment contrasts, volcano plots, p-value visualisation | Main downstream analysis and plots |

## Reading order

Start with the project [README](../README.md), then study the code files sequentially. Some objects were defined interactively while the research was conducted; sections may not execute from a fresh R session. The [original complete annotated file](../archive/original_annotated_code.R) is preserved separately.

## What was tidied

- Split the long annotated source by subject.
- Standardised trailing whitespace and excessive blank lines.
- Added explanatory source-provenance notices.
- Preserved original analysis commands and trial methods.

## What was deliberately *not* rewritten

- Original calculations and data transformation statements.
- Existing object names and their historical dependencies.
- Exploratory code that was not chosen for the final analysis.
- Reported thesis results.

**Historical clarification:** the final gene filter was CPM >= 0.5 in at least 3 samples, even though one early exploratory section used CPM >= 1. The final immune adjustment used BASE as the selected method; quanTIseq was an investigated alternative. See [editorial notes](../docs/code-review-notes.md).
