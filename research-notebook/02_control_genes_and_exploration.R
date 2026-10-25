# Control genes, RUV exploration, and validation
# Historical master's research code, reorganised from original annotated script.
# Original source lines 327-686. Statements and exploratory work preserved.
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

##Selecting Negative Control Genes
housekeeping <- kv <- read.delim("HOUNKPE_HOUSEKEEPING_GENES.v2024.1.Mm.tsv", sep      = "\t", header   = FALSE,)

#check negative control list and their unique id
housekeeping_list <- housekeeping$V2[kv$V1 == "SOURCE_MEMBERS"]
housekeeping_list
housekeeping_genes <- strsplit(housekeeping_list, ",")
housekeeping_genes
neg_control <- conversion[conversion$external_gene_name %in% housekeeping_genes, ]
length(unique(neg_control$ensembl_gene_id))

matrix_cpm_tmm <- as.matrix(cpm_data)
#look for bottom 15% of gene in variance - 2238 genes
stable_gene <- names(sort(rowVars(matrix_cpm_tmm)))[1:2238]
new_neg_control <- intersect(neg_control$ensembl_gene_id, stable_gene)
ctl <- rownames(matrix_update_cpm_tmm) %in% new_neg_control
#test on RUVg where it accept negative control
ruv <- RUVg(matrix_update_cpm_tmm, ctl, k = 3, isLog = TRUE)
W1 <- ruv$W[,1]
W2 <- ruv$W[,2]
W3 <- ruv$W[,3]
cor(W1, update_tumor_purity)
cor(W2, update_tumor_purity)
cor(W3, update_tumor_purity)

##try with k = 2
ruv_2 <- RUVg(matrix_cpm_tmm, ctl, k = 2, isLog = TRUE)
cor(ruv_2$W[,1], update_tumor_purity)
cor(ruv_2$W[,2], update_tumor_purity)
ruv_output <- ruv_2[["normalizedCounts"]]

##try with bottom 15% only
control <- rownames(matrix_cpm_tmm) %in% stable_gene
ruv_3 <- RUVg(matrix_cpm_tmm, control, k = 3, isLog = TRUE)
cor(ruv_3$W[,1], update_tumor_purity)
cor(ruv_3$W[,2], update_tumor_purity)
cor(ruv_3$W[,3], update_tumor_purity)

#try bottom 20% and negative control intesect
stable_gene_2 <- names(sort(rowVars(matrix_cpm_tmm)))[1:2984]
new_neg_control_2 <- intersect(neg_control$ensembl_gene_id, stable_gene)
ctl_2 <- rownames(matrix_update_cpm_tmm) %in% new_neg_control_2
ruv_4 <- RUVg(matrix_update_cpm_tmm, ctl_2, k = 3, isLog = TRUE  )
W_1 <- ruv_4$W[,1]
W_2 <- ruv_4$W[,2]
W_3 <- ruv_4$W[,3]
cor(W_1, update_tumor_purity)
cor(W_2, update_tumor_purity)
cor(W_3, update_tumor_purity)

#############################################
# RUV-PRPS
#make a list of pseudo replicate list
pseudo_list_prps <- list(
  d2_Combine_high = c("AM6_8.2_S33","AM6_8.3_S38"),
  d2_Combine_low = c("AM6_8.1_S7","AM6_8.4_S9","AM6_8.5_S14"),
  d2_Anti_PD_1_high = c("AM6_4.2_S16","AM6_4.3_S24"),
  d2_Anti_PD_1_low = c("AM6_4.1_S18","AM6_4.4_S13","AM6_4.5_S25"),
  d2_EPAT_high = c("AM6_5.3_S6","AM6_6.5_S8","AM6_5.4_S36"),
  d2_EPAT_low = c("AM6_5.1_S19","AM6_5.2_S1"),
  d2_Vehicle_high = c("AM6_2.2_S15","AM6_2.3_S39","AM6_2.4_S2"),
  d2_Vehicle_low = c("AM6_2.1_S5","AM6_2.5_S31"),
  d5_Combine_high = c("AM6_7.5_S35"),
  d5_Combine_low = c("AM6_7.2_S3","AM6_7.3_S34","AM6_7.4_S20"),
  d5_Anti_PD_1_high = c("AM6_3.1_S27","AM6_3.2_S26"),
  d5_Anti_PD_1_low = c("AM6_3.4_S11","AM6_3.5_S23"),
  d5_EPAT_high = c("AM6_6.1_S32","AM6_6.2_S17"),
  d5_EPAT_low = c("AM6_6.3_S12","AM6_5.5_S29","AM6_6.4_S37"),
  d5_Vehicle_high  = c("AM6_1.1_S21","AM6_1.2_S28","AM6_1.4_S4","AM6_1.5_S10"),
  d5_Vehicle_low = c("AM6_1.3_S22")
  )

info <- data.frame(treatment = group, day = batch_info, purity = tumor_purity, row.names = samples, stringsAsFactors = FALSE)

se <- SummarizedExperiment( assays  = list(TMM_CPM = matrix_cpm_tmm), colData = DataFrame(info))

## PRPS (supervised)
se <- createPrPsSupervised(
  se.obj = se,
  assay.name = "TMM_CPM",
  bio.variables = "treatment",
  uv.variables = "purity",
  apply.other.uv.variables = FALSE,
  min.sample.for.ps = 2,
  prps.group.name = "purity_group",
  save.se.obj = TRUE)

## negative-control genes --------------------
neg_index <- which(rownames(se) %in% new_neg_control)

se <- addNCGs(se.obj = se, ncg  = ncg_index, subset.name = "Negative_control")
metadata(se)$NCG$supervised <- metadata(se)$NCG$pre.selected

##Run RUV-III-PRPS
se_norm <- RUVIIIprps(
  se.obj = se,
  assay.name = "TMM_CPM",
  control.assay.type = "prps",
  prps.type = "supervised",
  prps.group  = "purity_group",
  ncg.type  = "pre.selected",
  ncg.group  = "Negative_control",
  k  = 1,
  apply.log = FALSE,
  data.to.log = "assay",
  return.info = TRUE,
  save.se.obj = TRUE)

# Extract unwanted factor
norm_counts <- assay(se_norm, "RUVIIIPRPS_K_1")
W_factors   <- metadata(se_norm)$W

##EPAT positive control genes
library(ggplot2)
library(ggforce)
library(reshape2)
epat_positive_control <- c( "CCL19","CCL3","CCL5","CD14","CD38","CLEC5A","CRP","CSF2","CSF3","CXCL10", "CXCL11","CYR61","EDN1","EREG","FCAR","HIF3A","HLA-DRA","IFNG","IL1A","IL1B", "IL12A","IL12B","IL17A","IL18","IL1RL1","IL3","IL6","ITGAM","JAK2","KLK15", "KLK2","KLK3","LTB4R2_A","MMP9","NCAM1","NCR1","NOS2","PDE4C","PGK1","PLA2G1B", "PLA2G2A","PLA2G2D","PLA2G5","PRKAA2","PTGER3","PTGS2","SELE","STAT1","STAT2", "TLR4","TLR7","TNFSF10","TNFSF13B","VEGFC")

# Map gene symbols to Ensembl
epat1 <- toupper(conversion$external_gene_name) %in% toupper(epat_positive_control)
EPAT_ensembl  <- conversion$ensembl_gene_id[epat1]
EPAT_gene_map <- conversion[epat1, ]

# get CPM data by Ensembl IDs
EPAT_gene <- update_cpm_data[rownames(cpm_data) %in% EPAT_ensembl, , drop = FALSE]

EPAT_gene_t <- as.data.frame(t(EPAT_gene=))
EPAT_gene_t$Group <- group
EPAT_long <- melt(EPAT_gene_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

#boxplots in one page
ggplot(EPAT_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  facet_wrap(~ Gene, scales = "free_y", ncol = 4) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of EPAT-Upregulated Genes Across Treatment Groups",
  x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")

# with page 1 page 2
ggplot(EPAT_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  ggforce::facet_wrap_paginate(~ Gene, scales = "free_y", ncol = 2, nrow = 4, page = 1) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of EPAT-Upregulated Genes (Page 1)",
  x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")

# Combined
ggplot(EPAT_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  theme_minimal(base_size = 12) +
  labs(title = "Combined Expression of EPAT-Upregulated Genes",
   x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Anti-PD-1 positive control genes
anti_PD1_positive <- c( "TBX21","STAT1","IRF1","TNF","IFNG", "CD8A","CD8B","ITGAE","PDCD1","CCL5","CXCL13","IL2", "CD247","CD5","CD6","CD69", "CD96", "GZMK","CD274","CD2","ITGAL", "CCL4","CCR5","CXCL9", "CXCL10","CXCL11", "GZMB","PRF1","GZMA", "CD4", "H2-K1","H2-D1","B2M")

apd1 <- toupper(conversion$external_gene_name) %in% toupper(anti_PD1_positive)
antiPD1_ensembl  <- conversion$ensembl_gene_id[apd1]
antiPD1_gene_map <- conversion[apd1, ]
antiPD1_gene     <- update_cpm_data[rownames(cpm_data) %in% antiPD1_ensembl, , drop = FALSE]

antiPD1_gene_t <- as.data.frame(t(antiPD1_gene))
antiPD1_gene_t$Group <- group
antiPD1_long <- melt(antiPD1_gene_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

# boxplots in one page
ggplot(antiPD1_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  facet_wrap(~ Gene, scales = "free_y", ncol = 4) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of Anti-PD-1-Upregulated Genes Across Treatment Groups",
  x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")

# with page 1 page 2
ggplot(antiPD1_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  ggforce::facet_wrap_paginate(~ Gene, scales = "free_y", ncol = 2, nrow = 4, page = 4) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of Anti-PD-1-Upregulated Genes (Page 4)",
  x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")

# Combined
ggplot(antiPD1_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  theme_minimal(base_size = 12) +
  labs(title = "Combined Expression of Anti-PD-1-Upregulated Genes",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# pick 32 random genes from housekeeping gene list for negative control genes
random_neg32 <- neg_control[sample(nrow(neg_control), 32), ]
NEG32_ensembl <- random_neg32$ensembl_gene_id
NEG32_gene <- update_cpm_data[rownames(cpm_data) %in% NEG32_ensembl, , drop = FALSE]

NEG32_gene_t <- as.data.frame(t(NEG32_gene))
NEG32_gene_t$Group <- update_group
NEG32_long <- melt(NEG32_gene_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

# Pages 1-2
ggplot(NEG32_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  ggforce::facet_wrap_paginate(~ Gene, scales = "free_y", ncol = 4, nrow = 4, page = 1) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of 32 Random Negative Control Genes (Page 1)",
  x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")

ggplot(NEG32_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  ggforce::facet_wrap_paginate(~ Gene, scales = "free_y", ncol = 4, nrow = 4, page = 2) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of 32 Random Negative Control Genes (Page 2)",
  x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")

ggplot(NEG32_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  theme_minimal(base_size = 12) +
  labs(title = "Combined expression of 32 Random Negative Control Genes",
  x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


##Mann–Whitney on NEG32_long by group
anti_pd1_label <- "Anti-PD-1"
epat_label     <- "EPAT"
vehicle_label  <- "Vehicle"

results <- data.frame(
  Gene = character(),
  Comparison = character(),
  P_value = numeric(),
  stringsAsFactors = FALSE
)

for (gene in unique(NEG32_long$Gene)) {
  gene_data <- subset(NEG32_long, Gene == gene)
  x1 <- gene_data$Expression[gene_data$Group == anti_pd1_label]
  x2 <- gene_data$Expression[gene_data$Group == vehicle_label]
  if (length(x1) > 0 & length(x2) > 0) { p1 <- wilcox.test(x1, x2, exact = FALSE)$p.value
    results <- rbind(results, data.frame(Gene = gene, Comparison = "Anti-PD-1_vs_Vehicle", P_value = p1))
  }

sig_anti_pd1 <- mean(results$P_value[results$Comparison == "Anti-PD-1_vs_Vehicle"] < 0.05, na.rm = TRUE)
sig_epat     <- mean(results$P_value[results$Comparison == "EPAT_vs_Vehicle"] < 0.05, na.rm = TRUE)
sig_anti_pd1_total <- sum(results$P_value[results$Comparison == "Anti-PD-1_vs_Vehicle"] < 0.05, na.rm = TRUE)
sig_epat_total     <- sum(results$P_value[results$Comparison == "EPAT_vs_Vehicle"] < 0.05, na.rm = TRUE)
sig_results <- subset(results, P_value < 0.05)
anti_pd1_results <- subset(results, Comparison == "Anti-PD-1_vs_Vehicle")
epat_results     <- subset(results, Comparison == "EPAT_vs_Vehicle")
anti_pd1_pvals <- anti_pd1_results$P_value
epat_pvals     <- epat_results$P_value

# P-value distribution
bins <- seq(0, 1, by = 0.05)
pval_counts_anti <- data.frame(pvalue = anti_pd1_pvals)
ggplot(pval_counts_anti, aes(x = Bin, y = Count)) +
  geom_bar(stat = "identity") +
  labs(title = "Histogram of p-values (Anti-PD-1 vs Vehicle)",
  x = "p-value range", y = "Count") +
  theme_minimal(base_size = 15) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

pval_counts_epat <- data.frame(pvalue = epat_pvals)
ggplot(pval_counts_epat, aes(x = Bin, y = Count)) +
  geom_bar(stat = "identity") +
  labs(title = "Histogram of p-values (EPAT vs Vehicle)",
  x = "p-value range", y = "Count") +
  theme_minimal(base_size = 15) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## Anti-PD-1 from literature
antiPD1_upregulated <- c("IFNG","TNF","IL6","IL1B","IFNA2","IFNB1","STAT1","NFKBIA","IKBKB","IKBKG","RELA","CHUK","IL12A","IL12B","IL21","IL27","IL18","IL2","TLR4","TLR7","IFNAR1","IRF3","IRF7","CXCL12","CD44","CD3","NOS2","CSF2","CSF3","TNFSF10","EBI3","SPI1","ITK")

antiPD1_positive_genes <- c( "Cd44","Chuk","Cxcl12","Ebi3","Ifnar1","Ifng","Ikbkb","Ikbkg","Il12b","Il18","Il1b","Il2","Il27","Il6","Irf3","Irf7","Itk","Nfkbia","Nos2","Rela","Spi1","Stat1","Tlr4","Tlr7","Tnf","Tnfsf10","Cd28","Irf1","Myd88","Tbx21","Tlr3","Cxcl10")

PD1_markers <- c("Ifnar1","Ifng","Ikbkb","Il12b","Il18","Il2","Irf3","Irf7","Nfkbia","Nos2","Rela","Stat1","Tlr4","Tlr7","Tnf","Tnfsf10" )

upregulated_in_PD1_literature <- c("MYD88","TBX21","TLR3","IRF1","TLR9","CD28")

# Map to Ensembl
pos <- tolower(conversion$external_gene_name) %in% tolower(antiPD1_positive_genes)
positive_genes_ensembl <- conversion$ensembl_gene_id[pos]

cpm_subset <- cpm_data[rownames(cpm_data) %in% positive_genes_ensembl, , drop = FALSE]
gene_names <- conversion$external_gene_name[match(rownames(cpm_subset), conversion$ensembl_gene_id)]
rownames(cpm_subset) <- gene_names

cpm_t <- as.data.frame(t(cpm_subset))
cpm_t$Group <- update_group
long_data <- melt(cpm_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

results <- data.frame(Gene = character(), P_value = numeric(), stringsAsFactors = FALSE)
for (gene in unique(long_data$Gene)) {
  dat_g <- subset(long_data, Gene == gene)
  x1 <- dat_g$Expression[dat_g$Group == "Anti-PD-1"]
  x2 <- dat_g$Expression[dat_g$Group == "Vehicle"]
  if (length(x1) > 0 & length(x2) > 0) { p1 <- wilcox.test(x1, x2, exact = FALSE)$p.value
    results <- rbind(results, data.frame(Gene = gene, P_value = p1))
  }}

print(results[results$P_value < 0.05, ])


for (page_num in 1:4) {
  print(
    ggplot(antiPD1_long, aes(x = Group, y = Expression, fill = Group)) +
    geom_boxplot(outlier.size = 0.5) +
    ggforce::facet_wrap_paginate(~ Gene, scales = "free_y", ncol = 2, nrow = 4, page = page_num) + theme_minimal(base_size = 10) +
      labs(title = paste("Expression of Anti-PD-1 Upregulated Genes (Page", page_num, ")"),
      x = "Treatment Group", y = "Expression (Log2CPM)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")
  )}

# p-values for anti-PD-1
a_pvals <- c(0.055013832,0.838256486,0.487668353,0.391267279,0.177909595,0.307434166,0.012763008,0.094166375,0.540291375,0.653378911,0.111346887,0.270344141,0.016010991,0.653378911,0.016010991,0.347745599,0.007963489,0.347745599,0.094166375,0.079179350,0.024744672,0.177909595,0.019964453,0.775051374,0.024744672,0.002880485,0.055013832,0.130911128,0.775051374,0.967435545,0.177909595,0.030486157)

## EPAT from literature
upregulated_EPAT <- c("IFNG","IFNA2","IFNB1","IFNAR1","IRF1","IRF3","IRF7","STAT1","STAT4","JAK1","JAK2","TLR4","TLR7","TLR9","TNF","IL12A","IL12B","IL1B","IL2","IL18","IL21","CD3D","CD3E","CD3G","CD3Z","CIITA","PML","PARP9","RELA","CHUK","IKBKB","ITK","TICAM1", "IL27","TMEM173","MAP3K8","IFIH1","MAVS","MYD88")

epat2 <- tolower(conversion$external_gene_name) %in% tolower(upregulated_EPAT)
epat_genes_ensembl <- conversion$ensembl_gene_id[epat2]
cpm_subset <- update_cpm_data[rownames(cpm_data) %in% epat_genes_ensembl, , drop = FALSE]
rownames(cpm_subset) <- gene_names

cpm_t <- as.data.frame(t(cpm_subset))
cpm_t$Group <- update_group
long_data <- melt(cpm_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

results <- data.frame(Gene = character(), P_value = numeric(), stringsAsFactors = FALSE)
for (g in unique(long_data$Gene)) {
  dat_g <- subset(long_data, Gene == g)
  x1 <- dat_g$Expression[dat_g$Group == "EPAT"]
  x2 <- dat_g$Expression[dat_g$Group == "Vehicle"]
  if (length(x1) > 0 & length(x2) > 0) {
    p1 <- wilcox.test(x1, x2, exact = TRUE)$p.value
    results <- rbind(results, data.frame(Gene = g, P_value = p1))
  }
}
print(results[results$P_value < 0.05, ])

# EPAT p-values
e_pvals <- c(0.08920955,0.05242590,0.07525601,0.91179718,0.10512243,0.02323064,0.39304813,0.16549395,0.91179718,0.06301284,0.14314014,0.07525601,0.57874169,0.14314014,0.12300548,0.52884886,0.10512243,0.05242590,0.48125095,0.31499924,0.79593626,0.73936435,0.04325705,0.05242590,0.97051246,0.85342831,0.12300548,0.91179718,0.35268137,0.91179718,0.31499924,0.03546299)

#KS test on p-value
# KS test vs Uniform(0,1)
ks_epat <- ks.test(e_pvals, "punif", 0, 1)
ks_apd1 <- ks.test(a_pvals, "punif", 0, 1)

ks_epat
ks_apd1
sig_anti_pd1; sig_anti_pd1_total
sig_epat; sig_epat_total
head(sig_results)
