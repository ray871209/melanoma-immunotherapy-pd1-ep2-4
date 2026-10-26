# Original research figure package — archive and provenance

**Current state: 66 original author-uploaded PNGs are committed to the private repository**, under [`results/figures/original-uploads/`](../results/figures/original-uploads/). These include research figures and appendix plots. See the [66-image browsable gallery](original-figures-gallery.md) for all files.

A previously curated local ZIP contained **43** selected images (13 main and 30 supplementary); it is now superseded by the **66 actual GitHub-hosted uploads**. The historical local import script in `tools/` is optional and **not required** for the currently uploaded images. Do not interpret that old file manifest as an inventory of this repo.

## Provenance and quality

- Every GitHub-uploaded image was moved from the repository root to the new `original-uploads/` folder by reusing its original Git blob SHA. Pixels, compression and statistics were not modified.
- The original screenshots have been renamed to stable `research-figure-###.png` identifiers. Individual scientific identities/contrast names **have not been verified against the image pixels**, so the index intentionally does not invent renamed paths.
- Portfolio diagrams in `results/figures/*.svg` are **new redrawings based on the submitted manuscript/presentation**, not original statistical plots.
- BASE heatmaps encode relative cell-type enrichment scores, not absolute fractions or proportions.

## Portfolio figure priorities

1. RLE normalisation.
2. PCA before/after CPM + TMM.
3. ESTIMATE tumour purity and BASE heatmap.
4. Model 1 (BASE + purity) versus Model 4 (unadjusted) volcano comparisons.
5. Representative adjusted/unadjusted p-value distributions.
6. DAVID / KEGG enrichment interpretation.

See [oral presentation figure map](oral-presentation-figures.md) and [supplementary volcano/p-value guide](supplementary-volcano-gallery.md).

The full original presentation cover and third-party background illustration slides are not included in this gallery. Review user identifiers before changing the repository visibility.
