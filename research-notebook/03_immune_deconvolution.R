# Immune deconvolution and BASE exploration
# Historical master's research code, reorganised from original annotated script.
# Original source lines 687-772. Statements and exploratory work preserved.
# NOTE: These sections reflect an interactive RStudio analysis session;
# they may depend on objects created in other sections or prior sessions.
# They are NOT presented as independently executable clean-session scripts.

# -----------------------------------------------------------------------------
# EDITORIAL NOTE
# This file is a historical, interactive R research notebook excerpt.
# Formatting and navigation comments have been cleaned without changing the
# original analytical statements. Blocks may rely on prior session objects.
# The complete original code is preserved in archive/original_annotated_code.R.
# -----------------------------------------------------------------------------

#immune composition
#install.packages("remotes")
#remotes::install_github("omnideconv/immunedeconv")
library(immunedeconv)
library(biomaRt)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggExtra)
#data must be on non-log scale
deconv_data <- 2^human_gene
#the below three method uses mouse data
quantiseq <- deconvolute(deconv_data, "quantiseq")
xcell <- deconvolute(deconv_data, "xcell")
epic <- deconvolute(deconv_data, "epic")
#correlation uncharacterized cell from quatiseq and tumour purity
uncharacterized <- quantiseq[quantiseq$cell_type == "uncharacterized cell", -1]
# make it numeric vector
uncharacterized <- as.numeric(uncharacterized)
# align tumour purity by sample order
purity <- update_tumor_purity[colnames(quantiseq)[-1]]
# correlation
cor_uncell <- cor(uncharacterized, purity, method = "pearson")

# test with p-value
cor_test <- cor.test(uncharacterized, purity, method = "pearson")
cor_uncell
cor_test

#however result not good so turn to BASE which uses mice gene symbol:
# Connect to Ensembl Mouse
mart <- useMart("ensembl", dataset = "mmusculus_gene_ensembl")
# Get mapping from Ensembl to MGI
gene_map <- getBM(attributes = c("ensembl_gene_id", "mgi_symbol"), mart = mart)


cpm_data_ <- left_join(cpm_data, gene_map, by = "ensembl_gene_id")
deconv_data_mouse <- 2^( cpm_data_mgi)

# run mmcp_counter
mmcp_counter <- deconvolute_mouse(deconv_data_mouse, method = "mmcp_counter")
#run base
base <- deconvolute_mouse(deconv_data_mouse, method = "base")

# PCA on BASE
pca_result <- prcomp(t(base), scale. = TRUE)
pca_data <- as.data.frame(pca_result$x)
pca_data$Group  <- group
#day 2 and day 5
pca_data$Day    <- batch_info
pca_data$Sample <- colnames(base)

# PC1 and PC2
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

pca <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group, shape = Day)) +
  geom_point(size = 3) +
  labs(title = "PCA (BASE) labeled by treatment group and day", x = paste0("PC1 (", pc1_var, "%)"), y = paste0("PC2 (", pc2_var, "%)")) +
  theme_minimal() +
  theme(legend.title = element_text(size = 10), legend.text  = element_text(size = 8))

# Marginal densities (same as before)
pca_marginal <- ggMarginal(pca, type = "density", groupColour = TRUE, groupFill   = TRUE)

#generate heatmap for base
library(pheatmap)
library(tibble)

mat <- base %>% column_to_rownames("cell_type") %>% as.matrix()
ann_col <- data.frame(Group = group, row.names = colnames(mat))

pheatmap(
  mat,
  scale = "row",
  annotation_col = ann_col,
  show_colnames = TRUE,
  show_rownames = TRUE,
  fontsize_row = 8,
  fontsize_col = 7,
  cluster_cols = FALSE,     # keep sample order; no tree on x-axis
  clustering_method = "average",
  border_color = NA,
  main = "Immune Cell Composition (BASE)")
