# Explicit sample identities are required before any main analysis.
# Build the metadata template from real expression-matrix column names.
#
# This template deliberately DOES NOT guess day/treatment from sample order.
prepare_sample_metadata <- function(sample_ids) {
  if (anyDuplicated(sample_ids) || anyNA(sample_ids)) stop("Duplicate/missing sample IDs.")
  data.frame(
    sample_id = sample_ids,
    treatment = NA_character_,
    day = NA_integer_,
    qc_status = ifelse(sample_ids == "AM6_7.1_S30", "exclude", "review"),
    stringsAsFactors = FALSE
  )
}

validate_sample_metadata <- function(metadata, expected_sample_ids) {
  needed <- c("sample_id", "treatment", "day", "qc_status")
  if (!all(needed %in% names(metadata))) stop("Metadata missing required columns.")
  if (anyDuplicated(metadata$sample_id) ||
      !setequal(metadata$sample_id, expected_sample_ids)) {
    stop("Metadata must contain precisely the expression-matrix sample IDs.")
  }
  ok_treatments <- c("Vehicle", "Anti-PD-1", "EPAT", "Anti-PD-1+EPAT")
  if (any(!metadata$treatment %in% ok_treatments)) stop("Unresolved treatment annotations.")
  if (any(!metadata$day %in% c(2L, 5L))) stop("Unresolved sampling day.")
  if (any(!metadata$qc_status %in% c("include", "exclude"))) {
    stop("QC status requires manual verification.")
  }
  metadata[match(expected_sample_ids, metadata$sample_id), , drop = FALSE]
}
