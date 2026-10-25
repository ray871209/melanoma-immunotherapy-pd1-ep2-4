# 01_preprocessing.R
# Thesis-grounded preprocessing starter (not independently validated).
#
# Input: raw gene-by-sample count table. The gene IDs should be row names
# and the columns should be sample IDs. Sample metadata are required separately.
#
# Final thesis criterion: CPM >= 0.5 in >= 3 samples.
# Expected historical filtered gene count reported in thesis: 14,917.
#
# Usage after reviewing and specifying the local input path:
# Rscript scripts/01_preprocessing.R path/to/raw_count_matrix.tsv
#
# This script intentionally stops if the input does not satisfy assumptions.
# It does not reproduce treatment assignments from the annotated code.

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1L) {
  stop("Usage: Rscript scripts/01_preprocessing.R <raw_count_matrix.tsv>")
}

if (!requireNamespace("edgeR", quietly = TRUE)) {
  stop("Install edgeR through BiocManager before running.")
}

raw_counts <- read.delim(
  args[[1]],
  header = TRUE,
  row.names = 1,
  check.names = FALSE
)
raw_counts <- as.matrix(raw_counts)

if (!is.numeric(raw_counts)) {
  stop("Counts must be numeric. Check the file columns and gene ID format.")
}
if (anyNA(raw_counts) || any(!is.finite(raw_counts)) || any(raw_counts < 0)) {
  stop("Counts contain missing, non-finite or negative values.")
}
if (any(raw_counts != floor(raw_counts))) {
  stop("Raw count matrix must contain non-negative integer counts.")
}
if (anyDuplicated(rownames(raw_counts)) || anyDuplicated(colnames(raw_counts))) {
  stop("Gene IDs and sample IDs must be unique.")
}
if (any(colSums(raw_counts) == 0)) {
  stop("At least one sample has zero library size.")
}

keep <- rowSums(edgeR::cpm(raw_counts) >= 0.5) >= 3L
filtered_counts <- raw_counts[keep, , drop = FALSE]
dge <- edgeR::DGEList(counts = filtered_counts)
dge <- edgeR::calcNormFactors(dge, method = "TMM")
log_cpm <- edgeR::cpm(dge, log = TRUE)

message("Samples: ", ncol(raw_counts))
message("Genes before filtering: ", nrow(raw_counts))
message("Genes after filtering: ", nrow(filtered_counts))
message("Thesis reports 14,917 retained genes; compare and investigate discrepancies.")

# Objects are intentionally not written to disk until the exact input file and
# sample metadata are confirmed; downstream scripts will use verified outputs.
