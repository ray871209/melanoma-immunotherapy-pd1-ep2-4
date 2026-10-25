# Data import, preprocessing, QC, and tumour purity
# Historical master's research code, reorganised from original annotated script.
# Original source lines 115-326. Statements and exploratory work preserved.
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

#most of my analysis follow https://htmlpreview.github.io/?https://github.com/RMolania/TCGA_PanCancer_UnwantedVariation/blob/master/Vigettes/TCGA_READ_RNAseq_Vignette.html#lowly-expressed-genes, which is the workflow from Raymar

raw <- read.table("GSE160788_SZ14_raw_count_matrix.txt", header = TRUE, sep = "")
library(edgeR)
library(DESeq2)
library(ggplot2)
library(ggExtra)
library(reshape2)

#make sample into different group
group <- c("EPAT", "Vehicle", "Anti-PD-1+EPAT", "Vehicle", "Vehicle","EPAT", "Anti-PD-1+EPAT", "EPAT", "Anti-PD-1+EPAT", "Vehicle","Anti-PD-1", "EPAT", "Anti-PD-1", "Anti-PD-1+EPAT", "Vehicle","Anti-PD-1", "EPAT", "Anti-PD-1", "EPAT", "Anti-PD-1+EPAT","Vehicle", "Vehicle", "Anti-PD-1", "Anti-PD-1", "Anti-PD-1","Anti-PD-1", "Anti-PD-1", "Vehicle", "EPAT", "Anti-PD-1+EPAT","Vehicle", "EPAT", "Anti-PD-1+EPAT", "Anti-PD-1+EPAT","Anti-PD-1+EPAT", "EPAT", "EPAT", "Anti-PD-1+EPAT", "Vehicle")

#Calculate library size for each sample
library_sizes <- colSums(raw)

summary(library_sizes)

#Filter genes: CPM >= 1 in at least 3 samples(original paper did)
filter_genes <- rowSums(cpm(raw) >= 1) >= 3
filtered <- raw[filter_genes, ]

#Perform PCA
log_counts <- log2(filtered + 1)
pca_result <- prcomp(t(log_counts), scale. = TRUE)
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group
ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) + geom_point(size = 3) + labs(title = "PCA Plot before normalisation", x = "PC1", y = "PC2") + theme_minimal() + theme(legend.title = element_text(size = 10), legend.text = element_text(size = 8))

#TMM normalization:
dge <- DGEList(counts = filtered)
tmm <- calcNormFactors(dge, method = "TMM")

#CPM conversion (to log2 format):
# becomes CPM+TMM
cpm_data <- cpm(tmm, log = TRUE)

#CPM without TMM
cpm_only <- cpm(filtered, log = TRUE) #CPM normalization only

#PCA:
#PCA after CPM-TMM
# Perform PCA on normalized data
pca_result <- prcomp(t(cpm_data), scale. = TRUE)
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- group
#Calculate the proportion for PC1 and PC2
pca_var <- summary(pca_result)$importance[2, ]
#make it pecentage
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)
# Create the base PCA scatter plot with updated axis labels
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +geom_point(size = 3)+labs(title = "PCA - labaled by treatment group", x = paste0("PC1 (", pc1_var, "%)"),y = paste0("PC2 (", pc2_var, "%)")) +theme_minimal() +theme(legend.title = element_text(size = 10),legend.text  = element_text(size = 8))
# Add volcano-style (density) marginal plots along the x and y axes
PCA_volcano <- ggMarginal(p, type = "density", groupColour = TRUE, groupFill = TRUE)

#Add library size to PCA plot
library_sizes <- c(13989149, 11760674, 12106992, 12184270, 13019063, 9170579, 11008657, 11881205, 9901862, 13861220, 13234260, 11603270, 10125652, 12437632, 12549127, 12417646, 14286770, 9889486, 11533330, 14883711, 14024357, 11334289, 14932934, 8890425, 12077168, 11853914, 10784770, 12834582, 12198896, 15050986, 14616755, 12362818, 15538880, 8377662, 12935369, 10003707, 11169087, 10686453, 12316344)
pca_data$LibrarySize <- library_sizes
# PCA plot colored by library size.
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) +geom_point(size = 3) +scale_color_gradientn(colors = c("blue", "yellow", "red"),limits = c(min(library_sizes), max(library_sizes))) +labs(title = "PCA Colored by Library Size",x = paste0("PC1 (", pc1_var, "%)"), y = paste0("PC2 (", pc2_var, "%)"), color = "Library Size") + theme_minimal())

#Find Tumor purity:
#Convert Mouse Ensembl IDs to Gene Symbols(required for tumor purity)
library(biomaRt)
library(dplyr)
mart <- useMart("ensembl", dataset = "mmusculus_gene_ensembl")
conversion <- getBM( attributes = c("ensembl_gene_id", "external_gene_name"), filters = "ensembl_gene_id", values = rownames(filtered), mart = mart )
cpm_data_1 <- as.data.frame(cpm_data)
gene_symbol <- cpm_data_1
filtered_conv <- gene_symbol[!is.na(gene_symbol$GeneSymbol) & gene_symbol$GeneSymbol != "", ]
#convert from mouse gene symbols to human gene symbols
mouse <- useMart("ensembl", dataset = "mmusculus_gene_ensembl")
human <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
mouse_gene_symbols <- rownames(filtered_conv)
ortho_mapping <- getBM(+ attributes = c("external_gene_name", "hsapiens_homolog_associated_gene_name"), filters = "external_gene_name", values = mouse_gene_symbols, mart = mouse)
colnames(ortho_mapping) <- c("Mouse_GeneSymbol", "Human_GeneSymbol")
human_gene <- merge(ortho_mapping, expr_df, by.x = "Mouse_GeneSymbol", by.y = "row.names")

#Prepare the Expression File in GCT Format for ESTIMATE
gct_data <- data.frame(NAME = rownames(expr_human), Description = "na", human_gene)
# Write to GCT file
write.table(gct_data, file = "input_human.gct", sep = "\t", quote = FALSE, row.names = FALSE)
estimateScore(input.ds = "input_human.gct", output.ds = "output_scores_2.gct", platform = "illumina")

scores <- read.table("output_scores_2.gct", header = TRUE, skip = 2, row.names = 1, sep = "\t")
estimate_scores <- as.numeric(scores["ESTIMATEScore", ])
tumor_purity <- cos(0.6049872018 + 0.0001467884 * estimate_scores)

#PCA plot according to tumor purity
pca_res <- prcomp(t(human_gene), scale. = TRUE)
pca_var <- summary(pca_res)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)
# data frame with the first two PCs and purity value
pca_df <- data.frame(PC1 = pca_res$x[, 1], PC2 = pca_res$x[, 2], TumorPurity = tumor_purity)
ggplot(pca_df, aes(x = PC1, y = PC2, color = TumorPurity)) + geom_point(size = 3) + labs(title = "PCA Plot according to Tumor Purity", x = paste0("PC1 (", pc1_var, "%)"), y = paste0("PC2 (", pc2_var, "%)"), color = "Tumor Purity") +mscale_color_gradient(low = "blue", high = "red") +theme_minimal()

#RLE plot from EDAseq
library(EDASeq)
cpm <- as.matrix(cpm_count)
dataframe <- data.frame(Treatment =  group,row.names = colnames(cpm))
# Create SeqExpressionSet object
seqexp <- newSeqExpressionSet(cpm_mat, phenoData = new("AnnotatedDataFrame", data = dataframe))
group_levels <- unique(dataframe $Treatment)
color <- c("darkred", "steelblue", "forestgreen", "orange" )
names(color) <- group_levels
# Generate RLE plot
plotRLE(ses, outline = FALSE, col     = color, main    = "RLE Plot labaled by Treatment group", xlab    = "Sample", ylab    = "Relative Log Expression", ylim    = c(-0.35, 0.35))
legend("topright", legend = names(color), fill   = color, title  = "Treatment Group", cex  = 0.8)

#day2 and day5 RLE plot
matrix <- as.matrix(cpm_day2)
matrix <- apply(matrix, 2, function(x) as.numeric(as.character(x)))
dataframe <- data.frame(Treatment = new_group_day2, row.names = colnames(matrix))
# Create SeqExpressionSet object
seqex <- newSeqExpressionSet(mat, phenoData = new("AnnotatedDataFrame", data = dataframe))
plotRLE(seqex, outline = FALSE, col     = box_colors, main    = "RLE Plot - Day 2 labaled by Treatment group", xlab    = "Sample", ylab    = "Relative Log Expression", ylim    = c(-0.35, 0.35))
legend("topright", legend = names(color), fill   = color, title  = "Treatment Group", cex    = 0.8)

#day2 and day5 RLE plot
matrix <- as.matrix(cpm_day5_expr)
matrix <- apply(mat, 2, function(x) as.numeric(as.character(x)))
dataframe <- data.frame(Treatment = new_group_day5, row.names = colnames(matrix))
# Create SeqExpressionSet object
Seqex <- newSeqExpressionSet(mat, phenoData = new("AnnotatedDataFrame", data = pd))
# Generate RLE plot
plotRLE(Seqex, outline = FALSE, col = box_colors, main = "RLE Plot - Day 5 labaled by Treatment group", xlab = "Sample", ylab = "Relative Log Expression", ylim = c(-0.35, 0.35))
legend("topright", legend = names(color), fill   = color, title  = "Treatment Group", cex    = 0.8)

## CPM only
matrix <- as.matrix(cpm_only)
# Create phenotype data using treatment groups
phenotype <- data.frame(Treatment = group, row.names = colnames(matrix))
seq<- newSeqExpressionSet(mat, phenoData = new("AnnotatedDataFrame", data = pd))
# Generate RLE plot
plotRLE(seq, outline = FALSE, col = box_colors, main = "RLE Plot labaled by Treatment group", xlab    = "Sample", ylab = "Relative Log Expression", ylim = c(-0.35, 0.35))legend("topright", legend = names(color), fill   = color, title  = "Treatment Group", cex    = 0.8)

# Calculate the median
gene_medians <- apply(original, 1, median)

##PCA before normalization
log_counts <- log2(filtered + 1)
pca_result <- prcomp(t(log_counts), scale. = TRUE)
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- group  # Factor/Group variable

pca_var <- summary(pca_result)$importance[2, ]
# PC1 in %
pc1_var <- round(pca_var[1] * 100, 1)
# PC2 in %
pc2_var <- round(pca_var[2] * 100, 1)
pca <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) + geom_point(size = 3) + labs( title = "PCA - labeled by treatment group", x = paste0("PC1 (", pc1_var, "%)"), y = paste0("PC2 (", pc2_var, "%)") ) + theme_minimal() + theme( legend.title = element_text(size = 10), legend.text  = element_text(size = 8))
pca_marginal <- ggMarginal( pca, type = "density", groupColour = TRUE, groupFill = TRUE)
print(pca_marginal)

###PCA raw counts with library size
log_counts <- log2(filtered + 1)
pca_result <- prcomp(t(log_counts), scale. = TRUE)
pca_data <- as.data.frame(pca_result$x)
library_sizes <- c(13989149, 11760674, 12106992, 12184270, 13019063, 9170579, 11008657, 11881205, 9901862, 13861220, 13234260, 11603270, 10125652, 12437632, 12549127, 12417646, 14286770, 9889486, 11533330, 14883711, 14024357, 11334289, 14932934, 8890425, 12077168, 11853914, 10784770, 12834582, 12198896, 15050986, 14616755, 12362818, 15538880, 8377662, 12935369, 10003707, 11169087, 10686453, 12316344)
pca_data$LibrarySize <- library_sizes
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) + geom_point(size = 3) + scale_color_gradientn(colors = c("blue", "yellow", "red"), limits = c(min(library_sizes), max(library_sizes))) + labs(title = "PCA - labeled by library size", x = paste0("PC1 (", pc1_var, "%)"), y = paste0("PC2 (", pc2_var, "%)"), color = "Library Size") + theme_minimal()

###PCA plot according to tumor purity
# Perform PCA on the expression data (transpose because prcomp expects samples as rows)
pca_res <- prcomp(t(log_counts), scale. = TRUE)

# Calculate the proportion of variance explained for PC1 and PC2
pca_var <- summary(pca_res)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Create a data frame with the first two principal components and tumor purity values
pca_df <- data.frame(
  PC1 = pca_res$x[, 1],
  PC2 = pca_res$x[, 2],
  TumorPurity = tumor_purity
)


#PCA plot include variance
ggplot(pca_df, aes(x = PC1, y = PC2, color = TumorPurity)) +geom_point(size = 3) +labs(title = "PCA Plot - labeled by tumor purity", x = paste0("PC1 (", pc1_var, "%)"), y = paste0("PC2 (", pc2_var, "%)"), color = "Tumor Purity") + scale_color_gradient(low = "blue", high = "red") + theme_minimal()


###PCA Plot using original paper normalization method
# Perform PCA on the transposed normalized data
pca_result <- prcomp(t(original), scale. = TRUE)
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- group
# Calculate the proportion of variance explained for each PC
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) + geom_point(size = 3) + labs(title = "PCA Plot using original paper normalization method", x = paste0("PC1 (", pc1_var, "%)"), y = paste0("PC2 (", pc2_var, "%)")) + theme_minimal() + theme(legend.title = element_text(size = 10), legend.text = element_text(size = 8))

###PCA after CPM-TMM
pca_result <- prcomp(t(cpm_data), scale. = TRUE)
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- group
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)
pca <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) + geom_point(size = 3) + labs( title = "PCA - labaled by treatment group", x = paste0("PC1 (", pc1_var, "%)"), y = paste0("PC2 (", pc2_var, "%)")) + theme_minimal() + theme( legend.title = element_text(size = 10), legend.text  = element_text(size = 8))
pca_plot <- ggMarginal(pca, type = "density", groupColour = TRUE, groupFill = TRUE)

########
#PCA raw count-CPM-TMM labaled by library size
pca_data$LibrarySize <- library_sizes
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) + geom_point(size = 3) + scale_color_gradientn(colors = c("blue", "yellow", "red"), limits = c(min(library_sizes), max(library_sizes))) + labs(title = "PCA - labaled by Library Size", x = paste0("PC1 (", pc1_var, "%)"), y = paste0("PC2 (", pc2_var, "%)"), color = "Library Size") + theme_minimal()

#PCA raw count-CPM-TMM labaled by tumor purityggplot(pca_df, aes(x = PC1, y = PC2, color = TumorPurity)) + geom_point(size = 3) + labs(title = "PCA - labaled by  Tumor Purity", x = paste0("PC1 (", pc1_var, "%)"), y = paste0("PC2 (", pc2_var, "%)"), color = "Tumor Purity") + scale_color_gradient(low = "blue", high = "red") + theme_minimal()
