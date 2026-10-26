# Research archive audit — 26 October 2026

This review concerns the **existing historical research**, not a rerun or a claim that the code is executable end-to-end.

## Comparison of standalone files with consolidated notebook

A text-level audit compared each additional uploaded script with [the complete annotated R source](../archive/original_annotated_code.R). The overlap metric below counts substantive individual source lines (over 25 characters) occurring verbatim in the consolidated source. **This is only a rough indication of shared code, not a code-identity or scientific equivalence test.** Different formatting, reworked plots and added steps can lower exact matching.

| Additional original file | Substantive lines matching verbatim / eligible | Classification |
| --- | ---: | --- |
| `PCA.R` | 116 / 160 | Related PCA plotting and preprocessing experiments |
| `RLE.R` | 24 / 88 | Independent RLE plotting alternatives, including day subsets |
| `PCA_day2day5.R` | 51 / 99 | Day-specific PCA exploration |
| `PCA_redo_day2_5.R` | 126 / 282 | Revised day-specific PCA with additional metadata/visualisation |
| `PCA_remove_outlier.R` | 50 / 127 | PCA and sample QC after exclusion of outlier |
| `Negative_Control_Genes.R` | 63 / 179 | Negative controls and exploratory RUV variants |
| `postive_control.R` | 165 / 416 | Literature positive controls, plots and comparisons |
| `prps_knight25.Rmd` | 3 / 98 | Separate RUV-PRPS research notebook |
| `immune_deconvolution.Rmd` | 224 / 985 | Independent exploratory immune cell inference notebook |

**Conclusion:** Keep the historical standalone files in [`archive/standalone-r/`](../archive/standalone-r/) while presenting the curated [research-notebook](../research-notebook/README.md) as the main code navigation route. Some snippets overlap, but the standalone files contain more context and alternative approaches. Deduplication would discard research history.

## Code-review observations

These are examples of potential issues in historical source scripts, **not verified fixes or errors proven by executing them**:

- The original annotated source contains exploratory R code with references to objects created in other RStudio sessions. For example, pre-normalisation PCA refers to `new_group` in an earlier section, and later models use `update_cpm_data`, `update_group`, and `base` from prior steps. Do not describe these as standalone functions.
- The source contains an early CPM >= 1 / three-sample exploratory filter, while the final thesis reports CPM >= 0.5 / three-sample filtering. The published figure captions and methods should describe the final filter, not conflate it with the exploratory snippet.
- Several RUV approaches were investigated; **BASE plus tumour purity** was used in the final main adjusted limma model. RUV attempts should remain labelled exploratory.
- The source has historical plot-construction and object-naming inconsistencies, so prettier formatting must not be represented as evidence of runtime validation.
- The source distinguishes sample QC with the removed outlier `AM6_7.1_S30`. Methods must identify the correct retained sample set.

## Supplementary uploaded source data

| Source file | What is known | GitHub status |
| --- | --- | --- |
| `HOUNKPE_HOUSEKEEPING_GENES.v2024.1.Mm.tsv` | A mouse housekeeping gene set marked as an MSigDB/GSEA reference (`MM1338`); external source and reuse terms need review | **Not copied** |
| `DAVIDChartReport_List_2_2025-09-28.xlsx` | Author-supplied spreadsheet labelled as a DAVID pathway chart report, filename dated 2025-09-28 | **Not copied** |
| `Pathway enrichment.xlsx` | Author-supplied pathway enrichment Excel workbook | **Not copied** |

**Spreadsheet limitation:** The binary workbook content was not available through the current file-reading path for cell-by-cell inspection. No gene sets, pathway terms, p-values or FDR values were inferred from their filenames. The earlier documented thesis/figure results remain the currently cited study findings. Workbook contents require inspection in a spreadsheet-capable environment before meaningful GitHub publication or cross-checking.

## Public-release safeguards

1. Keep this repository **private** pending a check for names, student identifiers, local file paths, credentials and third-party reuse restrictions in all uploaded source files and history.
2. Do not advertise nine independent stand-alone executable pipelines; they are interactive research artifacts with shared in-memory objects.
3. Only convert exploratory analyses into reproducible scripts in a future distinct version, with dependencies, sample metadata, and checks. Do not retroactively alter the historic study.
4. Avoid renaming numbered PNGs to specific treatments without verifying image captions against the original thesis/appendix.

**Update (2026-10-26):** Author-supplied *text representations* of the pathway enrichment and KEGG exports are now preserved at [pathway enrichment / KEGG notes](pathway-enrichment-kegg.md), with raw pasted content under `archive/pathway-enrichment/`. These are not copies of the binary Excel workbooks, and Excel worksheet-level identity and formatting remain unverified.
