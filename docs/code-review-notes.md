# Code review and editorial notes

This is a transparent inventory of historical code issues noticed during presentation cleanup. The work is a **portfolio curation**, not a new bioinformatics analysis.

## Main selections confirmed

- Filtering threshold used for final thesis: CPM >= 0.5 in >= 3 samples (14,917 genes reported).
- Outlier removed before final downstream comparison: AM6_7.1_S30, leaving 38 samples.
- Final principal immune-score method: BASE, with quanTIseq and other methods explored.
- Four final BASE/purity comparison configurations are shown in later meeting notes and the annotated code.

## Historical code caveats

1. Early snippet uses a CPM >= 1 threshold; it should be read as an earlier code variant, not the thesis final choice.
2. Original annotated code is an interactive session record. Variables such as `new_group`, `mat`, `ses`, `expr_df` and `CPM_TMM` may be assumed from earlier workspaces or named inconsistently.
3. The original RLE/PCA graphics include repeated variants and unfinished plotting snippets. They have been preserved to avoid falsely implying that each plot ran successfully in one clean session.
4. Randomly selected housekeeping controls may need a recorded seed to reproduce exactly.
5. The thesis Methods describes candidate quanTIseq models, while late meeting notes and annotated code centre on four BASE/purity models. This difference is documented rather than silently erased.
6. The original `lmFit` on log2-CPM and covariate handling would require independent model checks for numerical reproducibility. No such review is claimed.
7. Gene-symbol mapping and external DAVID/KEGG enrichment exports require historical reference sources to rerun exactly.

## Curation decisions

The original annotated file is preserved in full at `archive/original_annotated_code.R`. The code in `research-notebook/` has only editorial whitespace/provenance changes relative to the split source, not algorithmic corrections. Its purpose is to demonstrate actual research work, not a production-ready pipeline.

The thesis and meeting slides were used to clarify final methodological choices, but their full documents have not been committed. Selected research plots can be added later with appropriate permissions and attribution.
