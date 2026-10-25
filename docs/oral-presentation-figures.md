# Oral-presentation figures: selection and provenance

**Source:** Master's final oral presentation, 19-page PDF and editable PowerPoint, provided by the author. Only project-specific results were selected; outside illustrations from the background slides were intentionally excluded.

| PDF page / slide | Figure | Portfolio purpose | Status |
| --- | --- | --- | --- |
| 8 | Study cohort table | Compare sample counts by treatment and collection day | New SVG redrawn from the group's reported cells |
| 9 | RNA-seq workflow | Show original methods and ordering | Described in README; original panel not yet extracted |
| 10 | RLE panels | Compare raw, CPM and CPM + TMM | Original panel not yet extracted |
| 11 | PCA panels | Show library-size and purity-related patterns | Original panel not yet extracted |
| 12 | Tumour-purity chart and BASE heatmap | Show heterogeneity and estimated immune scores | Original panel not yet extracted |
| 14 | Four volcano panels | Contrast unadjusted Model 4 and adjusted Model 1 | Original panel not yet extracted |
| 15 | P-value comparison | Show model-adjustment effects | Original panel not yet extracted |
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
- The original PCA/RLE/heatmap/volcano panels were not exported during this update because the binary slide-extraction environment was unavailable. Do not link to nonexistent original image files.
