##Selecting Negative Control Genes

# Assume you have downloaded Human_Mouse_Common.csv
housekeeping <- kv <- read.delim(
  "HOUNKPE_HOUSEKEEPING_GENES.v2024.1.Mm.tsv",
  sep      = "\t",
  header   = FALSE,
  stringsAsFactors = FALSE,
  comment.char     = ""        # ensure no lines get skipped
)

housekeeping_list <- housekeeping$V2[kv$V1 == "SOURCE_MEMBERS"]
housekeeping_list

housekeeping_genes <- strsplit(housekeeping_list, ",")[[1]]
housekeeping_genes

neg_control <- conversion[conversion$external_gene_name %in% housekeeping_genes, ]
length(unique(neg_control$ensembl_gene_id))

matrix_update_cpm_tmm <- as.matrix(update_cpm_data)
#look for bottom 15% of gene in variance - 2238 genes 
stable_gene <- names(sort(rowVars(matrix_update_cpm_tmm)))[1:2238]  # bottom‐var genes

new_neg_control <- intersect(neg_control$ensembl_gene_id, stable_gene)
ctl <- rownames(matrix_update_cpm_tmm) %in% new_neg_control
ruv <- RUVg(
  matrix_update_cpm_tmm,
  ctl,
  k = 3,
  isLog = TRUE  
)
W1 <- ruv$W[,1]
W2 <- ruv$W[,2]
W3 <- ruv$W[,3]
cor(W1, update_tumor_purity)
cor(W2, update_tumor_purity)
cor(W3, update_tumor_purity)
##try with k = 2
ruv_2 <- RUVg(
  matrix_update_cpm_tmm,
  ctl,
  k = 2,
  isLog = TRUE  
)
cor(ruv_2$W[,1], update_tumor_purity)
cor(ruv_2$W[,2], update_tumor_purity)
ruv_output <- ruv_2[["normalizedCounts"]]
##try with bottom 15% only
control <- rownames(matrix_update_cpm_tmm) %in% stable_gene
ruv_3 <- RUVg(
  matrix_update_cpm_tmm,
  control,
  k = 3,
  isLog = TRUE  
)
cor(ruv_3$W[,1], update_tumor_purity)
cor(ruv_3$W[,2], update_tumor_purity)
cor(ruv_3$W[,3], update_tumor_purity)
#try bottom 20% and negative control intesect
stable_gene_2 <- names(sort(rowVars(matrix_update_cpm_tmm)))[1:2984]  # bottom‐var genes

new_neg_control_2 <- intersect(neg_control$ensembl_gene_id, stable_gene)
ctl_2 <- rownames(matrix_update_cpm_tmm) %in% new_neg_control_2
ruv_4 <- RUVg(
  matrix_update_cpm_tmm,
  ctl_2,
  k = 3,
  isLog = TRUE  
)
W_1 <- ruv_4$W[,1]
W_2 <- ruv_4$W[,2]
W_3 <- ruv_4$W[,3]
cor(W_1, update_tumor_purity)
cor(W_2, update_tumor_purity)
cor(W_3, update_tumor_purity)

#############################################
# (RUVs)
#make a list of replicate list
pseudo_list <- list(
  d2_Combine   = c("AM6_8.2_S33","AM6_8.3_S38","AM6_8.1_S7","AM6_8.4_S9","AM6_8.5_S14"),
  d2_Anti_PD_1 = c("AM6_4.2_S16","AM6_4.3_S24","AM6_4.1_S18","AM6_4.4_S13","AM6_4.5_S25"),
  d2_EPAT    = c("AM6_5.3_S6","AM6_6.5_S8","AM6_5.4_S36","AM6_5.1_S19","AM6_5.2_S1"),
  d2_Vehicle = c("AM6_2.2_S15","AM6_2.3_S39","AM6_2.4_S2","AM6_2.1_S5","AM6_2.5_S31"),
  d5_Combine = c("AM6_7.5_S35","AM6_7.2_S3","AM6_7.3_S34","AM6_7.4_S20"),
  d5_Anti_PD_1 = c("AM6_3.1_S27","AM6_3.2_S26","AM6_3.4_S11","AM6_3.5_S23"),
  d5_EPAT    = c("AM6_6.1_S32","AM6_6.2_S17","AM6_6.3_S12","AM6_5.5_S29","AM6_6.4_S37"),
  d5_Vehicle  = c("AM6_1.1_S21","AM6_1.2_S28","AM6_1.3_S22","AM6_1.4_S4","AM6_1.5_S10")
)
#form a matrix with all -1 value
scIdx <- matrix(-1L,
                nrow = 8,
                ncol = 5,
                dimnames = list(names(pseudo_list), NULL)
)

for (i in seq_along(pseudo_list)) {
  groupNames <- pseudo_list[[i]]
  # find their column indices in Y
  idx <- match(groupNames, colnames(matrix_update_cpm_tmm))
  # place into the row
  scIdx[i, seq_along(idx)] <- idx
}

Ruvs <- RUVs(x     = matrix_update_cpm_tmm,
                 cIdx  = ctl_2,
                 k     = 2,
                 scIdx = scIdx,
                 round = FALSE,
                 isLog=TRUE)

cor(Ruvs$W[,1], update_tumor_purity)

Ruvs <- RUVs(x     = matrix_update_cpm_tmm,
             cIdx  = ctl_2,
             k     = 1,
             scIdx = scIdx,
             round = FALSE,
             isLog=TRUE)

cor(Ruvs$W[,1], update_tumor_purity)

RUVs_count <- Ruvs$normalizedCounts
summary(matrix_update_cpm_tmm)
summary(RUVs_count)
cor(Ruvs$W[,1], update_library_size)
cor.test(Ruvs$W[,1], as.numeric(factor(update_group)), method="spearman")
########################################
#test RUVs output for PCA
pca_result <- prcomp(t(RUVs_count), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- update_group  # Factor/Group variable
pca_data$Day = update_batch_info
pca_data$Sample <- colnames(RUVs_count)


# Step 6: Extract variance explained
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Step 7: Base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group, shape = Day)) +
  geom_point(size = 3) +
  labs(
    title = "PCA labeled by treatment group and day",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)")
  ) +
  xlim(-125, 125) +  # Reverse x-axis direction
  ylim(-125, 125) +
  theme_minimal() +
  theme(
    legend.title = element_text(size = 10),
    legend.text  = element_text(size = 8)
  )

# Step 8: Add marginal density plots
p_marginal <- ggMarginal(
  p,
  type = "density",
  groupColour = TRUE,
  groupFill   = TRUE
)

# Final Plot
print(p_marginal)

###############################################################################
# Step 6: Add library size to PCA dataframe
pca_data$LibrarySize <- update_library_size

# Step 7: Plot PCA with color gradient based on library size
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize, shape = Day)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(update_library_size), max(update_library_size))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA labeled by library size and day",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Library Size"
  ) +
  xlim(-125, 125) + 
  ylim(-125, 125) +
  theme_minimal()
###############################################################################
# Step 6: Build PCA dataframe
# Step 7: Plot
pca_data$TumorPurity <- update_tumor_purity

ggplot(pca_data, aes(x = PC1, y = PC2, color = TumorPurity, shape = Day)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(update_tumor_purity), max(update_tumor_purity))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA Plot labeled by tumor purity and day",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Tumor Purity"
  ) +
  xlim(-125, 125) + 
  ylim(-125, 125) +
  theme_minimal()
###############################################################################
##RLE for RUVs
library(EDASeq)
library(Biobase)

mat <- as.matrix(RUVs_count)

# Create phenotype data using treatment groups
pd <- data.frame(Treatment = update_group,
                 row.names = colnames(mat))

# Create SeqExpressionSet object
ses <- newSeqExpressionSet(mat, phenoData = new("AnnotatedDataFrame", data = pd))

# Define colors for each treatment group
group_levels <- unique(pd$Treatment)
my_palette <- c("darkred", "steelblue", "forestgreen", "orange" )
names(my_palette) <- group_levels

# Assign colors to each sample based on group
box_colors <- my_palette[pd$Treatment]

# Generate RLE plot
EDASeq::plotRLE(ses,
        outline = FALSE,
        col     = box_colors,
        main    = "RLE Plot labaled by Treatment group",
        xlab    = "Sample",
        ylab    = "Relative Log Expression",
        ylim    = c(-0.35, 0.35))

# Add legend
legend("topright",
       legend = names(my_palette),
       fill   = my_palette,
       title  = "Treatment Group",
       cex    = 0.8)



###############################################################################

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




meta <- data.frame(
  treatment    = update_group,
  day          = update_batch_info,
  purity       = update_tumor_purity,
  row.names    = colnames(matrix_update_cpm_tmm),
  stringsAsFactors = FALSE
)

#create SE
se <- SummarizedExperiment(
  assays    = list(TMM_CPM = matrix_update_cpm_tmm),
  colData   = DataFrame(meta)
)

##colData(se)$purity_group <- factor(ifelse(colData(se)$purity > 0.5,"High","Low"),levels = c("Low","High"))

# create PRPS in the SE 
se <- createPrPsSupervised(
  se.obj       = se,
  assay.name   = "TMM_CPM",
  bio.variables = c("treatment"),
  uv.variables = "purity",
  apply.other.uv.variables  = FALSE,
  min.sample.for.ps = 2, #min is 2
  prps.group.name   = "purity_group",
  save.se.obj  = TRUE
)

# register your negative‐control genes from housekeeping:
ncg_input <- rownames(se) %in% new_neg_control
ncg_index <- which(rownames(se) %in% new_neg_control) #location

#add negativ econtrol gene
se <- addNCGs(
  se.obj      = se,
  ncg         = ncg_index,
  subset.name = "Negative_control"
)
metadata(se)$NCG$supervised <- metadata(se)$NCG$pre.selected


#RUV‐III‐PRPS normalization:
se_norm <- RUVIIIprps(
  se.obj           = se,
  assay.name       = "TMM_CPM",            
  control.assay.type = "prps",            
  prps.type        = "supervised",         
  prps.group       = "purity_group",   # the name for PRPS sets
  ncg.type         = "pre.selected",         
  ncg.group        = "Negative_control",   
  k                = 1,                    
  apply.log        = FALSE,                
  data.to.log      = "assay",              
  return.info      = TRUE,                 
  save.se.obj      = TRUE                 
)

# 6) extract your normalized matrix:
normalized <- assay(se_ruv, "RUVIIIPRPS_K_1")
W_factors  <- metadata(se_ruv)$W  # the unwanted‐factor matrix

###############################################################################
matrix_for_prps <- cbind(
  matrix_update_cpm_tmm,
  AM6_1.3_S22_copy = matrix_update_cpm_tmm[, "AM6_1.3_S22"]
)

col_idx <- which(colnames(matrix_update_cpm_tmm) == "AM6_1.3_S22")
if (length(col_idx) != 1) stop("AM6_1.3_S22 not found or duplicated in column names.")

# 2. Duplicate that column in the matrix (if you haven’t already)
mat2 <- cbind(
  matrix_update_cpm_tmm,
  matrix_update_cpm_tmm[, col_idx]
)
colnames(mat2)[ncol(mat2)] <- "AM6_1.3_S22_copy"  # same name as original

# 3. Now extend each metadata vector by copying the value at col_idx
update_group_prps        <- c(update_group,        update_group[col_idx])
update_batch_prps   <- c(update_batch_info,   update_batch_info[col_idx])
update_tumor_prps <- c(update_tumor_purity, update_tumor_purity[col_idx])
# Rename the last element in update_batch_prps
names(update_batch_prps)[length(update_batch_prps)] <- "AM6_1.3_S22_copy"

# Rename the last element in update_tumor_prps
names(update_tumor_prps)[length(update_tumor_prps)] <- "AM6_1.3_S22_copy"

##########
#for prps
meta_prps <- data.frame(
  treatment    = update_group_prps,
  purity       = update_tumor_prps,
  row.names    = colnames(matrix_for_prps),
  stringsAsFactors = FALSE
)

#create SE
se_prps <- SummarizedExperiment(
  assays    = list(TMM_CPM = matrix_for_prps),
  colData   = DataFrame(meta_prps)
)

##colData(se)$purity_group <- factor(ifelse(colData(se)$purity > 0.5,"High","Low"),levels = c("Low","High"))

# create PRPS in the SE 
se_prps <- createPrPsSupervised(
  se.obj = se_prps,
  assay.name = "TMM_CPM",
  bio.variables = c("treatment"),
  uv.variables = "purity",
  apply.other.uv.variables  = FALSE,
  min.sample.for.ps = 3, #min is 2
  pseudo.count = 1,
  prps.group.name   = "purity",
  save.se.obj  = TRUE,
  remove.na = "both",
)
se_prps <- createPrPsForContinuousUV(
  se.obj = se_prps,
  assay.name = "TMM_CPM",
  bio.variables = "treatment",
  main.uv.variable = "purity",
  other.uv.variables = NULL,
  min.sample.for.ps = 2,
  bio.clustering.method = "quantile",
  nb.bio.clusters = 2,
  other.uv.clustering.method = "kmeans",
  nb.other.uv.clusters = 2,
  apply.log = FALSE,
  pseudo.count = 1,
  check.se.obj = TRUE,
  remove.na = "both",
  plot.prps.map = TRUE,
  prps.group.name = "purity",
  prps.sets.name = NULL,
  save.se.obj = TRUE,
  verbose = TRUE
)
prps_matrix <- se_prps@metadata[["PRPS"]][["supervised"]][["purity"]][["prps.data"]][["purity|treatment|TMM_CPM"]]
# 1) grab the single matrix:
deep_name <- "purity|treatment|TMM_CPM"

raw_mat <- se_prps@metadata$PRPS$supervised$purity[[deep_name]][["prps.data"]]

# 2) wrap it into a length‐1 list named exactly “purity|treatment|TMM_CPM”:
se_prps@metadata$PRPS$supervised$purity$prps.data <- 
  setNames(list(raw_mat), deep_name)

# Now:
# names(metadata(se_prps)$PRPS$supervised$purity$prps.data)
#   gets [1] "purity|treatment|TMM_CPM"


# register your negative‐control genes from housekeeping:
ncg_input <- rownames(se_prps) %in% new_neg_control
ncg_index <- which(rownames(se_prps) %in% new_neg_control) #location

#add negativ econtrol gene
se_prps <- addNCGs(
  se.obj      = se_prps,
  ncg         = ncg_index,
  subset.name = "Negative_control"
)
metadata(se_prps)$NCG$supervised <- metadata(se_prps)$NCG$pre.selected

# move the logical vector up one level (remove the extra “$gene.set” layer)
metadata(se_prps)$NCG$pre.selected$Negative_control <- 
  metadata(se_prps)$NCG$pre.selected$Negative_control$gene.set

sub.names <- names(metadata(se_prps)$PRPS$supervised$purity)

#RUV‐III‐PRPS normalization:
se_norm <- RUVIIIprps(
  se.obj = se_prps,
  assay.name = "TMM_CPM",            
  control.assay.type = "prps",            
  prps.type = "supervised",         
  prps.group = "purity",   # the name for PRPS sets
  prps.set.names = NULL,
  ncg.type = "pre.selected",         
  ncg.group = "Negative_control",
  ncg.set.names = NULL,
  technical.replicates = NULL,
  k = 1,                    
  apply.log = FALSE,
  data.to.log = "assay",
  pseudo.count = 1,
  eta = NULL,
  include.intercept = TRUE,
  return.info = TRUE,
  check.se.obj = TRUE,
  remove.na = "none",
  output.name = NULL,
  save.se.obj = TRUE,
  verbose = TRUE               
)
#normlaized count for RUVIII-PRPS
RUVPRPS <- se_norm@assays@data@listData[["RUVIIIPRPS_K_1"]]
cor(update_tumor_prps, se_norm@metadata[["RUVIII"]][["W"]][["RUVIIIPRPS_K_1"]])

normalized <- assay(se_ruv, "RUVIIIPRPS_K_1")
W_factors  <- metadata(se_ruv)$W  # the unwanted‐factor matrix