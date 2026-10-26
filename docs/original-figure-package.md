# Original research figure package

The author supplied **43 original PNG images**, grouped as:

- **13 main figures**: RLE comparison, PCA, tumour-purity estimates, BASE immune-score heatmap, representative volcano plots, p-value distribution, and pathway-effect plot.
- **30 supplementary figures**: six contrasts for each of adjusted, unadjusted, adjusted with positive/negative controls, and unadjusted with controls (24 volcano plots), plus six additional p-value distributions.

The complete figure ZIP is provided separately in the ChatGPT conversation and is not a GitHub-hosted file.

## Source image integrity

These files are copies of the original research graphics as provided by the author. Do not recolour points, change axis ranges, regenerate statistics or make a volcano plot with synthetic data. The BASE heatmap consists of relative immune-cell enrichment scores, **not** cellular fractions.

The author requested a short main README, with supplementary figures in a separate gallery. The main README should highlight:

1. RLE normalisation comparison.
2. PCA before and after CPM/TMM normalisation.
3. ESTIMATE tumour-purity bar chart and BASE heatmap.
4. Comparison of combination versus vehicle volcano plots (Model 1 adjusted versus Model 4 unadjusted).
5. Combination versus vehicle p-value distribution.
6. Historical KEGG enrichment table and pathway-level effect plot.

The full six-contrast adjusted/unadjusted and control-highlighting sets belong in `supplementary/`. See [supplementary gallery](supplementary-volcano-gallery.md).

## Importing the image package

The GitHub-connected tool currently supports editing repository text but cannot directly read the binary contents of the local ZIP. To upload the PNGs without manually attaching 43 files:

1. Clone this private repository to your local machine.
2. Download and unzip *nothing*: the importer directly reads `melanoma_research_figures_complete.zip`.
3. Run `python3 tools/import_research_figures.py /path/to/melanoma_research_figures_complete.zip`.
4. Review the copied images and use `git add results/figures`, `git commit`, and `git push`.

The importer validates the exact 43-file manifest and copies binary bytes unchanged; it does not push or change repository permissions. Until that step, **the PNG images have not been committed** and README links to them must not be enabled.

## Privacy

Only the research plots should be published. The full thesis or presentation cover includes student identifiers and the presentation background slides also contain third-party artwork; neither is included in the figure ZIP.
