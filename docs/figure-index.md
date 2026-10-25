# Original figure index and publication checklist

This portfolio is based on the submitted 2025 thesis (42 pages) and appendix (14 pages). The original figure panels have **not** been edited or copied into the repository. This index identifies the most useful panels for a public research showcase.

| Figure | Original source | What it communicates | GitHub status |
| --- | --- | --- | --- |
| PCA / sample outlier | Thesis Figure 2 | Day 2/Day 5 PCA and the labelled QC outlier `AM6_7.1_S30` | Source PDF only |
| Immune composition / BASE | Thesis immune-deconvolution figures | Cell-type enrichment-score patterns across treatments | Source PDF only |
| Volcano: adjusted vs unadjusted | Thesis Figure 12 | Anti-PD-1 + EPAT vs Vehicle under covariate adjustments | Source PDF only |
| Volcano: all contrasts (adjusted) | Appendix Figure S1, page 1 | Six treatment contrasts with BASE + purity adjustment | Source PDF only |
| Volcano: all contrasts (unadjusted) | Appendix Figure S3, page 3 | Six treatment contrasts without these adjustments | Source PDF only |
| P-value comparisons | Appendix Figure S5, page 5 | Comparison of significance distributions under model adjustments | Source PDF only |
| KEGG FDR summary | Thesis Table 6 | Seven enriched pathways in Combo vs Vehicle, BASE + purity | [New SVG graph](../results/figures/kegg_combination_vs_vehicle.svg) |

## Historical results and plot source

The KEGG SVG was drawn from the numerical FDR values reported in thesis Table 6, not from running analysis code. Figure captions should always say whether an image is an original panel or a newly prepared visual summary.

## Before sharing publicly

- Verify permissions for showing thesis and third-party artwork; cite the relevant papers.
- Export original figure panels at adequate resolution without modifying axes or numerical content.
- Avoid including student identification number or personal contact details in screenshots.
- Check all diagram captions, result thresholds and references against the submitted thesis.
- Keep the historical R code and exploratory analyses clearly distinguished from a fully reproducible pipeline.
