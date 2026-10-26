#check EPAT positive control in update_cpm_data dataframe with treatment type update_group
epat_positive_control <- c("CCL19", "CCL3", "CCL5", "CD14", "CD38", "CLEC5A", "CRP", "CSF2", "CSF3", "CXCL10",
                "CXCL11", "CYR61", "EDN1", "EREG", "FCAR", "HIF3A", "HLA-DRA", "IFNG", "IL1A", "IL1B",
                "IL12A", "IL12B", "IL17A", "IL18", "IL1RL1", "IL3", "IL6", "ITGAM", "JAK2", "KLK15",
                "KLK2", "KLK3", "LTB4R2_A", "MMP9", "NCAM1", "NCR1", "NOS2", "PDE4C", "PGK1", "PLA2G1B",
                "PLA2G2A", "PLA2G2D", "PLA2G5", "PRKAA2", "PTGER3", "PTGS2", "SELE", "STAT1", "STAT2",
                "TLR4", "TLR7", "TNFSF10", "TNFSF13B", "VEGFC")
EPAT_ensembl <- conversion[toupper(conversion$external_gene_name) %in% toupper(epat_positive_control), "ensembl_gene_id"]
EPAT_gene_map <- conversion[toupper(conversion$external_gene_name) %in% toupper(epat_positive_control), ]
EPAT_gene <- update_cpm_data[rownames(update_cpm_data) %in% EPAT_ensembl, ]

####make row name gene symbol instead
# Make sure rownames of EPAT_gene match ensembl_gene_id in EPAT_gene_map
EPAT_gene_named <- EPAT_gene  # copy to preserve original
# Match gene symbols to Ensembl IDs
matching_names <- EPAT_gene_map$external_gene_name[match(rownames(EPAT_gene_named), EPAT_gene_map$ensembl_gene_id)]
# Replace rownames
rownames(EPAT_gene_named) <- matching_names

# Number of genes and samples
n_genes <- nrow(EPAT_gene_named)
n_samples <- ncol(EPAT_gene_named)

# Transpose CPM data so that samples are rows, genes are columns
EPAT_gene_t <- as.data.frame(t(EPAT_gene_named))

# Add treatment group
EPAT_gene_t$Group <- update_group

# Plot each gene as a separate boxplot facet
EPAT_long <- reshape2::melt(EPAT_gene_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

# Plot
ggplot(EPAT_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  facet_wrap(~ Gene, scales = "free_y", ncol = 4) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of EPAT-Upregulated Genes Across Treatment Groups",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")

#seperate to 4 pages
ggplot(EPAT_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  ggforce::facet_wrap_paginate(~ Gene, scales = "free_y", ncol = 2, nrow = 4, page = 1) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of EPAT-Upregulated Genes (Page 1)",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")


ggplot(EPAT_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  theme_minimal(base_size = 12) +
  labs(title = "Combined Expression of EPAT-Upregulated Genes",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
##################################################
#try with RUVs_count
EPAT_gene_ruv <- as.data.frame(RUVs_count[rownames(RUVs_count) %in% EPAT_ensembl, ])

####make row name gene symbol instead
# Make sure rownames of EPAT_gene match ensembl_gene_id in EPAT_gene_map
EPAT_gene_named <- EPAT_gene_ruv  # copy to preserve original
# Match gene symbols to Ensembl IDs
matching_names <- EPAT_gene_map$external_gene_name[match(rownames(EPAT_gene_named), EPAT_gene_map$ensembl_gene_id)]
# Replace rownames
rownames(EPAT_gene_named) <- matching_names

# Number of genes and samples
n_genes <- nrow(EPAT_gene_named)
n_samples <- ncol(EPAT_gene_named)

# Transpose CPM data so that samples are rows, genes are columns
EPAT_gene_t <- as.data.frame(t(EPAT_gene_named))

# Add treatment group
EPAT_gene_t$Group <- update_group

# Plot each gene as a separate boxplot facet
EPAT_long <- reshape2::melt(EPAT_gene_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

# Plot
ggplot(EPAT_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  facet_wrap(~ Gene, scales = "free_y", ncol = 4) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of EPAT-Upregulated Genes Across Treatment Groups",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")

#seperate to 4 pages
ggplot(EPAT_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  ggforce::facet_wrap_paginate(~ Gene, scales = "free_y", ncol = 2, nrow = 4, page = 1) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of EPAT-Upregulated Genes (Page 1)",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")

ggplot(EPAT_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  theme_minimal(base_size = 12) +
  labs(title = "Combined Expression of EPAT-Upregulated Genes",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

######################################################
##for anti-PD-1
anti_PD1_positive <- c(
  "TBX21", "STAT1", "IRF1", "TNF", "IFNG",         # T-box/IFN regulators
  "CD8A", "CD8B", "ITGAE", "PDCD1", "CCL5", "CXCL13", "IL2",  # T cell-related
  "CD247", "CD5", "CD6", "CD69",                   # T cell activation
  "CD96",                                          # NK cell cytotoxicity
  "GZMK", "CD274", "CD2", "ITGAL",                 # T cell cytotoxicity
  "CCL4", "CCR5", "CXCL9",                         # Cytokine signaling
  "CXCL10", "CXCL11",                              # Chemoattractants
  "GZMB", "PRF1", "GZMA",                          # Cytotoxic effectors
  "CD4",                                           # T helper marker
  "H2-K1", "H2-D1", "B2M"                          # MHC-I antigen presentation
)
#convert them and make those gene a dataframe
antiPD1_ensembl <- conversion[toupper(conversion$external_gene_name) %in% toupper(anti_PD1_positive), "ensembl_gene_id"]
antiPD1_gene_map <- conversion[toupper(conversion$external_gene_name) %in% toupper(anti_PD1_positive), ]
antiPD1_gene <- update_cpm_data[rownames(update_cpm_data) %in% antiPD1_ensembl, ]

####make row name gene symbol instead
# Make sure rownames of EPAT_gene match ensembl_gene_id in EPAT_gene_map
antiPD1_gene_named <- antiPD1_gene  # copy to preserve original
# Match gene symbols to Ensembl IDs
matching_names <- antiPD1_gene_map$external_gene_name[match(rownames(antiPD1_gene_named), antiPD1_gene_map$ensembl_gene_id)]
# Replace rownames
rownames(antiPD1_gene_named) <- matching_names

# Number of genes and samples
n_genes <- nrow(antiPD1_gene_named)
n_samples <- ncol(antiPD1_gene_named)

# Transpose CPM data so that samples are rows, genes are columns
antiPD1_gene_t <- as.data.frame(t(antiPD1_gene_named))

# Add treatment group
antiPD1_gene_t$Group <- update_group

# Plot each gene as a separate boxplot facet
antiPD1_long <- reshape2::melt(antiPD1_gene_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")
# Plot
##plot for all
ggplot(antiPD1_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  facet_wrap(~ Gene, scales = "free_y", ncol = 4) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of Anti-PD1-Upregulated Genes Across Treatment Groups",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")

#seperate to 4 pages
ggplot(antiPD1_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  ggforce::facet_wrap_paginate(~ Gene, scales = "free_y", ncol = 2, nrow = 4, page = 4) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of EPAT-Upregulated Genes (Page 4)",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")

#overall
ggplot(antiPD1_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  theme_minimal(base_size = 12) +
  labs(title = "Combined Expression of Anti-PD1-Upregulated Genes",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

###########################################
#from kegg pathway anti-PD1
anti_PD1_up <- c("PIK3R3", "PIK3CA", "PIK3CB", "PIK3CD", "PIK3R1", "PIK3R2", "PIK3R3")
#anti_PD1_up <- c("PTPN6", "PTPN11")
antiPD1_upensembl <- conversion[toupper(conversion$external_gene_name) %in% toupper(anti_PD1_up), "ensembl_gene_id"]
antiPD1_map_up <- conversion[toupper(conversion$external_gene_name) %in% toupper(anti_PD1_up), ]
antiPD1_gene_up <- update_cpm_data[rownames(update_cpm_data) %in% antiPD1_upensembl, ]
antiPD1_up_named <- antiPD1_gene_up  # copy to preserve original
# Match gene symbols to Ensembl IDs
matching_names <- antiPD1_map_up$external_gene_name[match(rownames(antiPD1_up_named), antiPD1_map_up$ensembl_gene_id)]
# Replace rownames
rownames(antiPD1_up_named) <- matching_names

# Number of genes and samples
n_genes <- nrow(antiPD1_up_named)
n_samples <- ncol(antiPD1_up_named)

# Transpose CPM data so that samples are rows, genes are columns
antiPD1_gene_t <- as.data.frame(t(antiPD1_up_named))

# Add treatment group
antiPD1_gene_t$Group <- update_group

# Plot each gene as a separate boxplot facet
antiPD1_long <- reshape2::melt(antiPD1_gene_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")
# Plot
##plot for all
ggplot(antiPD1_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  facet_wrap(~ Gene, scales = "free_y", ncol = 4) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of Anti-PD1-Upregulated Genes Across Treatment Groups",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")
###########################################
#from kegg pathway EPAT
anti_PD1_up <- c("GNAS", "ADCY1", "ADCY2", "ADCY3", "ADCY4", "ADCY5", "ADCY6", 
                 "ADCY7", "ADCY8", "ADCY9")
anti_PD1_up <- c("GNAS", "GNB5", "GNB1", "GNB2", "GNB3", "GNG3", "GNG4", "GNG5", "GNG7", "GNG10", "GNG11", "GNGT1", "GNGT2", "GNG13", "GNG2", "GNG12", "GNB4", "GNG8")
anti_PD1_up <- c("DNMT3A", "CREB1")
anti_PD1_up <- c("GNAI1", "GNAI2", "GNAI3", "GNAO1", "PRKACA", "PAKACB", "PRKACG")
anti_PD1_up <- c("CD40", "CD80", "CD86", "MHC")
anti_PD1_up <- c("PTGER2", "PTGER4")
anti_PD1_up <- c("RELA", "NFKB1", "NFKBIA", "VEGFA", "PTGS2", "HIF1A", "II1B")
anti_PD1_up <- c("CCL17", "CCL22")
anti_PD1_up <- c("Foxp3", "Il2ra", "Stat5b", "Ctla4", "Tnfrsf4", "Tnfrsf9", "Tnfrsf18")
anti_PD1_up <- c(
  "MYD88",
  "TBX21",
  "TLR3",
  "IRF1",
  "TLR9",
  "Cxcl10"
)
anti_PD1_up <- c("PTGER4", "IL1RN", "PPARD", "HIF1A", "UCP1")



antiPD1_upensembl <- conversion[toupper(conversion$external_gene_name) %in% toupper(anti_PD1_up), "ensembl_gene_id"]
antiPD1_map_up <- conversion[toupper(conversion$external_gene_name) %in% toupper(anti_PD1_up), ]
antiPD1_gene_up <- update_cpm_data[rownames(update_cpm_data) %in% antiPD1_upensembl, ]
antiPD1_up_named <- antiPD1_gene_up  # copy to preserve original
# Match gene symbols to Ensembl IDs
matching_names <- antiPD1_map_up$external_gene_name[match(rownames(antiPD1_up_named), antiPD1_map_up$ensembl_gene_id)]
# Replace rownames
rownames(antiPD1_up_named) <- matching_names

# Number of genes and samples
n_genes <- nrow(antiPD1_up_named)
n_samples <- ncol(antiPD1_up_named)

# Transpose CPM data so that samples are rows, genes are columns
antiPD1_gene_t <- as.data.frame(t(antiPD1_up_named))

# Add treatment group
antiPD1_gene_t$Group <- update_group

# Plot each gene as a separate boxplot facet
antiPD1_long <- reshape2::melt(antiPD1_gene_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")
# Plot
##plot for all
ggplot(antiPD1_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  facet_wrap(~ Gene, scales = "free_y", ncol = 4) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of EPAT-Downregulated Genes Across Treatment Groups",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")

##########################################################
##check for negative control
set.seed(1)
random_neg32 <- neg_control[sample(nrow(neg_control), 32), ]

# Extract only the sampled Ensembl IDs
NEG32_ensembl <- random_neg32$ensembl_gene_id

# Get CPM data for these genes
NEG32_gene <- update_cpm_data[rownames(update_cpm_data) %in% NEG32_ensembl, ]

# Map gene symbols for labeling
matching_names <- random_neg32$external_gene_name[match(rownames(NEG32_gene), random_neg32$ensembl_gene_id)]
rownames(NEG32_gene) <- matching_names

# Transpose so samples are rows, genes are columns
NEG32_gene_t <- as.data.frame(t(NEG32_gene))
NEG32_gene_t$Group <- update_group

# Melt for ggplot
NEG32_long <- reshape2::melt(NEG32_gene_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

library(ggplot2)
library(ggforce)

# Page 1
ggplot(NEG32_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  ggforce::facet_wrap_paginate(~ Gene, scales = "free_y", ncol = 4, nrow = 4, page = 1) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of 32 Random Negative Control Genes (Page 1)",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")

# Page 2
ggplot(NEG32_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  ggforce::facet_wrap_paginate(~ Gene, scales = "free_y", ncol = 4, nrow = 4, page = 2) +
  theme_minimal(base_size = 10) +
  labs(title = "Expression of 32 Random Negative Control Genes (Page 2)",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")

ggplot(NEG32_long, aes(x = Group, y = Expression, fill = Group)) +
  geom_boxplot(outlier.size = 0.5) +
  theme_minimal(base_size = 12) +
  labs(title = "Combined expression of 32 Random Negative Control Genes ",
       x = "Treatment Group", y = "Expression (Log2CPM)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
##########################################################
set.seed(1)

# Sample 33 genes first
random_neg33 <- neg_control[sample(nrow(neg_control), 33), ]

# Remove 'vps25' from that sample (case-insensitive)
random_neg32 <- random_neg33[!tolower(random_neg33$external_gene_name) %in% "vps25", ]

# Extract only the sampled Ensembl IDs (now 32)
NEG32_ensembl <- random_neg32$ensembl_gene_id

# Get CPM data for these genes
NEG32_gene <- update_cpm_data[rownames(update_cpm_data) %in% NEG32_ensembl, ]

# Map gene symbols for labeling
matching_names <- random_neg32$external_gene_name[match(rownames(NEG32_gene), random_neg32$ensembl_gene_id)]
rownames(NEG32_gene) <- matching_names

# Transpose so samples are rows, genes are columns
NEG32_gene_t <- as.data.frame(t(NEG32_gene))
NEG32_gene_t$Group <- update_group

# Melt for ggplot
NEG32_long <- reshape2::melt(NEG32_gene_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

library(ggplot2)
library(ggforce)

for (i in 1:4) {
  print(
    ggplot(NEG32_long, aes(x = Group, y = Expression, fill = Group)) +
      geom_boxplot(outlier.size = 0.5) +
      ggforce::facet_wrap_paginate(~ Gene, ncol = 2, nrow = 4, page = i, scales = "free_y") +
      theme_minimal(base_size = 10) +
      labs(title = paste("Expression of 32 Random Negative Control Genes (Page", i, ")"),
           x = "Treatment Group", y = "Expression (Log2CPM)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none")
    
  )
}

##########################################################
##do Mann–Whitney U test on median Antipd-1/vehicle and EPAT/vehicle with H0 being no difference in median

# Define your treatment group labels (update if needed)
anti_pd1_label <- "Anti-PD-1"
epat_label <- "EPAT"
vehicle_label <- "Vehicle"

# Prepare results storage
results <- data.frame(
  Gene = character(),
  Comparison = character(),
  P_value = numeric(),
  stringsAsFactors = FALSE
)

# Loop over genes
for (gene in unique(NEG32_long$Gene)) {
  gene_data <- subset(NEG32_long, Gene == gene)
  
  # Anti-PD-1 vs Vehicle
  x1 <- gene_data$Expression[gene_data$Group == anti_pd1_label]
  x2 <- gene_data$Expression[gene_data$Group == vehicle_label]
  if (length(x1) > 0 & length(x2) > 0) {
    p1 <- wilcox.test(x1, x2, exact = FALSE)$p.value
    results <- rbind(results, data.frame(Gene = gene, Comparison = "Anti-PD-1_vs_Vehicle", P_value = p1))
  }
  
  # EPAT vs Vehicle
  x3 <- gene_data$Expression[gene_data$Group == epat_label]
  if (length(x3) > 0 & length(x2) > 0) {
    p2 <- wilcox.test(x3, x2, exact = FALSE)$p.value
    results <- rbind(results, data.frame(Gene = gene, Comparison = "EPAT_vs_Vehicle", P_value = p2))
  }
}

# Calculate rate of significant genes (p < 0.05) for each comparison
sig_anti_pd1 <- mean(results$P_value[results$Comparison == "Anti-PD-1_vs_Vehicle"] < 0.05)
sig_epat <- mean(results$P_value[results$Comparison == "EPAT_vs_Vehicle"] < 0.05)

sig_anti_pd1_total <- sum(results$P_value[results$Comparison == "Anti-PD-1_vs_Vehicle"] < 0.05)
sig_epat_total <- sum(results$P_value[results$Comparison == "EPAT_vs_Vehicle"] < 0.05)

sig_results <- results[results$P_value < 0.05, ]

# Optional: Print the full results table
# Separate p-values by comparison
anti_pd1_results <- subset(results, Comparison == "Anti-PD-1_vs_Vehicle")
epat_results <- subset(results, Comparison == "EPAT_vs_Vehicle")

#p-vlaue for each group negative control 
anti_pd1_pvals <- anti_pd1_results$P_value
epat_pvals <- epat_results$P_value


library(ggplot2)
# Bin breaks
bins <- seq(0, 1, by = 0.05)

# --- Anti-PD-1 ---
pval_df_anti <- data.frame(pvalue = anti_pd1_pvals)
pval_df_anti$bin <- cut(pval_df_anti$pvalue, breaks = bins, include.lowest = TRUE, right = FALSE)
pval_counts_anti <- as.data.frame(table(pval_df_anti$bin))
colnames(pval_counts_anti) <- c("Bin", "Count")

ggplot(pval_counts_anti, aes(x = Bin, y = Count)) +
  geom_bar(stat = "identity", fill = "dodgerblue") +
  labs(title = "Histogram of p-values (Anti-PD-1 vs Vehicle)",
       x = "p-value range", y = "Count") +
  theme_minimal(base_size = 15) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# --- EPAT ---
pval_df_epat <- data.frame(pvalue = epat_pvals)
pval_df_epat$bin <- cut(pval_df_epat$pvalue, breaks = bins, include.lowest = TRUE, right = FALSE)
pval_counts_epat <- as.data.frame(table(pval_df_epat$bin))
colnames(pval_counts_epat) <- c("Bin", "Count")

ggplot(pval_counts_epat, aes(x = Bin, y = Count)) +
  geom_bar(stat = "identity", fill = "dodgerblue") +
  labs(title = "Histogram of p-values (EPAT vs Vehicle)",
       x = "p-value range", y = "Count") +
  theme_minimal(base_size = 15) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#####################################
##upregulated for anti-PD-1
antiPD1_upregulated <- c(
  "IFNG",         # Interferon gamma
  "TNF",          # Tumor necrosis factor alpha
  "IL6",          # Interleukin 6
  "IL1B",         # Interleukin 1 beta
  # Interferon alpha/beta family
  "IFNA2",        # IFN alpha 2 (family: IFNA1, IFNA2, etc.)
  "IFNB1",        # IFN beta 1
  "STAT1",        # Key IFN signaling TF
  # NFkB pathway family
  "NFKBIA", "IKBKB", "IKBKG", "RELA", "CHUK",  # Components of NFkB/IkB pathway
  # Interleukin family (commonly upregulated/interferon regulated)
  "IL12A", "IL12B", "IL21", "IL27", "IL18", "IL2",  # Most well-evidenced members (IL12 = IL12A/IL12B complex)
  # TLR family
  "TLR4", "TLR7",
  # IFNAR family
  "IFNAR1",       # Type I IFN receptor
  # IRF family
  "IRF3", "IRF7", # Interferon regulatory factors
  # Cytokine/chemokine signaling (well-known markers)
  "CXCL12",       # (CXCL9/10/11 are the best-known, but 12 is sometimes up)
  # Cytotoxicity/immune cell activation
  "CD44", "CD3",  # (CD8A, CD69, etc., even more canonical, but CD3/CD44 are seen)
  "NOS2",         # iNOS, upregulated in inflamed TME
  # Others with literature support
  "CSF2", "CSF3", # Colony stimulating factors
  "TNFSF10",      # TRAIL, up in some responses
  "EBI3",         # IL27/IL35 subunit, IFN-inducible
  # GZMB, PRF1, CD8A, CXCL9, CXCL10, CXCL11, CCL5, CCL4 would also be in a full list
  "SPI1",         # (PU.1, myeloid, but also part of IFN-responsiveness)
  "ITK"           # T cell activation
)

## total 32 positive genes 
antiPD1_positive_genes <- c(
  "Cd44", "Chuk", "Cxcl12", "Ebi3", "Ifnar1", "Ifng", "Ikbkb", "Ikbkg",
  "Il12b", "Il18", "Il1b", "Il2", "Il27", "Il6", "Irf3", "Irf7",
  "Itk", "Nfkbia", "Nos2", "Rela", "Spi1", "Stat1", "Tlr4", "Tlr7",
  "Tnf", "Tnfsf10", "Cd28", "Irf1", "Myd88", "Tbx21", "Tlr3", "Cxcl10"
)
## total of 16 Robust, literature-supported positive markers for anti-PD-1/immune checkpoint response
robust_PD1_markers <- c(
  "Ifnar1", "Ifng", "Ikbkb", "Il12b", "Il18", "Il2", "Irf3", "Irf7",
  "Nfkbia", "Nos2", "Rela", "Stat1", "Tlr4", "Tlr7", "Tnf", "Tnfsf10"
)
upregulated_in_PD1_literature <- c(
  "MYD88",
  "TBX21",
  "TLR3",
  "IRF1",
  "TLR9",
  "CD28"
)

library(reshape2)

# Match Ensembl IDs for positive genes
positive_genes_ensembl <- conversion$ensembl_gene_id[tolower(conversion$external_gene_name) %in% tolower(antiPD1_positive_genes)]

# Subset CPM data to only those genes
cpm_subset <- update_cpm_data[rownames(update_cpm_data) %in% positive_genes_ensembl, ]

# Set gene names for easy plotting/interpretation
gene_names <- conversion$external_gene_name[match(rownames(cpm_subset), conversion$ensembl_gene_id)]
rownames(cpm_subset) <- gene_names

# Transpose so samples are rows, genes are columns
cpm_t <- as.data.frame(t(cpm_subset))
cpm_t$Group <- update_group

# Melt to long format
long_data <- melt(cpm_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

# Wilcoxon test: Anti-PD-1 vs Vehicle only
results <- data.frame(Gene = character(), P_value = numeric())

for (gene in unique(long_data$Gene)) {
  data_gene <- subset(long_data, Gene == gene)
  x1 <- data_gene$Expression[data_gene$Group == "Anti-PD-1"]
  x2 <- data_gene$Expression[data_gene$Group == "Vehicle"]
  if (length(x1) > 0 & length(x2) > 0) {
    p1 <- wilcox.test(x1, x2, exact = FALSE)$p.value
    results <- rbind(results, data.frame(Gene = gene, P_value = p1))
  }
}


# Print significant genes (p < 0.05)
print(results[results$P_value < 0.05, ])

library(ggplot2)
library(ggforce)
library(reshape2)

# gene list and graph it
antiPD1_positive_genes <- c(
  "Cd44", "Chuk", "Cxcl12", "Ebi3", "Ifnar1", "Ifng", "Ikbkb", "Ikbkg",
  "Il12b", "Il18", "Il1b", "Il2", "Il27", "Il6", "Irf3", "Irf7",
  "Itk", "Nfkbia", "Nos2", "Rela", "Spi1", "Stat1", "Tlr4", "Tlr7",
  "Tnf", "Tnfsf10", "Cd28", "Irf1", "Myd88", "Tbx21", "Tlr3", "Cxcl10"
)

# Map to Ensembl
antiPD1_upensembl <- conversion[toupper(conversion$external_gene_name) %in% toupper(antiPD1_positive_genes), "ensembl_gene_id"]
antiPD1_map_up   <- conversion[toupper(conversion$external_gene_name) %in% toupper(antiPD1_positive_genes), ]

# Subset CPM data
antiPD1_gene_up  <- update_cpm_data[rownames(update_cpm_data) %in% antiPD1_upensembl, ]
antiPD1_up_named <- antiPD1_gene_up
matching_names   <- antiPD1_map_up$external_gene_name[match(rownames(antiPD1_up_named), antiPD1_map_up$ensembl_gene_id)]
rownames(antiPD1_up_named) <- matching_names

# Transpose so samples are rows, genes are columns
antiPD1_gene_t <- as.data.frame(t(antiPD1_up_named))
antiPD1_gene_t$Group <- update_group

# Melt to long format
antiPD1_long <- melt(antiPD1_gene_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

# Plot 8 genes per page (4 pages)
for (page_num in 1:4) {
  print(
    ggplot(antiPD1_long, aes(x = Group, y = Expression, fill = Group)) +
      geom_boxplot(outlier.size = 0.5) +
      ggforce::facet_wrap_paginate(~ Gene, scales = "free_y", ncol = 2, nrow = 4, page = page_num) +
      theme_minimal(base_size = 10) +
      labs(title = paste("Expression of Anti-PD-1 Upregulated Genes (Page", page_num, ")"),
           x = "Treatment Group", y = "Expression (Log2CPM)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none")
  )
}

#for anti-PD-1
a_pvals <- c(0.055013832, 0.838256486, 0.487668353, 0.391267279, 0.177909595, 0.307434166, 0.012763008, 0.094166375, 0.540291375, 0.653378911, 0.111346887, 0.270344141, 0.016010991, 0.653378911, 0.016010991, 0.347745599, 0.007963489, 0.347745599, 0.094166375, 0.079179350, 0.024744672, 0.177909595, 0.019964453, 0.775051374, 0.024744672, 0.002880485, 0.055013832, 0.130911128, 0.775051374, 0.967435545, 0.177909595, 0.030486157)

#######################################################
##upregulated for EPAT
upregulated_EPAT <- c(
  "IFNG",       # Interferon gamma; canonical marker of anti-tumor immunity, up in EP2/4 blockade (Zelenay et al., Cell 2015)
  "STAT1",      # IFN signaling TF; upregulated in immune activation with EP4 antagonists
  "IRF1",       # IFN-regulated TF; up in immune activation and after EP4 antagonism
  "TNF",        # Tumor necrosis factor; classic proinflammatory cytokine upregulated with EP2/4 inhibition
  "IL12B", # IL12A/IL12B; key Th1/CTL cytokine, up with PGE2-EP4 blockade
  "IL1B",       # Proinflammatory cytokine; up in activated/“hot” microenvironment post-EP2/4 inhibition
  "IL2",        # T cell growth factor; up in immune activation after PGE2 pathway blockade
  "B2M",        # MHC I component; upregulated with improved antigen presentation after PGE2/EP4 inhibition
  "NOS2",       # Inducible nitric oxide synthase; up in inflammatory response post-EP4 antagonism
  "IRF3",       # IFN regulatory TF, up with innate immune activation
  "IRF7",       # Master regulator of Type I IFN response, upregulated with EP4 blockade
  "TLR4",       # TLR signaling up with immune activation, seen in microarray/RNA-seq
  "TLR7",       # Up in IFN-driven immune activation after EP4 antagonism
  "TLR9",       # Same as above
  "RELA",       # NFkB subunit; NFkB pathway genes upregulated in proinflammatory immune responses
  "CHUK",       # IKK alpha, part of NFkB pathway; up in some datasets
  "IKBKB",      # IKK beta, part of NFkB pathway
  "IFNA2",      # Type I IFNs (whole family may be up)
  "IFNB1",      # IFN-beta
  "STAT4",      # Key TF in IFN/Th1 pathway, up in activated/“hot” tumors
  "IL18",       # Proinflammatory cytokine, upregulated in inflamed TME
  "IFNAR1",     # Type I IFN receptor, up in IFN-driven response
  "CD28",       # T cell costimulatory, upregulated with immune activation
  "TBX21",      # T-bet, master Th1/CTL transcription factor, upregulated post-checkpoint blockade
  "TICAM1",     # TRIF, part of TLR/IFN pathway
  "JAK1/2",     # Key signaling nodes in IFN/cytokine response
  "IL27",       # Immunoregulatory cytokine, may be upregulated post-EP4 blockade
  "PARP9",      # IFN-inducible DNA repair enzyme, part of “hot” TME gene signatures
  "CD3",        # T cell marker, upregulated with T cell infiltration
  "TGM2",       # Transglutaminase 2, up in immune-activated microenvironment
  "ITK",        # T cell kinase, up in T cell activation
  "IFNGR1",     # IFN gamma receptor, sometimes upregulated with immune response
  "SYK",        # Immune cell kinase, up with immune cell activation
  "JAK2",       # See above
  "CIITA",      # MHC II transcription factor, up in IFN-gamma signaling
  "MAP3K8",     # Kinase, part of TNF/IL1 pathways, up in proinflammatory response
  "PML",        # IFN-responsive gene, part of “hot” signatures
  "EIF2AK2",    # PKR, upregulated by IFN
  "IFNL1",      # Type III IFN, upregulated by IFN signaling/antagonist therapy
  "IL21",       # Th17/Tfh cytokine, sometimes up in immune activation
  "SAMSN1",     # Upregulated in activated lymphocytes (less strong evidence, but present)
  "CCL5"        # Chemokine, upregulated in T cell infiltration/activation, commonly seen in “hot” tumors after PGE2-EP4 antagonism
)

upregulated_EPAT <- c(
  # Interferons
  "IFNG", "IFNA2", "IFNB1", "IFNAR1",
  # Interferon Regulatory Factors
  "IRF1", "IRF3", "IRF7",
  # STAT/JAK Pathway
  "STAT1", "STAT4", "JAK1", "JAK2",
  # Toll-like Receptors
  "TLR4", "TLR7", "TLR9",
  # Cytokines
  "TNF", "IL12A", "IL12B", "IL1B", "IL2", "IL18", "IL21",
  # T cell/Immune Markers
  "CD3D", "CD3E", "CD3G", "CD3Z",  # CD3 group
  # MHC/Antigen Presentation
  "CIITA",
  # IFN Response/Proinflammatory
  "PML", "PARP9",
  # NFkB Pathway
  "RELA", "CHUK", "IKBKB",
  # T cell signaling
  "ITK",
  # Adaptor Proteins/Other Pathways
  "TICAM1",
  "CXCL9", "CXCL10", "GZMB", "PRF1", "CD8A"
  
)

upregulated_EPAT <- c(
  "IFNG", "IFNA2", "IFNB1", "IFNAR1",
  "IRF1", "IRF3", "IRF7",
  "STAT1", "STAT4", "JAK1", "JAK2",
  "TLR4", "TLR7", "TLR9",
  "TNF", "IL12A", "IL12B", "IL1B", "IL2", "IL18", "IL21",
  "CD3D", "CD3E", "CD3G", "CD3Z",
  "CIITA",
  "PML", "PARP9",
  "RELA", "CHUK", "IKBKB",
  "ITK",
  "TICAM1",
  "IL27", "TMEM173", "MAP3K8", "IFIH1", "MAVS", "MYD88"
)


# Match Ensembl IDs for EPAT up genes
epat_genes_ensembl <- conversion$ensembl_gene_id[
  tolower(conversion$external_gene_name) %in% tolower(upregulated_EPAT)
]

# Subset CPM data to only those genes
cpm_subset <- update_cpm_data[rownames(update_cpm_data) %in% epat_genes_ensembl, ]

# Set gene names for easy plotting/interpretation
gene_names <- conversion$external_gene_name[match(rownames(cpm_subset), conversion$ensembl_gene_id)]
rownames(cpm_subset) <- gene_names

# Transpose so samples are rows, genes are columns
cpm_t <- as.data.frame(t(cpm_subset))
cpm_t$Group <- update_group

# Melt to long format
long_data <- melt(cpm_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

# Wilcoxon test: EPAT vs Vehicle only
results <- data.frame(Gene = character(), P_value = numeric())

for (gene in unique(long_data$Gene)) {
  data_gene <- subset(long_data, Gene == gene)
  x1 <- data_gene$Expression[data_gene$Group == "EPAT"]
  x2 <- data_gene$Expression[data_gene$Group == "Vehicle"]
  if (length(x1) > 0 & length(x2) > 0) {
    p1 <- wilcox.test(x1, x2, exact = TRUE)$p.value
    results <- rbind(results, data.frame(Gene = gene, P_value = p1))
  }
}



# Print significant genes (p < 0.05)
print(results[results$P_value < 0.05, ])

# graph gene list 
upregulated_EPAT <- c(
  "IFNG", "IFNA2", "IFNB1", "IFNAR1", "IRF1", "IRF3", "IRF7", "STAT1", "STAT4", "JAK1", "JAK2", "TLR4", "TLR7", "TLR9",
  "TNF", "IL12A", "IL12B", "IL1B", "IL2", "IL18", "IL21","CD3D", "CD3E", "CD3G", "CD3Z", "CIITA","PML", "PARP9","RELA", "CHUK", "IKBKB","ITK", "TICAM1", "IL27", "TMEM173", "MAP3K8", "IFIH1", "MAVS", "MYD88"
)


# Map to Ensembl
epat_up_ensembl <- conversion[toupper(conversion$external_gene_name) %in% toupper(upregulated_EPAT), "ensembl_gene_id"]
epat_up_map     <- conversion[toupper(conversion$external_gene_name) %in% toupper(upregulated_EPAT), ]

# Subset CPM data
epat_gene_up    <- update_cpm_data[rownames(update_cpm_data) %in% epat_up_ensembl, ]
epat_up_named   <- epat_gene_up
matching_names  <- epat_up_map$external_gene_name[match(rownames(epat_up_named), epat_up_map$ensembl_gene_id)]
rownames(epat_up_named) <- matching_names

# Transpose so samples are rows, genes are columns
epat_gene_t <- as.data.frame(t(epat_up_named))
epat_gene_t$Group <- update_group

# Melt to long format
epat_long <- melt(epat_gene_t, id.vars = "Group", variable.name = "Gene", value.name = "Expression")

# Plot 8 genes per page (4 pages)
for (page_num in 1:4) {
  print(
    ggplot(epat_long, aes(x = Group, y = Expression, fill = Group)) +
      geom_boxplot(outlier.size = 0.5) +
      ggforce::facet_wrap_paginate(~ Gene, scales = "free_y", ncol = 2, nrow = 4, page = page_num) +
      theme_minimal(base_size = 10) +
      labs(title = paste("Expression of EPAT Upregulated Genes (Page", page_num, ")"),
           x = "Treatment Group", y = "Expression (Log2CPM)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none")
  )
}

# EPAT p-values
e_pvals <- c(0.08920955, 0.05242590, 0.07525601, 0.91179718, 0.10512243, 0.02323064, 
           0.39304813, 0.16549395, 0.91179718, 0.06301284, 0.14314014, 0.07525601, 
           0.57874169, 0.14314014, 0.12300548, 0.52884886, 0.10512243, 0.05242590, 
           0.48125095, 0.31499924, 0.79593626, 0.73936435, 0.04325705, 0.05242590, 
           0.97051246, 0.85342831, 0.12300548, 0.91179718, 0.35268137, 0.91179718, 
           0.31499924, 0.03546299)

library(ggplot2)

##1. Uniform Distribution (Null expectation)
# Uniform distribution density
x <- seq(0, 1, length.out = 100)
uniform_y <- rep(1, length(x))

# Plot
ggplot() +
  geom_line(aes(x = x, y = uniform_y), color = "skyblue", size = 1) +
  geom_rug(aes(x = pvals), color = "red", size = 1.5, sides = "b") +
  labs(title = "Observed p-values vs Uniform (Null) Distribution",
       x = "p-value", y = "Uniform density (expected under H0)") +
  theme_minimal(base_size = 15)

library(ggplot2)

# Assuming pvals is already defined as your numeric vector

# Bin breaks: 0, 0.05, 0.10, ..., 1.00
bins <- seq(0, 1, by = 0.05)

# Create a data.frame for ggplot
pval_df <- data.frame(pvalue = pvals)

# Cut p-values into bins
pval_df$bin <- cut(pval_df$pvalue, breaks = bins, include.lowest = TRUE, right = FALSE)

# Count the number in each bin
pval_counts <- as.data.frame(table(pval_df$bin))
colnames(pval_counts) <- c("Bin", "Count")

# Bar plot
ggplot(pval_counts, aes(x = Bin, y = Count)) +
  geom_bar(stat = "identity", fill = "dodgerblue") +
  labs(title = "Histogram of p-values",
       x = "p-value range", y = "Count") +
  theme_minimal(base_size = 15) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#p-value for negative control 
anti_pd1_pvals
epat_pvals
#p-value for positive control 
a_pvals
e_pvals
ks.test(e_pvals, "punif", 0, 1)