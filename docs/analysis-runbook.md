# Analysis runbook (current reconstruction status)

## Verified historically from thesis and supervisor slides

- Original dataset: 39 samples; one QC outlier (`AM6_7.1_S30`) excluded for downstream work.
- Gene filtering threshold: CPM >= 0.5 in at least 3 samples.
- The final principal adjustment method was BASE (not quanTIseq), with tumour purity from ESTIMATE.
- Four major limma covariate configurations, plus six treatment contrasts.
- KEGG enrichment results were reported in the thesis and supplementary materials.

## Practical execution order

1. Download the public expression matrix and its sample metadata from GEO.
2. Use `00_sample_metadata.R` to make a template. Verify treatment and day against GEO source metadata (do not infer order).
3. Apply `01_preprocessing.R` to the raw count matrix; check 14,917 genes after filtering.
4. Run `02_quality_control.R`; investigate the named outlier, and record the 38-sample analysis set.
5. Map mouse gene IDs and compute human ortholog-based ESTIMATE inputs; run ESTIMATE externally. Conversion support is still incomplete.
6. Generate BASE scores with the original package and verified mouse gene-symbol expression. `04_immune_deconvolution.R` currently only checks/aligns results.
7. Run `05_control_validation.R` with documented gene-ID sets and preserve the housekeeping seed.
8. Run `06_differential_expression.R` on ordered samples with aligned BASE and purity. Inspect design rank and compare results against the original thesis.
9. Reproduce KEGG/DAVID analysis from the correct gene lists and background; `07_pathway_enrichment.R` currently only filters exported enrichment tables.

## Distinguish three levels of confidence

- **Historical finding:** appears in thesis/supervisor materials.
- **Reconstructed code:** written to reflect methods; not independently tested with the full study.
- **Reproduced result:** obtained only after an end-to-end run and comparison of numeric results.

At present, these scripts are reconstructed code, not a validated end-to-end analysis.
