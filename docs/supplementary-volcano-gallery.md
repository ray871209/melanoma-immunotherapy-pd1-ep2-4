# Supplementary volcano-plot gallery

The author provided original research figures for six treatment contrasts. These are historical outputs from the submitted master's thesis and appendix, rather than regenerated analyses.

## Adjusted: BASE + tumour purity

| Comparison | Figure planned in `supplementary/` |
| --- | --- |
| Combo vs Vehicle | `adjusted_combo_vehicle.png` |
| Anti-PD-1 vs Vehicle | `adjusted_anti_pd1_vehicle.png` |
| EPAT vs Vehicle | `adjusted_epat_vehicle.png` |
| Combo vs EPAT | `adjusted_combo_epat.png` |
| Anti-PD-1 vs EPAT | `adjusted_anti_pd1_epat.png` |
| Combo vs Anti-PD-1 | `adjusted_combo_anti_pd1.png` |

## Unadjusted: treatment only

| Comparison | Figure planned in `supplementary/` |
| --- | --- |
| Combo vs Vehicle | `unadjusted_combo_vehicle.png` |
| Anti-PD-1 vs Vehicle | `unadjusted_anti_pd1_vehicle.png` |
| EPAT vs Vehicle | `unadjusted_epat_vehicle.png` |
| Combo vs EPAT | `unadjusted_combo_epat.png` |
| Anti-PD-1 vs EPAT | `unadjusted_anti_pd1_epat.png` |
| Combo vs Anti-PD-1 | `unadjusted_combo_anti_pd1.png` |

## Highlighted positive / negative control genes

Figures with orange positive controls and blue housekeeping negative controls were also supplied for six adjusted contrasts and selected unadjusted contrasts. The coloured control-gene highlights should not be confused with significant up/down-regulation colouring used in the standard volcano panels.

## Interpreting the plots

The final analysis compared differential expression signatures after adjusting for BASE cell-type enrichment scores and ESTIMATE tumour purity, versus treatment-only models. Changes in apparent differential expression can reflect covariate composition effects, but the plots alone cannot establish the origin or causal role of individual genes.

## Upload status

The original PNG plots have been collected and renamed into a separate downloadable figure package. **The binary image files have not yet been committed to this GitHub repository.** This index deliberately avoids broken image embeds or suggesting they have been uploaded.

## Final selected p-value and control-highlighted plots

The author supplied the remaining four unadjusted highlighted-control volcano comparisons, plus six historical p-value distribution comparisons (fully adjusted versus unadjusted). The **main README should show only Combo vs Vehicle** to avoid overcrowding. Other contrasts can be viewed in the supplementary gallery once images are uploaded.

Additional expected image names in the downloadable figure package:

- `controls_unadjusted_epat_vehicle.png`
- `controls_unadjusted_combo_anti_pd1.png`
- `controls_unadjusted_combo_epat.png`
- `controls_unadjusted_anti_pd1_epat.png`
- `pvalue_combo_vehicle_adjusted_vs_unadjusted.png`
- `pvalue_anti_pd1_vehicle_adjusted_vs_unadjusted.png`
- `pvalue_epat_vehicle_adjusted_vs_unadjusted.png`
- `pvalue_combo_epat_adjusted_vs_unadjusted.png`
- `pvalue_anti_pd1_epat_adjusted_vs_unadjusted.png`
- `pvalue_combo_anti_pd1_adjusted_vs_unadjusted.png`

These are **historical results, not newly computed plots**. As of this documentation update, the PNGs are packaged separately and **not yet pushed to this repository**.
