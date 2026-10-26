# Oral-presentation figures: selection and provenance

**Source:** Master's final oral presentation, 19-page PDF and editable PowerPoint, provided by the author. Only project-specific results were selected; outside illustrations from the background slides were intentionally excluded.

| PDF page / slide | Figure | Portfolio purpose | Status |
| --- | --- | --- | --- |
| 8 | Study cohort table | Compare sample counts by treatment and collection day | New SVG redrawn from the group's reported cells |
| 9 | RNA-seq workflow | Show original methods and ordering | [Clean portfolio diagram](../results/figures/research_workflow.svg) redrawn from presentation methods; original slide not copied |
| 10 | RLE panels | Compare raw, CPM and CPM + TMM | Original research PNGs uploaded; image-to-panel matching awaits panel mapping |
| 11 | PCA panels | Show library-size and purity-related patterns | Original research PNGs uploaded; image-to-panel matching awaits panel mapping |
| 12 | Tumour-purity chart and BASE heatmap | Show heterogeneity and estimated immune scores | Original research PNGs uploaded; image-to-panel matching awaits panel mapping |
| 14 | Four volcano panels | Contrast unadjusted Model 4 and adjusted Model 1 | Original research PNGs uploaded; image-to-panel matching awaits panel mapping |
| 15 | P-value comparison | Show model-adjustment effects | Original research PNGs uploaded; image-to-panel matching awaits panel mapping |
| 16 | KEGG results and pathway plot | Summarise enriched pathways | Previously redrawn FDR-only SVG from thesis Table 6 |

## Methodological selection

The final oral presentation explicitly describes the principal four models as BASE plus purity, purity only, BASE only, and unadjusted. Therefore BASE, not quanTIseq, is used for the main final-model narrative. Early quanTIseq experiments remain part of the historical code archive.

## Sample-count discrepancy in the presentation

Slide 8 reports four treatment-specific day counts:
- Combo: 5 on Day 2, 4 on Day 5.
- Anti-PD-1: 4 on Day 2, 5 on Day 5.
- EPAT: 5 on Day 2, 5 on Day 5.
- Vehicle: 5 on Day 2, 5 on Day 5.

These row entries sum to **19 on Day 2 and 19 on Day 5 (total 38)**, whereas the final total row displayed on the slide says **19 / 20 / 38**, which is arithmetically inconsistent. The redrawn cohort SVG follows the per-treatment cells, explicitly noting the discrepancy. The sample-by-day metadata should be checked before interpreting day-specific statistics.

## Interpretation and publication

- BASE returns relative enrichment scores, not absolute cell proportions.
- The volcano comparisons illustrate differences in the observed expression signatures when covariate adjustment changes. They do not prove that any particular gene is intrinsically tumour-derived.
- The historical oral script explains the intended analysis and interpretation; it is not code or raw data.
- Source slides show student-identifying information on the cover and contain third-party illustrations in background sections. Do not upload the original presentation wholesale without checking personally identifying content and third-party image permissions.
- The researcher subsequently uploaded 66 original research and appendix PNGs. All are hosted in the [image gallery](original-figures-gallery.md) with neutral, sequential archive filenames; avoid assigning an exact panel-to-PNG mapping until the image has been visually identified.
