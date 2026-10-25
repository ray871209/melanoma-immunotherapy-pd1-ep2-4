# Differences identified between thesis and annotated code

**Do not silently reconcile these.**

## Sample set

The thesis reports 39 starting samples and 38 following QC outlier removal. A sample-ID keyed metadata sheet and specific removed sample must be checked against the raw GEO expression columns. Neither position in a hard-coded group vector nor library-size vector alone is sufficient.

## Filtering

Final user-confirmed threshold: CPM >= 0.5 in >= 3 samples. An early annotated-code block uses CPM >= 1; excluded from final pipeline.

## limma models

The thesis Methods section describes **six** model formulas: BASE+purity, purity-only, BASE-only, quanTIseq+purity, quanTIseq-only, and treatment-only.

The annotated script section explicitly labels **four** models:
1. treatment + BASE + purity
2. treatment + BASE
3. treatment + purity
4. treatment only

This is not a one-to-one correspondence with the thesis model numbering. A script-level reimplementation is provided in scripts/06_differential_expression.R, with names prefixed `script_model_`. The quanTIseq models are not silently represented as run or verified.

## Caveats requiring investigation

- The script uses `lmFit` on logCPM; independent review of mean-variance modelling is needed.
- Adding many correlated BASE cell scores and purity risks rank-deficient or unstable design matrices with 38 samples.
- Sample metadata alignment is enforced explicitly; historical manual vector assignments should be replaced.
- A model's successful execution alone does not establish correct experimental control for collection day or treatment interaction.
- More than one ortholog may map to a human gene symbol, and duplicates require a documented policy.

## Status

This is a reconstruction for code review. No claims of exact agreement with thesis plots, adjusted p-values or DE gene counts are made.
