# Reconstructed models from the annotated script (NOT independently rerun).
# Expression: genes x samples, named columns with log2 CPM values.
# Metadata: sample_id, treatment, purity plus independently checked BASE score table.
# Treatment categories are deliberately assigned to stable contrast-safe names.
#
# WARNING: The thesis Methods documents six models, including quanTIseq.
# The annotated R script explicitly implements four BASE/purity model variants.
# Their numbering differs. This module reproduces the FOUR SCRIPT SPECIFICATIONS,
# not all six thesis models. See docs/methodology.md.
#
# Important statistical caveat: unweighted lmFit on logCPM is retained here
# only to reflect the historical script. Verify variance modelling (e.g., voom)
# and potential covariate collinearity before inferential use.

fit_script_models <- function(log_cpm, metadata, base_scores) {
  if (!requireNamespace("limma", quietly = TRUE)) stop("Install limma.")
  if (!is.matrix(log_cpm) || !is.numeric(log_cpm)) stop("Numeric expression matrix required.")
  required <- c("sample_id", "treatment", "purity")
  if (!all(required %in% colnames(metadata))) stop("Missing required metadata columns.")
  samples <- colnames(log_cpm)
  if (anyDuplicated(samples) || !identical(as.character(metadata$sample_id), samples)) {
    stop("Metadata sample IDs must exactly match expression column names in order.")
  }
  if (!is.matrix(base_scores) || !is.numeric(base_scores) ||
      !identical(rownames(base_scores), samples)) {
    stop("BASE matrix must be numeric and have ordered sample IDs as row names.")
  }
  if (nrow(base_scores) != ncol(log_cpm) || ncol(base_scores) < 1L) stop("Invalid BASE dimensions.")
  if (anyNA(log_cpm) || any(!is.finite(log_cpm)) || anyNA(metadata[, required]) || anyNA(base_scores)) {
    stop("Missing values are not supported.")
  }
  treatment <- factor(as.character(metadata$treatment),
                      levels = c("Vehicle", "Anti-PD-1", "EPAT", "Anti-PD-1+EPAT"),
                      labels = c("Vehicle", "AntiPD1", "EPAT", "Combo"))
  if (anyNA(treatment) || any(table(treatment) == 0)) {
    stop("All four defined treatment groups must be present and consistently spelled.")
  }
  purity <- as.numeric(metadata$purity)
  if (any(!is.finite(purity)) || any(!is.finite(base_scores))) stop("Invalid covariates.")
  cell <- as.data.frame(base_scores, check.names = FALSE)
  names(cell) <- make.names(paste0("BASE_", names(cell)), unique = TRUE)
  cov <- data.frame(treatment = treatment, purity = purity, cell, check.names = FALSE)

  model_covariates <- list(
    script_model_1_BASE_purity = c("purity", names(cell)),
    script_model_2_BASE = names(cell),
    script_model_3_purity = "purity",
    script_model_4_treatment = character(0)
  )
  contrast_defs <- c(
    AntiPD1_vs_Vehicle = "treatmentAntiPD1 - treatmentVehicle",
    EPAT_vs_Vehicle = "treatmentEPAT - treatmentVehicle",
    Combo_vs_Vehicle = "treatmentCombo - treatmentVehicle",
    AntiPD1_vs_EPAT = "treatmentAntiPD1 - treatmentEPAT",
    Combo_vs_EPAT = "treatmentCombo - treatmentEPAT",
    Combo_vs_AntiPD1 = "treatmentCombo - treatmentAntiPD1"
  )
  result <- list()
  for (nm in names(model_covariates)) {
    d <- cov[, c("treatment", model_covariates[[nm]]), drop = FALSE]
    design <- stats::model.matrix(~ 0 + ., data = d)
    if (qr(design)$rank < ncol(design)) {
      stop("Rank-deficient design for ", nm,
           ". Check BASE collinearity, purity, and sample count.")
    }
    contrasts <- limma::makeContrasts(contrasts = unname(contrast_defs), levels = design)
    colnames(contrasts) <- names(contrast_defs)
    fit <- limma::eBayes(limma::contrasts.fit(limma::lmFit(log_cpm, design), contrasts),
                         robust = TRUE)
    result[[nm]] <- list(design = design, contrasts = contrasts, fit = fit)
  }
  result
}

extract_contrast_table <- function(model_output, contrast_name) {
  if (!contrast_name %in% colnames(model_output$contrasts)) stop("Unknown contrast.")
  limma::topTable(model_output$fit, coef = contrast_name,
                  number = Inf, adjust.method = "BH")
}
