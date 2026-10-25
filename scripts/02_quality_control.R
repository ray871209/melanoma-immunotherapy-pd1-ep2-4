# Quality-control plots for a named gene x sample log2CPM matrix.
# Function-only module. Intended for use after sample metadata are validated.
plot_pca_qc <- function(log_cpm, metadata, colour_by = "treatment") {
  stopifnot(is.matrix(log_cpm), is.numeric(log_cpm))
  stopifnot(all(c("sample_id", colour_by) %in% names(metadata)))
  stopifnot(!anyDuplicated(metadata$sample_id), !anyDuplicated(colnames(log_cpm)))
  if (!identical(as.character(metadata$sample_id), colnames(log_cpm))) {
    stop("Metadata must match log_cpm columns in exactly the same order.")
  }
  if (anyNA(log_cpm) || any(!is.finite(log_cpm))) stop("Invalid expression values.")
  if (!requireNamespace("ggplot2", quietly = TRUE)) stop("Install ggplot2.")
  pcs <- stats::prcomp(t(log_cpm), scale. = FALSE)
  d <- data.frame(PC1 = pcs$x[, 1], PC2 = pcs$x[, 2],
                  group = metadata[[colour_by]])
  var_explained <- 100 * pcs$sdev^2 / sum(pcs$sdev^2)
  ggplot2::ggplot(d, ggplot2::aes(x = PC1, y = PC2, colour = group)) +
    ggplot2::geom_point(size = 2.5) +
    ggplot2::labs(x = sprintf("PC1 (%.1f%%)", var_explained[1]),
                  y = sprintf("PC2 (%.1f%%)", var_explained[2]),
                  colour = colour_by) +
    ggplot2::theme_minimal()
}

# Conventional RLE calculation from log-expression.
calculate_rle <- function(log_cpm) {
  stopifnot(is.matrix(log_cpm), is.numeric(log_cpm))
  medians <- matrixStats::rowMedians(log_cpm, na.rm = TRUE)
  sweep(log_cpm, 1, medians, FUN = "-")
}
