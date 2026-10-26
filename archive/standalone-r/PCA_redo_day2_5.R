#redo Day2 and Day5 PCA
#library size
raw <- raw[, colnames(filtered)] 
library_size <- colSums(raw) 
library_size
summary(library_size)

#tumor purity
scores <- read.table("output_scores_2.gct", header = TRUE, skip = 2, row.names = 1, sep = "\t")
estimate_scores <- as.numeric(scores["ESTIMATEScore", ])
estimate_scores <- estimate_scores[!is.na(estimate_scores)]
tumor_purity <- cos(0.6049872018 + 0.0001467884 * estimate_scores)
tumor_purity
summary(tumor_purity)

new_group #which treatment group

batch_info <- ifelse(colnames(filtered) %in% day2_samples, "day2", "day5")#day2 or day5
#################################################################################
# Step 1: Create a metadata data frame
meta_df <- data.frame(
  library_size = library_size,
  tumor_purity = tumor_purity,
  new_group = new_group,
  batch_info = batch_info,
  row.names = colnames(filtered), # ensure sample names align
  stringsAsFactors = FALSE
)

# Step 2: Transpose it so rows become 'library_size', etc.
meta_rows <- t(meta_df)

# Step 3: Combine metadata rows with filtered data
combined_filtered <- rbind(meta_rows, filtered)

#do it for CPM_TMM
combined_cpm <- rbind(meta_rows, cpm_data_1)
###############################################################################
# Get column names of samples that are in day2
names(batch_info) <- colnames(filtered)
day2_cols <- names(batch_info[batch_info == "day2"])

# Subset the full combined_filtered matrix by these columns
filtered_day2 <- combined_filtered[, day2_cols]
###############################################################################
# Get column names of samples that are in day5
names(batch_info) <- colnames(filtered)
day5_cols <- names(batch_info[batch_info == "day5"])

# Subset the full combined_filtered matrix by these columns
filtered_day5 <- combined_filtered[, day5_cols]
###############################################################################
# Get column names of samples that are in day2 and day5 for CPM_TMM
cpm_day2 <- combined_cpm[, day2_cols]
cpm_day5 <- combined_cpm[, day5_cols]
###############################################################################
# Get column names of samples that are in day2 and day5 for CPM_TMM
cpm_only_day2 <- cpm_only[, day2_cols]
cpm_only_day5 <- cpm_only[, day5_cols]
###############################################################################
library(ggplot2)
library(ggExtra)

# Step 1: Remove the first 4 metadata rows
filtered_day2_expr <- filtered_day2[-c(1:4), ]

# Step 2: Convert expression matrix to numeric and log2 transform
log_counts <- apply(filtered_day2_expr, 2, function(x) as.numeric(x))
log_counts <- log2(log_counts + 1)

# Step 3: Perform PCA (transpose so samples are rows)
pca_result <- prcomp(t(log_counts), scale. = TRUE)

# Step 4: Extract new_group (3rd metadata row) for grouping
new_group_day2 <- as.factor(as.character(unlist(filtered_day2[3, ])))

# Step 5: Create PCA data frame and add group info
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group_day2

# Step 6: Extract variance explained
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Step 7: Base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3) +
  labs(
    title = "PCA - Day 2 labeled by treatment group",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)")
  ) +
  xlim(-200, 200) +  # Reverse x-axis direction
  ylim(-200, 200) +
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
# library size day2
library_sizes_day2 <- as.numeric(filtered_day2[1, ])

# Step 6: Add library size to PCA dataframe
pca_data$LibrarySize <- library_sizes_day2

# Step 7: Plot PCA with color gradient based on library size
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(library_size), max(library_size))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA - Day 2 labeled by library size",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Library Size"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
#tumor purity
# Step 5: Extract tumor purity from 2nd row of filtered_day2
tumor_purity_day2 <- as.numeric(filtered_day2[2, ])
pca_data$TumorPurity <- tumor_purity_day2

# Step 7: Plot
ggplot(pca_data, aes(x = PC1, y = PC2, color = TumorPurity)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(tumor_purity_day2), max(tumor_purity_day2))  # full range for consistent scaling
  )+
  labs(
    title = "PCA Plot - Day 2 labeled by tumor purity",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Tumor Purity"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
#tumor purity
#redo PC3 and PC4
pc3_var <- round(pca_var[3] * 100, 1)
pc4_var <- round(pca_var[4] * 100, 1)
tumor_purity_day2 <- as.numeric(filtered_day2[2, ])
pca_data$TumorPurity <- tumor_purity_day2

# Step 7: Plot
ggplot(pca_data, aes(x = PC3, y = PC4, color = TumorPurity)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(tumor_purity_day2), max(tumor_purity_day2))  # full range for consistent scaling
  )+
  labs(
    title = "PCA Plot - Day 2 labeled by tumor purity",
    x = paste0("PC3 (", pc3_var, "%)"),
    y = paste0("PC4 (", pc4_var, "%)"),
    color = "Tumor Purity"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
#day5
library(ggplot2)
library(ggExtra)

# Step 1: Remove the first 4 metadata rows
filtered_day5_expr <- filtered_day5[-c(1:4), ]

# Step 2: Convert expression matrix to numeric and log2 transform
log_counts <- apply(filtered_day5_expr, 2, function(x) as.numeric(x))
log_counts <- log2(log_counts + 1)

# Step 3: Perform PCA (transpose so samples are rows)
pca_result <- prcomp(t(log_counts), scale. = TRUE)

# Step 4: Extract new_group (3rd metadata row) for grouping
new_group_day5 <- as.factor(as.character(unlist(filtered_day5[3, ])))

# Step 5: Create PCA data frame and add group info
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group_day5


# Step 6: Extract variance explained
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)
##pca_data$Sample <- colnames(filtered_day5_expr)
##pca_data$Label <- ifelse(pca_data$Sample == "AM6_7.1_S30", pca_data$Sample, "")

# Step 7: Base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +
  ##geom_text(aes(label = Label), vjust = -0.5, size = 3) +
  geom_point(size = 3) +
  labs(
    title = "PCA - Day 5 labeled by treatment group",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc1_var, "%)")
  ) +
  xlim(-200, 200) +  # Reverse x-axis direction
  ylim(-200, 200) +
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
# library size day5

library_sizes_day5 <- as.numeric(filtered_day5[1, ])

# Step 6: Add library size to PCA dataframe
pca_data$LibrarySize <- library_sizes_day5

# Step 7: Plot PCA with color gradient based on library size
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(library_sizes_day5), max(library_sizes_day5))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA - Day 5 labeled by library size",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Library Size"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
#tumor purity
# Step 5: Extract tumor purity from 2nd row of filtered_day2
tumor_purity_day5 <- as.numeric(filtered_day5[2, ])
pca_data$TumorPurity <- tumor_purity_day5

# Step 7: Plot
ggplot(pca_data, aes(x = PC1, y = PC2, color = TumorPurity)) +
  geom_point(size = 3) +scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(tumor_purity_day5), max(tumor_purity_day5))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA Plot - Day 5 labeled by tumor purity",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Tumor Purity"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
###PCA after CPM-TMM
# Step 1: Remove the first 4 metadata rows
cpm_day2_expr <- cpm_day2[-c(1:4), ]

# Convert all columns to numeric
cpm_day2_expr_numeric <- apply(cpm_day2_expr, 2, function(x) as.numeric(as.character(x)))

# Perform PCA on the normalized data (transpose so that samples are rows)
pca_result <- prcomp(t(cpm_day2_expr_numeric), scale. = TRUE)


# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group_day2  # 'new_group' should be a vector/factor defining sample groups

# Calculate the proportion of variance explained for PC1 and PC2
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Create the base PCA scatter plot with updated axis labels
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3) +
  labs(
    title = "PCA - Day 2 labaled by treatment group",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)")
  ) +
  xlim(-200, 200) +  # Reverse x-axis direction
  ylim(-200, 200)+
  theme_minimal() +
  theme(
    legend.title = element_text(size = 10),
    legend.text  = element_text(size = 8)
  )

# Add volcano-style (density) marginal plots along the x and y axes
p_marginal <- ggMarginal(p, type = "density", groupColour = TRUE, groupFill = TRUE)

# Display the final plot
print(p_marginal)
###############################################################################
# Step 6: Add library size to PCA dataframe
pca_data$LibrarySize <- library_sizes_day2

# Step 7: Plot PCA with color gradient based on library size
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(library_size), max(library_size))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA - Day 2 labeled by library size",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Library Size"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
#tumor purity

pca_data$TumorPurity <- tumor_purity_day2

# Step 7: Plot
ggplot(pca_data, aes(x = PC1, y = PC2, color = TumorPurity)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(tumor_purity_day2), max(tumor_purity_day2))  # full range for consistent scaling
  )+
  labs(
    title = "PCA Plot - Day 2 labeled by tumor purity",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Tumor Purity"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
###PCA after CPM-TMM
# Step 1: Remove the first 4 metadata rows
cpm_day5_expr <- cpm_day5[-c(1:4), ]

# Convert all columns to numeric
cpm_day5_expr_numeric <- apply(cpm_day5_expr, 2, function(x) as.numeric(as.character(x)))

# Perform PCA on the normalized data (transpose so that samples are rows)
pca_result <- prcomp(t(cpm_day5_expr_numeric), scale. = TRUE)


# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group_day5  # 'new_group' should be a vector/factor defining sample groups

# Calculate the proportion of variance explained for PC1 and PC2
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Create the base PCA scatter plot with updated axis labels
p <- ggplot(pca_data, aes(x = PC3, y = PC4, color = Group)) +
  geom_point(size = 3) + #geom_text(aes(label = Sample), vjust = -0.5, size = 3) for label
  labs(
    title = "PCA - Day 5 labaled by treatment group",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)")
  ) +
  xlim(-200, 200) +  # Reverse x-axis direction
  ylim(-200, 200)+
  theme_minimal() +
  theme(
    legend.title = element_text(size = 10),
    legend.text  = element_text(size = 8)
  )

# Add volcano-style (density) marginal plots along the x and y axes
p_marginal <- ggMarginal(p, type = "density", groupColour = TRUE, groupFill = TRUE)

# Display the final plot
print(p_marginal)
###############################################################################
# library size day5
# Step 6: Add library size to PCA dataframe
pca_data$LibrarySize <- library_sizes_day5

# Step 7: Plot PCA with color gradient based on library size
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(library_sizes_day5), max(library_sizes_day5))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA - Day 5 labeled by library size",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Library Size"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
#tumor purity

# Step 6: Build PCA dataframe

pca_data$TumorPurity <- tumor_purity_day5


# Step 7: Plot
ggplot(pca_data, aes(x = PC1, y = PC2, color = TumorPurity)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(tumor_purity_day5), max(tumor_purity_day5))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA Plot - Day 5 labeled by tumor purity",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Tumor Purity"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
###############################################################################
###PCA after CPM only for day 2

# Convert all columns to numeric
cpm_only_day2_numeric <- apply(cpm_only_day2, 2, function(x) as.numeric(as.character(x)))

# Perform PCA on the normalized data (transpose so that samples are rows)
pca_result <- prcomp(t(cpm_only_day2_numeric), scale. = TRUE)


# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group_day2  # 'new_group' should be a vector/factor defining sample groups

# Calculate the proportion of variance explained for PC1 and PC2
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Create the base PCA scatter plot with updated axis labels
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3) +
  labs(
    title = "PCA - Day 2 labaled by treatment group",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)")
  ) +
  xlim(-200, 200) +  # Reverse x-axis direction
  ylim(-200, 200)+
  theme_minimal() +
  theme(
    legend.title = element_text(size = 10),
    legend.text  = element_text(size = 8)
  )

# Add volcano-style (density) marginal plots along the x and y axes
p_marginal <- ggMarginal(p, type = "density", groupColour = TRUE, groupFill = TRUE)

# Display the final plot
print(p_marginal)
###############################################################################
# Step 6: Add library size to PCA dataframe
pca_data$LibrarySize <- library_sizes_day2

# Step 7: Plot PCA with color gradient based on library size
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(library_size), max(library_size))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA - Day 2 labeled by library size",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Library Size"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
#tumor purity

pca_data$TumorPurity <- tumor_purity_day2

# Step 7: Plot
ggplot(pca_data, aes(x = PC1, y = PC2, color = TumorPurity)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(tumor_purity_day2), max(tumor_purity_day2))  # full range for consistent scaling
  )+
  labs(
    title = "PCA - Day 2 labeled by tumor purity",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Tumor Purity"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
###PCA after CPMonly for day5
# Convert all columns to numeric
cpm_only_day5_numeric <- apply(cpm_only_day5, 2, function(x) as.numeric(as.character(x)))

# Perform PCA on the normalized data (transpose so that samples are rows)
pca_result <- prcomp(t(cpm_only_day5_numeric), scale. = TRUE)


# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group_day5  # 'new_group' should be a vector/factor defining sample groups

# Calculate the proportion of variance explained for PC1 and PC2
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Create the base PCA scatter plot with updated axis labels
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3) + #geom_text(aes(label = Sample), vjust = -0.5, size = 3) for label
  labs(
    title = "PCA - Day 5 labaled by treatment group",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)")
  ) +
  xlim(-200, 200) +  # Reverse x-axis direction
  ylim(-200, 200)+
  theme_minimal() +
  theme(
    legend.title = element_text(size = 10),
    legend.text  = element_text(size = 8)
  )

# Add volcano-style (density) marginal plots along the x and y axes
p_marginal <- ggMarginal(p, type = "density", groupColour = TRUE, groupFill = TRUE)

# Display the final plot
print(p_marginal)
###############################################################################
# library size day5
# Step 6: Add library size to PCA dataframe
pca_data$LibrarySize <- library_sizes_day5

# Step 7: Plot PCA with color gradient based on library size
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(library_sizes_day5), max(library_sizes_day5))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA - Day 5 labeled by library size",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Library Size"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
#tumor purity

# Step 6: Build PCA dataframe

pca_data$TumorPurity <- tumor_purity_day5


# Step 7: Plot
ggplot(pca_data, aes(x = PC1, y = PC2, color = TumorPurity)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(tumor_purity_day5), max(tumor_purity_day5))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA - Day 5 labeled by tumor purity",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Tumor Purity"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
## total: Example: log-transform the data
log_counts <- log2(filtered + 1)

# Perform PCA (transposing so samples are rows, genes are columns)
pca_result <- prcomp(t(log_counts), scale. = TRUE)

# Step 4: Extract new_group (3rd metadata row) for grouping
new_group_day2 <- as.factor(as.character(unlist(filtered_day2[3, ])))

pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group  # Factor/Group variable
pca_data$Day = batch_info
# Step 6: Extract variance explained
pca_var <- summary(pca_result)$importance[2, ]
pc3_var <- round(pca_var[3] * 100, 1)
pc4_var <- round(pca_var[4] * 100, 1)
pca_data$Sample <- colnames(filtered)
pca_data$Label <- ifelse(pca_data$Sample == "AM6_7.1_S30", pca_data$Sample, "")


# Step 7: Base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC3, y = PC4, color = Group, shape = Day)) +
  geom_text(aes(label = Label), vjust = -0.5, size = 3) +
  geom_point(size = 3) +
  labs(
    title = "PCA labeled by treatment group and day",
    x = paste0("PC3 (", pc3_var, "%)"),
    y = paste0("PC4 (", pc4_var, "%)")
  ) +
  xlim(-200, 200) +  # Reverse x-axis direction
  ylim(-200, 200) +
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
pca_data$LibrarySize <- library_size

# Step 7: Plot PCA with color gradient based on library size
ggplot(pca_data, aes(x = PC3, y = PC4, color = LibrarySize, shape = Day)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(library_size), max(library_size))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA labeled by library size and day",
    x = paste0("PC3 (", pc3_var, "%)"),
    y = paste0("PC4 (", pc4_var, "%)"),
    color = "Library Size"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
# Step 6: Build PCA dataframe
# Step 7: Plot
pca_data$TumorPurity <- tumor_purity

ggplot(pca_data, aes(x = PC3, y = PC4, color = TumorPurity, shape = Day)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(tumor_purity), max(tumor_purity))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA Plot labeled by tumor purity and day",
    x = paste0("PC3 (", pc3_var, "%)"),
    y = paste0("PC4 (", pc4_var, "%)"),
    color = "Tumor Purity"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
##after CPM_TMM
pca_result <- prcomp(t(cpm_data), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group  # Factor/Group variable
pca_data$Day = batch_info
pca_data$Sample <- colnames(cpm_data)
pca_data$Label <- ifelse(pca_data$Sample == "AM6_7.1_S30", pca_data$Sample, "")


# Step 6: Extract variance explained
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Step 7: Base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group, shape = Day)) +
  geom_point(size = 3) +
  geom_text(aes(label = Label), vjust = -0.5, size = 3) +
  labs(
    title = "PCA labeled by treatment group and day",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)")
  ) +
  xlim(-200, 200) +  # Reverse x-axis direction
  ylim(-200, 200) +
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
pca_data$LibrarySize <- library_size

# Step 7: Plot PCA with color gradient based on library size
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize, shape = Day)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(library_size), max(library_size))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA labeled by library size and day",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Library Size"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
# Step 6: Build PCA dataframe
# Step 7: Plot
pca_data$TumorPurity <- tumor_purity

ggplot(pca_data, aes(x = PC1, y = PC2, color = TumorPurity, shape = Day)) +
  geom_point(size = 3) +
  scale_color_gradientn(
    colors = c("blue", "yellow", "red"),
    limits = c(min(tumor_purity), max(tumor_purity))  # full range for consistent scaling
  ) +
  labs(
    title = "PCA Plot labeled by tumor purity and day",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)"),
    color = "Tumor Purity"
  ) +
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################