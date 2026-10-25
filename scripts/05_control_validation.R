# Control-gene validation — reconstructed utility, not historical rerun.
# For each gene, compare treatment with Vehicle using Wilcoxon rank-sum test.
# Input: genes x samples log2CPM, metadata in identical sample order.
validate_control_genes <- function(log_cpm, metadata, gene_ids, treatment) {
  stopifnot(is.matrix(log_cpm), is.numeric(log_cpm))
  stopifnot(all(c("sample_id", "treatment") %in% colnames(metadata)))
  if (!identical(colnames(log_cpm), as.character(metadata$sample_id))) {
    stop("Sample metadata and expression columns must match in order.")
  }
  if (!treatment %in% c("Anti-PD-1", "EPAT", "Anti-PD-1+EPAT")) {
    stop("Unknown treatment.")
  }
  ids <- intersect(unique(gene_ids), rownames(log_cpm))
  if (!length(ids)) stop("None of the requested control genes are present.")
  t_ix <- which(metadata$treatment == treatment)
  v_ix <- which(metadata$treatment == "Vehicle")
  if (length(t_ix) < 2 || length(v_ix) < 2) stop("Insufficient samples per group.")
  results <- lapply(ids, function(g) {
    x <- as.numeric(log_cpm[g, t_ix])
    y <- as.numeric(log_cpm[g, v_ix])
    data.frame(gene_id = g,
      p_value = stats::wilcox.test(x, y, exact = FALSE)$p.value,
      median_difference = stats::median(x) - stats::median(y))
  })
  out <- do.call(rbind, results)
  out$p_adjusted_BH <- stats::p.adjust(out$p_value, method = "BH")
  rownames(out) <- NULL
  out
}

# For reproducible housekeeping sampling, preserve both selected IDs and seed.
choose_housekeeping_controls <- function(candidate_ids, n = 32L, seed = 2025L) {
  ids <- unique(as.character(candidate_ids))
  if (length(ids) < n) stop("Insufficient unique housekeeping candidates.")
  set.seed(seed)
  sample(ids, n, replace = FALSE)
}

# Diagnostic against Uniform(0,1); a KS p-value is not evidence of uniformity.
ks_pvalue_diagnostic <- function(p_values) {
  if (!is.numeric(p_values) || anyNA(p_values) ||
      any(p_values < 0 | p_values > 1)) stop("Invalid p-values.")
  stats::ks.test(p_values, "punif")
}
