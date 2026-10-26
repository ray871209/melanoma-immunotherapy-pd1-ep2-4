# Pathway enrichment and KEGG — original research records

The researcher supplied two **text exports of their original enrichment tables**. They are preserved as sources rather than being presented as newly generated analyses:

- [Full pathway enrichment comparison table](../archive/pathway-enrichment/pathway-enrichment-original-table.md) — a wide table comparing BASE with/without tumour purity and quanTIseq exploratory models, including treatment contrasts, up/downregulated gene sets, P-values and multiple-testing adjustments. This wide pasted-table format is challenging to read directly on GitHub.
- [Original KEGG tab-delimited export](../archive/pathway-enrichment/kegg-pathways-original-export.txt) — historical DAVID/KEGG rows organised by adjusted, unadjusted and other model variants, with gene counts, background counts, P-values, Benjamini adjustments, fold enrichment and DAVID FDR columns.
- [Tidy Combo vs Vehicle comparison CSV](../results/kegg-combo-vs-vehicle-normalized.csv) — **a transcription of 118 rows from the two matching sections of the author's tab-delimited text**, not a recomputation of enrichment statistics.

## Principal comparison: Anti-PD-1 + EPAT vs Vehicle

The tab-delimited KEGG export labels the first column of models **“BASE with purity”**, and its comparison section lists 38 KEGG terms. **Seven** have **Benjamini adjusted P-value < 0.05**:

| KEGG pathway | Gene count | Raw P-value | Benjamini-adjusted P-value | DAVID FDR (separate export field) |
| --- | ---: | ---: | ---: | ---: |
| Hematopoietic cell lineage | 15 | 1.46E-06 | 0.000433 | 4.20E-04 |
| Cytokine-cytokine receptor interaction | 26 | 7.27E-06 | 0.00108 | 1.05E-03 |
| Efferocytosis | 16 | 2.16E-04 | 0.0195 | 1.89E-02 |
| Fluid shear stress and atherosclerosis | 15 | 2.62E-04 | 0.0195 | 1.89E-02 |
| Osteoclast differentiation | 14 | 3.91E-04 | 0.0232 | 2.25E-02 |
| Pertussis | 10 | 7.27E-04 | 0.036 | 3.49E-02 |
| Systemic lupus erythematosus | 14 | 9.93E-04 | 0.0421 | 4.08E-02 |

Source table attributes the adjusted enrichment to a gene list with **682 entries** (DAVID `List Total`) and a background population of **9,565**, as reported in the export. These counts are the table's reported gene-list statistics; they are not newly calculated here.

### Unadjusted comparison

For the same Combo vs Vehicle contrast, the source’s **“without BASE without purity”** section lists **80 KEGG pathway rows**, of which **53** have an exported **Benjamini value < 0.05**. Its reported list total is **1,036**, compared with 682 in the adjusted section.

This descriptive comparison supports the study’s finding of broader enrichment without covariate adjustment. **It does not prove that adjustment removes false positives or that the difference is entirely caused by tumour purity/immune composition.** DAVID runs and gene-list definitions may also differ. The 53/80 figure is a count of the rows **visible in this source export**, not a fresh DAVID analysis or a claim about the complete KEGG database.

## Significance terminology

- The source provides *P-Value*, *Benjamini*, *Bonferroni* and *FDR* as **distinct fields**.
- The seven-pathway list above uses the **Benjamini column** for the threshold. The adjacent DAVID *FDR* column is reproduced verbatim and should not be conflated with Benjamini-adjusted P-values.
- A small *raw P-value* without a small adjusted value is **not** evidence that a pathway passes multiple-testing correction.
- Pathway names such as infection-related pathways represent gene-set annotations, **not clinical diagnoses of infection**.
- The additional wide pathway-enrichment comparison table includes other model/contrast results and should not be collapsed into this specific KEGG contrast.

## Audit provenance

All values above were transcribed from the researcher’s provided text exports during project archiving on **2026-10-26**. No analysis or pathway enrichment was rerun. The two earlier source Excel workbooks, `DAVIDChartReport_List_2_2025-09-28.xlsx` and `Pathway enrichment.xlsx`, were **not yet verified cell-by-cell** against these pasted text exports. Thus the source spreadsheets are not claimed to be mirrored exactly by these files.

The original research data are linked at [GEO GSE160788](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE160788). See [methods](methodology.md) and [the research archive audit](research-archive-audit.md).
