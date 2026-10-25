# Data acquisition and metadata

Raw RNA-seq data are not committed. Source: GEO GSE160788 / BioProject PRJNA674507.

Before executing the reconstructed modules, prepare a verified sample metadata table with columns:

- `sample_id`: exact expression-matrix column name
- `treatment`: one of `Vehicle`, `Anti-PD-1`, `EPAT`, `Anti-PD-1+EPAT`
- `day`: 2 or 5
- `qc_status`: whether the sample is retained or excluded
- `purity`: ESTIMATE-derived purity only after successful ID matching

Do not infer these fields from column order. The thesis reports 39 initial samples and 38 retained samples, but the input sample identities still require independent verification.
