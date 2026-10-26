# Install packages if needed
# install.packages("ggplot2")
# install.packages("ggExtra")

library(ggplot2)
library(ggExtra)
###PCA before normalization
# Example: log-transform the data
log_counts <- log2(filtered + 1)

# Perform PCA (transposing so samples are rows, genes are columns)
pca_result <- prcomp(t(log_counts), scale. = TRUE)

# Convert PCA result to a data frame
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group  # Factor/Group variable

# Extract percentage of variance explained for PC1, PC2
pca_var <- summary(pca_result)$importance[2, ]  # Row 2 = Proportion of Variance
pc1_var <- round(pca_var[1] * 100, 1)          # PC1 in %
pc2_var <- round(pca_var[2] * 100, 1)          # PC2 in %

# Create the base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3) +
  labs(
    title = "PCA - labeled by treatment group",
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
log_counts <- log2(filtered + 1)

# 2. Perform PCA on the log-transformed data
#    Transpose the matrix so that samples are rows and genes are columns
pca_result <- prcomp(t(log_counts), scale. = TRUE)
pca_data <- as.data.frame(pca_result$x)

# 3. Define your library sizes vector (order must match the columns in 'filtered')
library_sizes <- c(13989149, 11760674, 12106992, 12184270, 13019063, 9170579, 11008657, 11881205, 9901862, 13861220, 13234260, 11603270, 10125652, 12437632, 12549127, 12417646, 14286770, 9889486, 11533330, 14883711, 14024357, 11334289, 14932934, 8890425, 12077168, 11853914, 10784770, 12834582, 12198896, 15050986, 14616755, 12362818, 15538880, 8377662, 12935369, 10003707, 11169087, 10686453, 12316344)

# 4. Add the library sizes to the PCA results data frame
pca_data$LibrarySize <- library_sizes

# 5. Create the PCA plot with points colored by library size.
#    Here we use a heat map color gradient from blue (low) to yellow (mid) to red (high)
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) +
  geom_point(size = 3) +
  scale_color_gradientn(colors = c("blue", "yellow", "red"),
                        limits = c(min(library_sizes), max(library_sizes))) +
  labs(title = "PCA - labeled by library size",
       x = paste0("PC1 (", pc1_var, "%)"),
       y = paste0("PC2 (", pc2_var, "%)"),
       color = "Library Size") +
  theme_minimal()


################################################################################
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

# Load ggplot2 for plotting
library(ggplot2)

# Create the PCA plot with a blue-to-red gradient and updated axis labels including variance %
ggplot(pca_df, aes(x = PC1, y = PC2, color = TumorPurity)) +
  geom_point(size = 3) +
  labs(title = "PCA Plot - labeled by tumor purity",
       x = paste0("PC1 (", pc1_var, "%)"),
       y = paste0("PC2 (", pc2_var, "%)"),
       color = "Tumor Purity") +
  scale_color_gradient(low = "blue", high = "red") +
  theme_minimal()
################################################################################
###PCA plot raw count according to batch group
log_counts <- log2(filtered + 1)

# Perform PCA (transposing so samples are rows, genes are columns)
pca_result <- prcomp(t(log_counts), scale. = TRUE)

# Convert PCA result to a data frame
pca_data <- as.data.frame(pca_result$x)
pca_data$Batch  <- batch_info  # Factor/Group variable

# Extract percentage of variance explained for PC1, PC2
pca_var <- summary(pca_result)$importance[2, ]  # Row 2 = Proportion of Variance
pc1_var <- round(pca_var[1] * 100, 1)          # PC1 in %
pc2_var <- round(pca_var[2] * 100, 1)          # PC2 in %

# Create the base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Batch)) +
  geom_point(size = 3) +
  labs(
    title = "PCA - labeled by batch group",
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

###PCA Plot using original paper normalization method

# Perform PCA on the transposed normalized data
pca_result <- prcomp(t(original), scale. = TRUE)

# Create a data frame from the PCA results with the group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group

# Calculate the proportion of variance explained for each PC
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Generate the PCA scatter plot with ggplot2,
# adding the explained variance to the axis labels
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3) +
  labs(title = "PCA Plot using original paper normalization method",
       x = paste0("PC1 (", pc1_var, "%)"),
       y = paste0("PC2 (", pc2_var, "%)")) +
  theme_minimal() +
  theme(legend.title = element_text(size = 10),
        legend.text = element_text(size = 8))

# Add volcano-style (density) marginal plots along the x and y axes
p_marginal <- ggMarginal(p, type = "density", groupColour = TRUE, groupFill = TRUE)

# Display the final plot
print(p_marginal)

################################################################################

###PCA after CPM-TMM

# Perform PCA on the normalized data (transpose so that samples are rows)
pca_result <- prcomp(t(cpm_data), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group  # 'new_group' should be a vector/factor defining sample groups

# Calculate the proportion of variance explained for PC1 and PC2
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Create the base PCA scatter plot with updated axis labels
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3) +
  labs(
    title = "PCA - labaled by treatment group",
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
pca_result <- prcomp(t(cpm_data), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$LibrarySize <- library_sizes
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) +
  geom_point(size = 3) +
  scale_color_gradientn(colors = c("blue", "yellow", "red"),
                        limits = c(min(library_sizes), max(library_sizes))) +
  labs(title = "PCA - labaled by Library Size",
       x = paste0("PC1 (", pc1_var, "%)"),
       y = paste0("PC2 (", pc2_var, "%)"),
       color = "Library Size") +
  theme_minimal()
################################################################################
#PCA raw count-CPM-TMM labaled by tumor purity

# Perform PCA on the expression data (transpose because prcomp expects samples as rows)
pca_res <- prcomp(t(cpm_data), scale. = TRUE)

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

# Load ggplot2 for plotting
library(ggplot2)

# Create the PCA plot with a blue-to-red gradient and updated axis labels including variance %
ggplot(pca_df, aes(x = PC1, y = PC2, color = TumorPurity)) +
  geom_point(size = 3) +
  labs(title = "PCA - labaled by  Tumor Purity",
       x = paste0("PC1 (", pc1_var, "%)"),
       y = paste0("PC2 (", pc2_var, "%)"),
       color = "Tumor Purity") +
  scale_color_gradient(low = "blue", high = "red") +
  theme_minimal()
################################################################################
###PCA after CPM-TMM according to batch group
# Perform PCA on the normalized data (transpose so that samples are rows)
pca_result <- prcomp(t(cpm_data), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Batch <- batch_info  # 'new_group' should be a vector/factor defining sample groups

# Calculate the proportion of variance explained for PC1 and PC2
pca_var <- summary(pca_result)$importance[2, ]
pc1_var <- round(pca_var[1] * 100, 1)
pc2_var <- round(pca_var[2] * 100, 1)

# Create the base PCA scatter plot with updated axis labels
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Batch)) +
  geom_point(size = 3) +
  labs(
    title = "PCA - labeled by batch group",
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

###PCA plot after ComBat-Seq+CPM-TMM
pca_result <- prcomp(t(cpm_tmm_log2), scale. = TRUE)

# Convert PCA result to a data frame
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- new_group  # Factor/Group variable

# Extract percentage of variance explained for PC1, PC2
pca_var <- summary(pca_result)$importance[2, ]  # Row 2 = Proportion of Variance
pc1_var <- round(pca_var[1] * 100, 1)          # PC1 in %
pc2_var <- round(pca_var[2] * 100, 1)          # PC2 in %

# Create the base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3) +
  labs(
    title = "PCA - labeled by treatment group",
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
#PCA raw count-CPM-TMM + ComBat-Seq labaled by library size
# Perform PCA on the normalized data (transpose so that samples are rows)
pca_result <- prcomp(t(cpm_tmm_log2), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$LibrarySize <- library_sizes
ggplot(pca_data, aes(x = PC1, y = PC2, color = LibrarySize)) +
  geom_point(size = 3) +
  scale_color_gradientn(colors = c("blue", "yellow", "red"),
                        limits = c(min(library_sizes), max(library_sizes))) +
  labs(title = "PCA - labaled by Library Size",
       x = paste0("PC1 (", pc1_var, "%)"),
       y = paste0("PC2 (", pc2_var, "%)"),
       color = "Library Size") +
  theme_minimal()
################################################################################
#PCA raw count-CPM-TMM + ComBat-Seq labaled by tumor purity

# Perform PCA on the expression data (transpose because prcomp expects samples as rows)
pca_res <- prcomp(t(cpm_tmm_log2), scale. = TRUE)

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

# Load ggplot2 for plotting
library(ggplot2)

# Create the PCA plot with a blue-to-red gradient and updated axis labels including variance %
ggplot(pca_df, aes(x = PC1, y = PC2, color = TumorPurity)) +
  geom_point(size = 3) +
  labs(title = "PCA - labaled by  Tumor Purity",
       x = paste0("PC1 (", pc1_var, "%)"),
       y = paste0("PC2 (", pc2_var, "%)"),
       color = "Tumor Purity") +
  scale_color_gradient(low = "blue", high = "red") +
  theme_minimal()
################################################################################

###PCA plot after ComBat-Seq+CPM-TMM accrding to batch group
pca_result <- prcomp(t(cpm_tmm_log2), scale. = TRUE)

# Convert PCA result to a data frame
pca_data <- as.data.frame(pca_result$x)
pca_data$Batch <- batch_info  # Factor/Group variable

# Extract percentage of variance explained for PC1, PC2
pca_var <- summary(pca_result)$importance[2, ]  # Row 2 = Proportion of Variance
pc1_var <- round(pca_var[1] * 100, 1)          # PC1 in %
pc2_var <- round(pca_var[2] * 100, 1)          # PC2 in %

# Create the base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Batch)) +
  geom_point(size = 3) +
  labs(
    title = "PCA - labeled by batch group",
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
