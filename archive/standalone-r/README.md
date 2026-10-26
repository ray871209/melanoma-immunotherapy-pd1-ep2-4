# Original standalone R research files

These are the author's **original, standalone historical R scripts and R Markdown notebooks**, supplied after the consolidated annotated R notebook was archived. Their contents are stored as supplied, without rewriting the computations or combining exploratory attempts into the final model.

| File | Research stage / purpose |
| --- | --- |
| [PCA.R](PCA.R) | PCA exploration before and after normalisation, and plots coloured by treatment, sequencing depth and tumour purity |
| [RLE.R](RLE.R) | RLE plots for alternative transformations and Day 2 / Day 5 |
| [PCA_day2day5.R](PCA_day2day5.R) | Separate Day 2 and Day 5 PCA comparison |
| [PCA_redo_day2_5.R](PCA_redo_day2_5.R) | Further Day 2 / Day 5 PCA work, sample-level metadata and visualisations |
| [PCA_remove_outlier.R](PCA_remove_outlier.R) | Reanalysis of PCA after removal of the identified sample outlier |
| [Negative_Control_Genes.R](Negative_Control_Genes.R) | Housekeeping controls and exploratory RUV methods |
| [postive_control.R](postive_control.R) | Positive-control genes for EPAT and anti-PD-1, plus visualisation and statistical checks. Filename retains the source typo for traceability |
| [prps_knight25.Rmd](prps_knight25.Rmd) | Exploratory RUV PRPS notebook |
| [immune_deconvolution.Rmd](immune_deconvolution.Rmd) | Exploratory immune deconvolution and BASE research notebook |

## How this folder fits into the research archive

- **[research-notebook/](../../research-notebook/)** is the commented, navigable set of excerpts from the main annotated R script.
- **[archive/original_annotated_code.R](../original_annotated_code.R)** is the unmodified consolidated source originally submitted.
- **This folder** captures additional independent scripts and R Markdown records, including repeated analytical attempts that should not be misrepresented as the final workflow.
- **[docs/methodology.md](../../docs/methodology.md)** summarises the final scientific approach and distinguishes it from exploratory variants.

These files generally refer to objects created in the researcher's interactive RStudio session, e.g. `filtered`, `cpm_data`, `update_group` and `tumor_purity`. They are **not** claimed to run independently. Do not assume earlier filters or tested immune methods superseded the approach described in the submitted thesis.

## Supporting source material not republished yet

Three additional files were provided in the conversation but are not in this GitHub archive:

- `HOUNKPE_HOUSEKEEPING_GENES.v2024.1.Mm.tsv` — external housekeeping-gene reference list; provenance and redistribution permissions should be checked before copying the full dataset into a public repository.
- `DAVIDChartReport_List_2_2025-09-28.xlsx` — exported DAVID pathway analysis workbook.
- `Pathway enrichment.xlsx` — spreadsheet of pathway enrichment outputs.

The spreadsheet files are binary Excel workbooks; this GitHub connected upload currently handles text files, so **do not infer they were uploaded**. Their existence is documented here rather than substituting invented tables or re-created values.

## Environment

An author-reported [R session snapshot dated 2025-10-20](../../docs/software-and-dependencies.md) documents package versions, including limma, edgeR, immunedeconv, biomaRt and ggplot2.
