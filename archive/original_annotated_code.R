#R version 4.4.1 (2024-06-14)
#Platform: x86_64-apple-darwin20
#Running under: macOS 15.6

#Matrix products: default
#BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib 
#LAPACK: /Library/Frameworks/R.framework/Versions/4.4-x86_64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.0

#locale:
  #[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

#time zone: Australia/Melbourne
#tzcode source: internal

#attached base packages:
  #[1] stats4    stats     graphics  grDevices utils     datasets  methods   base     

#other attached packages:
  #[1] rlang_1.1.6          org.Mm.eg.db_3.20.0  AnnotationDbi_1.68.0 IRanges_2.40.1       S4Vectors_0.44.0    
#[6] Biobase_2.66.0       BiocGenerics_0.52.0  KEGGREST_1.46.0      ggExtra_0.10.1       lubridate_1.9.4     
#[11] forcats_1.0.0        purrr_1.1.0          readr_2.1.5          tidyverse_2.0.0      stringr_1.5.1       
#[16] ggforce_0.5.0        rstatix_0.7.2        tidyr_1.3.1          ggsignif_0.6.4       ggpubr_0.6.1        
#[21] limma_3.62.2         ggplot2_3.5.2        reshape2_1.4.4       tibble_3.3.0         pheatmap_1.0.13     
#[26] dplyr_1.1.4          biomaRt_2.62.1       immunedeconv_2.1.0   EPIC_1.1.7          

#loaded via a namespace (and not attached):
  #[1] igraph_2.1.4                graph_1.84.1                ica_1.0-3                  
#[4] plotly_4.11.0               Formula_1.2-5               zlibbioc_1.52.0            
#[7] tidyselect_1.2.1            bit_4.6.0                   doParallel_1.0.17          
#[10] tidyestimate_1.1.1          clue_0.3-66                 lattice_0.22-7             
#[13] rjson_0.2.23                blob_1.2.4                  S4Arrays_1.6.0             
#[16] parallel_4.4.1              png_0.1-8                   ResidualMatrix_1.16.0      
#[19] cli_3.6.5                   goftest_1.2-3               textshaping_1.0.1          
#[22] BiocIO_1.16.0               bluster_1.16.0              BiocNeighbors_2.0.1        
#[25] uwot_0.2.3                  curl_6.4.0                  mime_0.13                  
#[28] evaluate_1.0.4              ComplexHeatmap_2.22.0       ggh4x_0.3.1                
#[31] stringi_1.8.7               backports_1.5.0             XML_3.99-0.18              
#[34] Exact_3.3                   httpuv_1.6.16               magrittr_2.0.3             
#[37] rappdirs_0.3.3              splines_4.4.1               mclust_6.1.1               
#[40] KMsurv_0.1-6                jpeg_0.1-11                 survminer_0.5.0            
# [43] sctransform_0.4.2           lpSolve_5.6.23              rootSolve_1.8.2.4          
# [46] DBI_1.2.3                   HDF5Array_1.34.0            genefilter_1.88.0          
# [49] withr_3.0.2                 systemfonts_1.2.3           class_7.3-23               
# [52] matrixTests_0.2.3           lmtest_0.9-40               GSEABase_1.68.0            
# [55] sva_3.54.0                  BiocManager_1.30.26         rtracklayer_1.66.0         
# [58] htmlwidgets_1.6.4           fs_1.6.6                    SingleCellExperiment_1.28.1
# [61] ggrepel_0.9.6               labeling_0.4.3              SparseArray_1.6.2          
# [64] DESeq2_1.46.0               cellranger_1.1.0            MatrixGenerics_1.18.1      
# [67] annotate_1.84.0             lmom_3.2                    reticulate_1.43.0          
# [70] zoo_1.8-14                  GGally_2.3.0                XVector_0.46.0             
# [73] knitr_1.50                  UCSC.utils_1.2.0            NbClust_3.0.1              
# [76] timechange_0.3.0            foreach_1.5.2               ggjoy_0.4.1                
# [79] patchwork_1.3.1             grid_4.4.1                  data.table_1.17.8          
# [82] rhdf5_2.50.2                ruv_0.9.7.1                 pwalign_1.2.0              
# [85] R.oo_1.27.1                 RSpectra_0.16-2             irlba_2.3.5.1              
# [88] fastDummies_1.7.5           DescTools_0.99.60           aroma.light_3.36.0         
# [91] lazyeval_0.2.2              yaml_2.3.10                 survival_3.8-3             
# [94] SpatialExperiment_1.16.0    scattermore_1.2             crayon_1.5.3               
# [97] RcppAnnoy_0.0.22            RColorBrewer_1.1-3          progressr_0.15.1           
# [100] tweenr_2.0.3                later_1.4.2                 ggridges_0.5.6             
# [103] codetools_0.2-20            GlobalOptions_0.1.2         Seurat_5.3.0               
# [106] Rtsne_0.17                  shape_1.4.6.1               Rsamtools_2.22.0           
# [109] filelock_1.0.3              data.tree_1.1.0             pkgconfig_2.0.3            
# [112] xml2_1.3.8                  spatstat.univar_3.1-4       GenomicAlignments_1.42.0   
# [115] GenomicRanges_1.58.0        spatstat.sparse_3.1-0       viridisLite_0.4.2          
# [118] xtable_1.8-4                interp_1.1-6                hwriter_1.3.2.1            
# [121] car_3.1-3                   plyr_1.8.9                  httr_1.4.7                 
# [124] tools_4.4.1                 globals_0.18.0              SeuratObject_5.1.0         
# [127] Rfast_2.1.5.1               broom_1.0.9                 nlme_3.1-168               
# [130] dbplyr_2.5.0                survMisc_0.5.6              digest_0.6.37              
# [133] Matrix_1.7-3                farver_2.1.2                tzdb_0.5.0                 
# [136] viridis_0.6.5               glue_1.8.0                  cachem_1.1.0               
# [139] BiocFileCache_2.14.0        polyclip_1.10-7             generics_0.1.4             
# [142] Biostrings_2.74.1           mvtnorm_1.3-3               parallelly_1.45.1          
# [145] testit_0.13                 statmod_1.5.0               ragg_1.4.0                 
# [148] RcppHNSW_0.6.0              ScaledMatrix_1.14.0         carData_3.0-5              
# [151] pbapply_1.7-4               httr2_1.2.1                 SummarizedExperiment_1.36.0
# [154] vroom_1.6.5                 spam_2.11-1                 dqrng_0.4.1                
# [157] utf8_1.2.6                  quantiseqr_1.14.0           gtools_3.9.5               
# [160] readxl_1.4.5                preprocessCore_1.68.0       gridExtra_2.3              
# [163] shiny_1.11.1                GSVA_2.0.7                  GenomeInfoDbData_1.2.13    
# [166] R.utils_2.13.0              rhdf5filters_1.18.1         RCurl_1.98-1.17            
# [169] memoise_2.0.1               rmarkdown_2.29              mMCPcounter_1.1.0          
# [172] scales_1.4.0                RUVIIIPRPS_0.0.0.9000       R.methodsS3_1.8.2          
# [175] gld_2.6.7                   future_1.67.0               singscore_1.26.0           
# [178] limSolve_2.0.1              RANN_2.6.2                  km.ci_0.5-6                
# [181] spatstat.data_3.1-6         rstudioapi_0.17.1           cluster_2.1.8.1            
# [184] spatstat.utils_3.1-5        hms_1.1.3                   fitdistrplus_1.2-4         
# [187] cowplot_1.2.0               colorspace_2.1-1            quadprog_1.5-8             
# [190] GenomeInfoDb_1.42.3         DelayedMatrixStats_1.28.1   sparseMatrixStats_1.18.0   
# [193] dotCall64_1.2               circlize_0.4.16             scuttle_1.16.0             
# [196] mgcv_1.9-3                  xfun_0.52                   e1071_1.7-16               
# [199] iterators_1.0.14            matrixStats_1.5.0           abind_1.4-8                
# [202] Rhdf5lib_1.28.0             bitops_1.0-9                promises_1.3.3             
# [205] RSQLite_2.4.2               qvalue_2.38.0               DelayedArray_0.32.0        
# [208] proxy_0.4-27                compiler_4.4.1              prettyunits_1.2.0          
# [211] boot_1.3-31                 beachmat_2.22.0             listenv_0.9.1              
# [214] Rcpp_1.1.0                  edgeR_4.4.2                 BiocSingular_1.22.0        
# [217] tensor_1.5.1                MASS_7.3-65                 progress_1.2.3             
# [220] BiocParallel_1.40.2         xCell_1.1.0                 spatstat.random_3.4-1      
# [223] R6_2.6.1                    fastmap_1.2.0               EDASeq_2.40.0              
# [226] ROCR_1.0-11                 ggstats_0.10.0              rsvd_1.0.5                 
# [229] gtable_0.3.6                KernSmooth_2.23-26          latticeExtra_0.6-30        
# [232] miniUI_0.1.2                deldir_2.0-4                htmltools_0.5.8.1          
# [235] RcppParallel_5.1.10         bit64_4.6.0-1               spatstat.explore_3.5-2     
# [238] lifecycle_1.0.4             S7_0.2.0                    zigg_0.0.2                 
# [241] restfulr_0.0.16             vctrs_0.6.5                 ggforestplot_0.1.0         
# [244] spatstat.geom_3.5-0         scran_1.34.0                haven_2.5.5                
# [247] sp_2.2-0                    pracma_2.4.4                future.apply_1.20.0        
# [250] pillar_1.11.0               batchelor_1.22.0            magick_2.8.7               
# [253] GenomicFeatures_1.58.0      ComICS_1.0.4                ShortRead_1.64.0           
# [256] metapod_1.14.0              locfit_1.5-9.12             jsonlite_2.0.0             
# [259] expm_1.0-0                  GetoptLong_1.0.5           

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

#start generate linear model with limma:
cellfrac <- base %>% column_to_rownames("cell_type") %>% as.matrix()
cellfrac <- t(cellfrac)
group <- relevel(group, ref = "Vehicle")

## Model1: group + BASE + tumor purity
design_m1 <- model.matrix(~ 0 + group + cellfrac + purity)
colnames(design_m1) <- make.names(colnames(design_m1))
colnames(design_m1)

fit_m1 <- lmFit(CPM_TMM, design_m1)
contr_m1 <- makeContrasts(
  AntiPD1_vs_Vehicle = groupAnti.PD.1- groupVehicle,
  EPAT_vs_Vehicle = groupEPAT - groupVehicle,
  Combo_vs_Vehicle = groupAnti.PD.1.EPAT - groupVehicle,
  AntiPD1_vs_EPAT = groupAnti.PD.1- groupEPAT,
  Combo_vs_EPAT = groupAnti.PD.1.EPAT - groupEPAT,
  Combo_vs_AntiPD1 = groupAnti.PD.1.EPAT - groupAnti.PD.1,
  levels = design_m1)
fit_m1c <- eBayes(contrasts.fit(fit_m1, contr_m1), robust = TRUE)

#log fold change and p-value for each gene in each comparison
res_m1_AntiPD1_vs_Vehicle <- topTable(fit_m1c, coef = "AntiPD1_vs_Vehicle", number = Inf)
res_m1_EPAT_vs_Vehicle <- topTable(fit_m1c, coef = "EPAT_vs_Vehicle", number = Inf)
res_m1_Combo_vs_Vehicle <- topTable(fit_m1c, coef = "Combo_vs_Vehicle", number = Inf)
res_m1_AntiPD1_vs_EPAT <- topTable(fit_m1c, coef = "AntiPD1_vs_EPAT", number = Inf)
res_m1_Combo_vs_EPAT <- topTable(fit_m1c, coef = "Combo_vs_EPAT", number = Inf)
res_m1_Combo_vs_AntiPD1 <- topTable(fit_m1c, coef = "Combo_vs_AntiPD1", number = Inf)

## Model2: group + BASE only
design_m2 <- model.matrix(~ 0 + group + cellfrac)
colnames(design_m2) <- make.names(colnames(design_m2))
colnames(design_m2)

fit_m2 <- lmFit(CPM_TMM, design_m2)
contr_m2 <- makeContrasts(
  AntiPD1_vs_Vehicle = groupAnti.PD.1 - groupVehicle,
  EPAT_vs_Vehicle = groupEPAT - groupVehicle,
  Combo_vs_Vehicle = groupAnti.PD.1.EPAT - groupVehicle,
  AntiPD1_vs_EPAT = groupAnti.PD.1 - groupEPAT,
  Combo_vs_EPAT = groupAnti.PD.1.EPAT - groupEPAT,
  Combo_vs_AntiPD1= groupAnti.PD.1.EPAT - groupAnti.PD.1,
  levels = design_m2)
fit_m2c <- eBayes(contrasts.fit(fit_m2, contr_m2), robust = TRUE)

res_m2_AntiPD1_vs_Vehicle <- topTable(fit_m2c, coef = "AntiPD1_vs_Vehicle", number = Inf)
res_m2_EPAT_vs_Vehicle <- topTable(fit_m2c, coef = "EPAT_vs_Vehicle", number = Inf)
res_m2_Combo_vs_Vehicle <- topTable(fit_m2c, coef = "Combo_vs_Vehicle", number = Inf)
res_m2_AntiPD1_vs_EPAT <- topTable(fit_m2c, coef = "AntiPD1_vs_EPAT", number = Inf)
res_m2_Combo_vs_EPAT <- topTable(fit_m2c, coef = "Combo_vs_EPAT", number = Inf)
res_m2_Combo_vs_AntiPD1 <- topTable(fit_m2c, coef = "Combo_vs_AntiPD1", number = Inf)

#Model3 : group + purity only
design_m3 <- model.matrix(~ 0 + group + purity)
colnames(design_m3) <- make.names(colnames(design_m3))
colnames(design_m3)

fit_m3 <- lmFit(CPM_TMM, design_m3)

contr_m3 <- makeContrasts(
  AntiPD1_vs_Vehicle = groupAnti.PD.1 - groupVehicle,
  EPAT_vs_Vehicle = groupEPAT - groupVehicle,
  Combo_vs_Vehicle = groupAnti.PD.1.EPAT - groupVehicle,
  AntiPD1_vs_EPAT = groupAnti.PD.1 - groupEPAT,
  Combo_vs_EPAT = groupAnti.PD.1.EPAT - groupEPAT,
  Combo_vs_AntiPD1 = groupAnti.PD.1.EPAT - groupAnti.PD.1,
  levels = design_m3)

fit_m3c <- eBayes(contrasts.fit(fit_m3, contr_m3), robust = TRUE)

res_m3_AntiPD1_vs_Vehicle <- topTable(fit_m3c, coef = "AntiPD1_vs_Vehicle", number = Inf)
res_m3_EPAT_vs_Vehicle <- topTable(fit_m3c, coef = "EPAT_vs_Vehicle", number = Inf)
res_m3_Combo_vs_Vehicle <- topTable(fit_m3c, coef = "Combo_vs_Vehicle", number = Inf)
res_m3_AntiPD1_vs_EPAT <- topTable(fit_m3c, coef = "AntiPD1_vs_EPAT", number = Inf)
res_m3_Combo_vs_EPAT <- topTable(fit_m3c, coef = "Combo_vs_EPAT", number = Inf)
res_m3_Combo_vs_AntiPD1 <- topTable(fit_m3c, coef = "Combo_vs_AntiPD1", number = Inf)

## Model4 : group only
design_m4 <- model.matrix(~ 0 + group)
colnames(design_m4) <- make.names(colnames(design_m4))
colnames(design_m4)

fit_m4 <- lmFit(logCPM, design_m4)
contr_m4 <- makeContrasts(
  AntiPD1_vs_Vehicle  = groupAnti.PD.1 - groupVehicle,
  EPAT_vs_Vehicle = groupEPAT - groupVehicle,
  Combo_vs_Vehicle = groupAnti.PD.1.EPAT - groupVehicle,
  AntiPD1_vs_EPAT = groupAnti.PD.1 - groupEPAT,
  Combo_vs_EPAT = groupAnti.PD.1.EPAT - groupEPAT,
  Combo_vs_AntiPD1 = groupAnti.PD.1.EPAT - groupAnti.PD.1,
  levels = design_m4)
fit_m4c <- eBayes(contrasts.fit(fit_m4, contr_m4), robust = TRUE)

res_m4_AntiPD1_vs_Vehicle <- topTable(fit_m4c, coef = "AntiPD1_vs_Vehicle", number = Inf)
res_m4_EPAT_vs_Vehicle <- topTable(fit_m4c, coef = "EPAT_vs_Vehicle", number = Inf)
res_m4_Combo_vs_Vehicle <- topTable(fit_m4c, coef = "Combo_vs_Vehicle", number = Inf)
res_m4_AntiPD1_vs_EPAT <- topTable(fit_m4c, coef = "AntiPD1_vs_EPAT", number = Inf)
res_m4_Combo_vs_EPAT  <- topTable(fit_m4c, coef = "Combo_vs_EPAT",  number = Inf)
res_m4_Combo_vs_AntiPD1 <- topTable(fit_m4c, coef = "Combo_vs_AntiPD1", number = Inf)

#Box and whiskers plot from base output
base_long <- melt(base, id.vars = "cell_type", variable.name = "Sample", value.name = "Score")
sample_df <- data.frame(Sample = colnames(base)[-1], Group  = group, check.names = FALSE)
base_long <- merge(base_long, sample_df, by = "Sample")
#Box & whisker plots with y limit [-2, 2]
ggplot(base_long, aes(x = Group, y = Score, fill = Group)) +
  geom_boxplot(outlier.size = 0.6) +
  facet_wrap(~ cell_type, scales = "free_y", ncol = 4) +
  coord_cartesian(ylim = c(-2, 2)) +   # <- fixed y-axis range
  theme_minimal(base_size = 11) +
  labs(title = "Cell-type enrichment scores (BASE output)", x = "Treatment group", y = "Enrichment score") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
  legend.position = "none")

# p-value distribution to compare the same contrast with different model(model1, model2, model3, model4)
# res_m1_AntiPD1_vs_Vehicle  res_m1_EPAT_vs_Vehicle     res_m1_Combo_vs_Vehicle res_m1_AntiPD1_vs_EPAT     res_m1_Combo_vs_EPAT       res_m1_Combo_vs_AntiPD1
#all contrast group with model 1, if model 2 swap m1 to m2
#Example for combination vs vehicle with model1 vs model 4 
df_p <- data.frame(
  pval = c(res_m1_Combo_vs_Vehicle, res_m4_Combo_vs_Vehicle),
  Model = rep(c("With purity", "Without purity and BASE"),c(length(res_m1_Combo_vs_Vehicle), length(res_m4_Combo_vs_Vehicle))))
# Anti-PD-1 + EPAT vs Vehicle Histogram of p-values
ggplot(df_p, aes(x = pval, fill = Model)) +
  geom_histogram(bins = 30, alpha = 0.6, position = "identity") +
  theme_minimal(base_size = 13) +
  labs(title = "P-value distribution (Anti-PD-1+ EPAT vs Vehicle) - BASE",
  x = "P-value", y = "Count") +
  scale_fill_manual(values = c("steelblue", "tomato"))

#volcano plot function for genes in that contrast group using model 1 Anti-PD-1 + EPAT vs Vehicle
plot_volcano_with <- function(res_1, title_text) {
  res <- res_1
  res$CellType <- rownames(res)
  res$Significance <- "Middle"
  res$Significance[res$logFC > 0.585 & res$P.Value < 0.05] <- "Up"
  res$Significance[res$logFC < -0.585 & res$P.Value < 0.05] <- "Down"

  ggplot(res, aes(x = logFC, y = -log10(P.Value), color = Significance)) +
    geom_point(alpha = 0.7, size = 2) +
    geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "grey40") +
    geom_vline(xintercept = c(-0.585, 0.585), linetype = "dashed", color = "grey40") +
    scale_color_manual(values = c("Up"="red", "Down"="blue", "Middle"="grey")) +
    labs(title = title_text, x = "log2 Fold Change", y = "-log10 P-value") + xlim(-5, 5) + ylim(0, 6) +
    theme_minimal(base_size = 13) +
    theme(legend.position = "none")}

#example: Anti-PD-1 + EPAT vs Vehicle
plot_volcano_with(res_m1_Combo_vs_Vehicle, "Volcano: Anti-PD-1 + EPAT vs Vehicle (BASE, with purity)")

#example:  Anti-PD-1 vs Vehicle
plot_volcano_with(res_m1_AntiPD1_vs_Vehicle, "Volcano: Anti-PD-1 vs Vehicle (BASE, with purity)")

#volcano plot function for genes in that contrast group using model 1 Anti-PD-1 + EPAT vs Vehicle as example, highlight positive(yellow) and negative control gene(blue)

plot_volcano_highlights <- function(
  res_with,
  title_text,
  anti_ids,
  neg_ids,
  anti_color = "#E69F00",  # positive control
neg_color  = "#56B4E9",  # negative control
other_color = "grey80",
point_size = 2,
alpha = 0.7,
xlim_vals = c(-5, 5),
ylim_vals = c(0, 6)) {
  res <- res_with
  
  
  # Base plot with background points
  p <- ggplot(res, aes(x = logFC, y = -log10(P.Value))) +
    geom_point(color = other_color, size = point_size, alpha = alpha) +
    labs(
    title = title_text,
    x = "log2 Fold Change",
    y = "-log10 P-value" ) +
    coord_cartesian(xlim = xlim_vals, ylim = ylim_vals, expand = FALSE) +
    theme_minimal(base_size = 13)
  
  # Negative control (at back)
  p <- p + geom_point(
    data = subset(res, GeneID %in% neg_ids),
    aes(x = logFC, y = -log10(P.Value)),
    color = neg_color,
    size = point_size + 0.8,
    alpha = 0.9)
  
  # Positive control (at front)
  p <- p + geom_point(
    data = subset(res, GeneID %in% anti_ids),
    aes(x = logFC, y = -log10(P.Value)),
    color = anti_color,
    size = point_size + 1.0,
    alpha = 1)
  
  p}

#combination vs vehicle from model 1 with positive and negative control genes previously generated
plot_volcano_highlights(
  res_m1_Combo_vs_Vehicle,
  "Volcano: Anti-PD-1 + EPAT vs Vehicle (BASE, with purity)",
  anti_ids = antiPD1_ids,
  neg_ids  = random_neg32$ensembl_gene_id)

#to look for gene that is over absolute log fold change 0.585 and p-value less than 0.05
#Anti-PD-1+EPAT vs Vehicle with model 1, sort according to p-value
sig_genes_up <- res_m1_Combo_vs_Vehicle %>%
  subset((logFC > 0.585 | logFC < -0.585) & P.Value < 0.05) %>%
  .[order(.$P.Value), ]
Comb_Veh<- rownames(sig_genes_up)

# then use below code to get gene list
cat(Comb_Veh, sep = "\n")

