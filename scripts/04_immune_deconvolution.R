# Immune-deconvolution result preparation, NOT deconvolution re-execution.
# BASE output from immunedeconv: first column 'cell_type',
# remaining columns named by sample ID. Its enrichment scores are NOT fractions.
align_base_scores <- function(base_result, sample_ids) {
  if (!"cell_type" %in% names(base_result)) stop("Expected a cell_type column.")
  if (anyDuplicated(base_result$cell_type)) stop("Duplicate cell type names.")
  if (!all(sample_ids %in% colnames(base_result))) stop("Missing BASE sample columns.")
  x <- as.matrix(base_result[, sample_ids, drop = FALSE])
  if (!is.numeric(x) || any(!is.finite(x))) stop("BASE scores must be finite numeric values.")
  rownames(x) <- base_result$cell_type
  t(x)  # samples x cell types
}

# quanTIseq output requires human symbols and a separately verified gene
# expression input; the uncharacterized-cell category should not be
# silently discarded without recording the renormalisation method.
