# Summarise exported KEGG/DAVID enrichment results.
# This does NOT query DAVID or reproduce the historical enrichment test.
#
# Input: a TSV/CSV with pathway names and numeric FDR/q-values;
# required columns are configurable, because DAVID exports vary.
filter_enrichment_results <- function(tbl, term_col = "Term",
                                      fdr_col = "FDR",
                                      count_col = "Count",
                                      max_fdr = 0.05, min_genes = 4L) {
  if (!is.data.frame(tbl)) stop("Expected data.frame.")
  required <- c(term_col, fdr_col, count_col)
  if (!all(required %in% names(tbl))) stop("Missing required pathway columns.")
  p <- suppressWarnings(as.numeric(tbl[[fdr_col]]))
  n <- suppressWarnings(as.integer(tbl[[count_col]]))
  if (anyNA(p) || anyNA(n)) {
    stop("FDR and Count must be numeric: review export formatting.")
  }
  if (any(p < 0 | p > 1) || any(n < 0)) stop("Invalid FDR/count.")
  keep <- p < max_fdr & n >= min_genes
  result <- tbl[keep, , drop = FALSE]
  result[order(as.numeric(result[[fdr_col]])), , drop = FALSE]
}

# Historical analysis note:
# Exact enrichment reconstruction requires gene universe, ID conversion,
# DE significance threshold, mouse/human database selection, DAVID version,
# pathway catalog date and testing parameters. Do not present a filtered
# exported table as a fresh enrichment computation.
