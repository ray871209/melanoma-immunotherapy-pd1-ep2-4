# Exploring Differential Gene Expression in Melanoma Under Combined Checkpoint Inhibitor and Anti-inflammatory Treatment

**Master of Bioinformatics research project | University of Melbourne | 2025**

An archived and organised collection of R code and methods from a master's research project investigating gene-expression changes following anti-PD-1, EP2/EP4 antagonist (EPAT), and combination treatments in a mouse melanoma model.

## Research question

How do combination immunotherapy and EP2/EP4 antagonism influence the tumour microenvironment and differential gene expression, and how does accounting for estimated immune composition and tumour purity affect the results?

## Data and study design

- Public bulk RNA-seq dataset: [GSE160788](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE160788) / [PRJNA674507](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA674507).
- Four conditions: Vehicle, anti-PD-1, EPAT, and anti-PD-1 + EPAT.
- Day 2 and day 5 collection; 39 original samples, 38 retained for downstream comparisons following QC.
- Final gene-filtering criterion: CPM >= 0.5 in at least 3 samples. The thesis reports 14,917 genes retained.

## Research workflow

1. Raw count review, low-expression filtering, and TMM-normalised log2-CPM.
2. Quality control and sample exploration using PCA and RLE plots.
3. ESTIMATE tumour purity after mouse-to-human ortholog conversion.
4. Exploration of immune deconvolution methods; **BASE** selected for the principal final adjustment approach, rather than quanTIseq.
5. Positive/negative control gene checks.
6. Differential expression with limma, contrasting treatment effects under different combinations of BASE and tumour purity covariates.
7. KEGG pathway enrichment interpretation.

This workflow describes the *historical research project*. The R code was used interactively and has not been packaged as a fully executable automated pipeline.

## Code organisation

| Path | What it contains |
| --- | --- |
| [research-notebook/01_preprocessing_qc_estimate.R](research-notebook/01_preprocessing_qc_estimate.R) | Original sections on preprocessing, QC, and ESTIMATE |
| [research-notebook/02_control_genes_and_exploration.R](research-notebook/02_control_genes_and_exploration.R) | Original sections on control genes and explorations (including RUV attempts) |
| [research-notebook/03_immune_deconvolution.R](research-notebook/03_immune_deconvolution.R) | Original section comparing deconvolution approaches |
| [research-notebook/04_limma_and_visualisation.R](research-notebook/04_limma_and_visualisation.R) | Original sections on limma models, volcano plots, and statistical visualisation |
| [archive/original_annotated_code.R](archive/original_annotated_code.R) | Complete original annotated R file, preserved as submitted |
| [docs/base-selection.md](docs/base-selection.md) | Notes on the selection of BASE over quanTIseq |
| [docs/methodology.md](docs/methodology.md) | Methodological notes |

The notebook files are **reorganised excerpts of the original code**, not rewritten replacements. Their internal exploratory snippets, overwritten variables, and dependencies on objects from previous R sessions have been preserved to avoid rewriting research history. They are for code review and portfolio demonstration; **do not assume each file will run independently**.

## Principal conclusions

Comparisons with and without immune composition/tumour purity adjustment highlighted the influence of sample composition on apparent treatment-associated expression changes. The study explored immune and inflammatory pathways associated with different treatment combinations. See the submitted thesis and appendix for the full results and limitations. These findings are from the original master's research, not a new re-analysis.

## Reproducibility and attribution

The original analysis relied on an interactive RStudio environment. This repository presents and organises the existing work, but does not claim a verified, one-command reproduction of all figures or statistics. Public datasets are linked rather than redistributed, and the original study and software authors should be cited when reusing the work.

The complete thesis and supervisor meeting slides are not automatically republished here. Please contact the author for further methodological context. No software licence has been selected.
