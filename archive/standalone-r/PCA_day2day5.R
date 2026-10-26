# Method 1: Using a logical vector
filtered_day2 <- filtered[, colnames(filtered) %in% day2_samples]

# Method 2: Using intersect (preserves the order of colnames(filtered))
filtered_day2 <- filtered[, intersect(colnames(filtered), day2_samples)]

# Create new_group_day2 by matching the sample names in filtered_day2
new_group_day2 <- sample_treatment$Treatment[match(colnames(filtered_day2), sample_treatment$Sample)]

library_sizes_day2 <- sample_library_sizes$Library_Size[match(colnames(filtered_day2), sample_library_sizes$Sample)]
tumor_purity_day2 <- sample_tumor_purity$Tumor_Purity[match(colnames(filtered_day2), sample_tumor_purity$Sample)]

cpm_day2 <- cpm_data[, colnames(cpm_data) %in% day2_samples]
cpm_day2 <- cpm_data[, intersect(colnames(cpm_data), day2_samples)]

# Method 1: Using a logical vector
filtered_day5 <- filtered[, colnames(filtered) %in% day5_samples]

# Method 2: Using intersect (preserves the order of colnames(filtered))
filtered_day5 <- filtered[, intersect(colnames(filtered), day5_samples)]

# Create new_group_day2 by matching the sample names in filtered_day2
new_group_day5 <- sample_treatment$Treatment[match(colnames(filtered_day5), sample_treatment$Sample)]

library_sizes_day5 <- sample_library_sizes$Library_Size[match(colnames(filtered_day5), sample_library_sizes$Sample)]
tumor_purity_day5 <- sample_tumor_purity$Tumor_Purity[match(colnames(filtered_day5), sample_tumor_purity$Sample)]

cpm_day5 <- cpm_data[, colnames(cpm_data) %in% day5_samples]
cpm_day5 <- cpm_data[, intersect(colnames(cpm_data), day5_samples)]
################################################################################
###PCA before normalization
# Example: log-transform the data
log_counts <- log2(filtered_day2 + 1)

# Perform PCA (transposing so samples are rows, genes are columns)
pca_result <- prcomp(t(log_counts), scale. = TRUE)

# Convert PCA result to a data frame
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group_day2  # Factor/Group variable

# Extract percentage of variance explained for PC1, PC2
pca_var <- summary(pca_result)$importance[2, ]  # Row 2 = Proportion of Variance
pc1_var <- round(pca_var[1] * 100, 1)          # PC1 in %
pc2_var <- round(pca_var[2] * 100, 1)          # PC2 in %

# Create the base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3) +
  labs(
    title = "PCA - Day 2 labeled by treatment group",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)")
  ) +
  theme_minimal() +
  theme(
    legend.title = element_text(size = 10),
    legend.text  = element_text(size = 8)
  )

# Add marginal "volcano"-style (density) plots along x and y axes
p_marginal <- ggMarginal(
  p,
  type = "density",        # 'density' for the "volcano" style
  groupColour = TRUE,      # Keep group color lines
  groupFill   = TRUE       # Keep group fill colors
)

# Print the final plot with marginal densities
print(p_marginal)


################################################################################
###PCA before normalization
# Example: log-transform the data
log_counts <- log2(filtered_day5 + 1)

# Perform PCA (transposing so samples are rows, genes are columns)
pca_result <- prcomp(t(log_counts), scale. = TRUE)

# Convert PCA result to a data frame
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group_day5  # Factor/Group variable

# Extract percentage of variance explained for PC1, PC2
pca_var <- summary(pca_result)$importance[2, ]  # Row 2 = Proportion of Variance
pc1_var <- round(pca_var[1] * 100, 1)          # PC1 in %
pc2_var <- round(pca_var[2] * 100, 1)          # PC2 in %

# Create the base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3) +
  labs(
    title = "PCA - Day 5 labeled by treatment group",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)")
  ) +
  theme_minimal() +
  theme(
    legend.title = element_text(size = 10),
    legend.text  = element_text(size = 8)
  )

# Add marginal "volcano"-style (density) plots along x and y axes
p_marginal <- ggMarginal(
  p,
  type = "density",        # 'density' for the "volcano" style
  groupColour = TRUE,      # Keep group color lines
  groupFill   = TRUE       # Keep group fill colors
)

# Print the final plot with marginal densities
print(p_marginal)

################################################################################
###PCA raw counts with library size
# 1. Log-transform the raw counts (adding 1 to avoid log(0))
log_counts <- log2(filtered_day5 + 1)

# 2. Perform PCA on the log-transformed data
#    Transpose the matrix so that samples are rows and genes are columns
pca_result <- prcomp(t(log_counts), scale. = TRUE)
pca_data <- as.data.frame(pca_result$x)



# 4. Add the library sizes to the PCA results data frame
pca_data$LibrarySize <- library_sizes_day5

# 5. Create the PCA plot with points colored by library size.
#    Here we use a heat map color gradient from blue (low) to yellow (mid) to red (high)
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) +
  geom_point(size = 3) +
  scale_color_gradientn(colors = c("blue", "yellow", "red"),
                        limits = c(min(library_sizes), max(library_sizes))) +
  labs(title = "PCA - Day 5 labeled by library size",
       x = paste0("PC1 (", pc1_var, "%)"),
       y = paste0("PC2 (", pc2_var, "%)"),
       color = "Library Size") +
  theme_minimal()

################################################################################
###PCA plot according to tumor purity
log_counts <- log2(filtered_day5 + 1)

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
  TumorPurity = tumor_purity_day5
)

# Load ggplot2 for plotting
library(ggplot2)

# Create the PCA plot with a blue-to-red gradient and updated axis labels including variance %
ggplot(pca_df, aes(x = PC1, y = PC2, color = TumorPurity)) +
  geom_point(size = 3) +
  labs(title = "PCA Plot - Day 5 labeled by tumor purity",
       x = paste0("PC1 (", pc1_var, "%)"),
       y = paste0("PC2 (", pc2_var, "%)"),
       color = "Tumor Purity") +
  scale_color_gradient(low = "blue", high = "red") +
  theme_minimal()
################################################################################
###PCA after CPM-TMM

# Perform PCA on the normalized data (transpose so that samples are rows)
pca_result <- prcomp(t(cpm_day5), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group_day5  # 'new_group' should be a vector/factor defining sample groups

# Calculate the proportion of variance explained for PC1 and PC2
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Create the base PCA scatter plot with updated axis labels
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3) +
  labs(
    title = "PCA - Day 5 labaled by treatment group",
    x = paste0("PC1 (", pc1_var, "%)"),
    y = paste0("PC2 (", pc2_var, "%)")
  ) +
  theme_minimal() +
  theme(
    legend.title = element_text(size = 10),
    legend.text  = element_text(size = 8)
  )

# Add volcano-style (density) marginal plots along the x and y axes
p_marginal <- ggMarginal(p, type = "density", groupColour = TRUE, groupFill = TRUE)

# Display the final plot
print(p_marginal)

################################################################################
#PCA raw count-CPM-TMM labaled by library size
# Perform PCA on the normalized data (transpose so that samples are rows)
pca_result <- prcomp(t(cpm_day5), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$LibrarySize <- library_sizes_day5
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) +
  geom_point(size = 3) +
  scale_color_gradientn(colors = c("blue", "yellow", "red"),
                        limits = c(min(library_sizes), max(library_sizes))) +
  labs(title = "PCA - Day 5 labaled by Library Size",
       x = paste0("PC1 (", pc1_var, "%)"),
       y = paste0("PC2 (", pc2_var, "%)"),
       color = "Library Size") +
  theme_minimal()
################################################################################
#PCA raw count-CPM-TMM labaled by tumor purity

# Perform PCA on the expression data (transpose because prcomp expects samples as rows)
pca_res <- prcomp(t(cpm_day5), scale. = TRUE)

# Calculate the proportion of variance explained for PC1 and PC2
pca_var <- summary(pca_res)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Create a data frame with the first two principal components and tumor purity values
pca_df <- data.frame(
  PC1 = pca_res$x[, 1],
  PC2 = pca_res$x[, 2],
  TumorPurity = tumor_purity_day5
)

# Load ggplot2 for plotting
library(ggplot2)

# Create the PCA plot with a blue-to-red gradient and updated axis labels including variance %
ggplot(pca_df, aes(x = PC1, y = PC2, color = TumorPurity)) +
  geom_point(size = 3) +
  labs(title = "PCA - Day 5 labaled by  Tumor Purity",
       x = paste0("PC1 (", pc1_var, "%)"),
       y = paste0("PC2 (", pc2_var, "%)"),
       color = "Tumor Purity") +
  scale_color_gradient(low = "blue", high = "red") +
  theme_minimal()
################################################################################