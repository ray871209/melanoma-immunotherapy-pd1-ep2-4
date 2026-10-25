# ESTIMATE-derived tumour-purity conversion, as reported in the thesis.
# ESTIMATE itself and mouse-to-human ID mapping require curated inputs.
estimate_score_to_purity <- function(estimate_score) {
  stopifnot(is.numeric(estimate_score), all(is.finite(estimate_score)))
  purity <- cos(0.6049872018 + 0.0001467884 * estimate_score)
  if (any(purity < 0 | purity > 1)) {
    warning("Computed value outside [0, 1]; review ESTIMATE scoring and input scale.")
  }
  purity
}

# Align purity values to an explicit order of sample identifiers.
align_purity <- function(purity, sample_ids) {
  if (is.null(names(purity)) || anyDuplicated(names(purity))) {
    stop("Purity vector needs unique sample ID names.")
  }
  if (!all(sample_ids %in% names(purity))) stop("Missing purity for some samples.")
  unname(purity[sample_ids])
}
