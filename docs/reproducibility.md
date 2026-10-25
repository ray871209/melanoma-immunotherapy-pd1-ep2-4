# Reproducibility and code review checklist

**Status:** Initial audit only. No full rerun has been performed.

## Items requiring verification

- [ ] Obtain the GEO raw count matrix and verify shape (39,179 genes x 39 samples per thesis).
- [ ] Establish explicit sample metadata instead of a hard-coded group vector without sample IDs.
- [ ] Confirm day-2/day-5 membership and treatment-group alignment for every sample.
- [ ] Apply CPM >= 0.5 in >= 3 samples and independently verify the reported 14,917 retained genes.
- [ ] Check how missing identifiers and one-to-many human ortholog mappings are handled.
- [ ] Confirm numeric expression matrix, ordered sample IDs and covariate alignment at every analysis stage.
- [ ] Rebuild PCA and RLE code with consistent object names.
- [ ] Identify BASE outputs and confirm whether scores or fractions are used; check collinearity/rank of covariate model.
- [ ] Examine limma design, mean-variance treatment, robust eBayes, contrast definitions and multiplicity adjustment.
- [ ] Fix random seeds for randomly selected housekeeping controls.
- [ ] Reproduce reported control-gene statistics and enrichment tables.
- [ ] Record R and Bioconductor package versions from original execution where known.
- [ ] Capture figure-generation scripts and verify key plots against thesis appendix.
- [ ] Separate historical results from new rerun results.
- [ ] Check rights/attribution before publishing supplementary tables or figures.

## Initial code issues found

1. Early exploratory gene-filtering line uses CPM >= 1, whereas the final criterion is CPM >= 0.5.
2. PCA and RLE sections contain repeated variants and references to inconsistent variables (for example `mat`, `matrix`, `seqex`, `ses`).
3. Early purity/ortholog conversion lines reference objects not constructed in that contiguous block.
4. The selection of 32 housekeeping controls uses `sample()` without an evident seed in the inspected section.
5. Script execution appears to rely partly on pre-existing R-session objects. A clean-session run must be a separate acceptance criterion.

These observations are **code-audit flags**, not proof that the original thesis results are wrong.

## Data policy

Do not commit FASTQ/BAM, full count matrices, R workspace caches, local paths, private data, credentials or downloaded dependencies to Git. Only add small non-sensitive examples if licensing permits.
