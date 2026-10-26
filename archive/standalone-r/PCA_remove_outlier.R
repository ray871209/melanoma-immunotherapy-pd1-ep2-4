library(ggplot2)
library(ggExtra)
library(ggrepel)

update_group <- new_group[-6]
update_tumor_purity <- tumor_purity[-6]
update_library_size <- library_size[-6]
update_batch_info <- batch_info[-6
                                ]
update_cpm_data <- cpm_data_1[, ! names(cpm_data_1) %in% "AM6_7.1_S30"]
update_filtered <- filtered[, ! names(filtered) %in% "AM6_7.1_S30"]



################

pca_result <- prcomp(t(update_cpm_data), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- update_group  # Factor/Group variable
pca_data$Day = update_batch_info
pca_data$Sample <- colnames(update_cpm_data)


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
  xlim(-200, 200) + 
  ylim(-200, 200) +
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
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
pca_result <- prcomp(t(update_cpm_data), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- update_group  # Factor/Group variable
pca_data$Day = update_batch_info
pca_data$Sample <- colnames(update_cpm_data)


# Step 6: Extract variance explained
pca_var <- summary(pca_result)$importance[2, ]
pc3_var <- round(pca_var[3] * 100, 1)
pc4_var <- round(pca_var[4] * 100, 1)

# Step 7: Base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC3, y = PC4, color = Group, shape = Day)) +
  geom_point(size = 3) +
  geom_text_repel(aes(label = Sample),
                  size          = 3,
                  max.overlaps  = Inf,    # allow all labels
                  segment.size  = 0.2) +
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
################

pca_result <- prcomp(t(update_cpm_data), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- update_group  # Factor/Group variable
pca_data$Day = update_batch_info
pca_data$Sample <- colnames(update_cpm_data)


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
  xlim(-200, 200) + 
  ylim(-200, 200) +
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
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()
###############################################################################
pca_result <- prcomp(t(update_cpm_data), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- update_group  # Factor/Group variable
pca_data$Day = update_batch_info
pca_data$Sample <- colnames(update_cpm_data)


# Step 6: Extract variance explained
pca_var <- summary(pca_result)$importance[2, ]
pc3_var <- round(pca_var[3] * 100, 1)
pc4_var <- round(pca_var[4] * 100, 1)

# Step 7: Base PCA scatter plot
p <- ggplot(pca_data, aes(x = PC3, y = PC4, color = Group, shape = Day)) +
  geom_point(size = 3) +
  geom_text_repel(aes(label = Sample),
                  size          = 3,
                  max.overlaps  = Inf,    # allow all labels
                  segment.size  = 0.2) +
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
#test RUVg output for PCA
pca_result <- prcomp(t(ruv_output), scale. = TRUE)

# Convert PCA output to a data frame and add group information
pca_data <- as.data.frame(pca_result$x)
pca_data$Group <- update_group  # Factor/Group variable
pca_data$Day = update_batch_info
pca_data$Sample <- colnames(update_cpm_data)


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
  xlim(-200, 200) + 
  ylim(-200, 200) +
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
  xlim(-200, 200) + 
  ylim(-200, 200) +
  theme_minimal()