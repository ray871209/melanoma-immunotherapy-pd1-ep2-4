library(EDASeq)
library(Biobase)  # for AnnotatedDataFrame

# Convert log2CPM data to matrix
mat <- as.matrix(original)

# Create phenotype data using treatment groups
pd <- data.frame(Treatment = new_group,
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
plotRLE(ses,
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

################################################################################
#day2 and day5 RLE plot
mat <- as.matrix(cpm_day2_expr)
mat <- apply(mat, 2, function(x) as.numeric(as.character(x)))

# Create phenotype data using treatment groups
pd <- data.frame(Treatment = new_group_day2,
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
plotRLE(ses,
        outline = FALSE,
        col     = box_colors,
        main    = "RLE Plot - Day 2 labaled by Treatment group",
        xlab    = "Sample",
        ylab    = "Relative Log Expression",
        ylim    = c(-0.35, 0.35))

# Add legend
legend("topright",
       legend = names(my_palette),
       fill   = my_palette,
       title  = "Treatment Group",
       cex    = 0.8)
################################################################################
#day2 and day5 RLE plot
mat <- as.matrix(cpm_day5_expr)
mat <- apply(mat, 2, function(x) as.numeric(as.character(x)))

# Create phenotype data using treatment groups
pd <- data.frame(Treatment = new_group_day5,
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
plotRLE(ses,
        outline = FALSE,
        col     = box_colors,
        main    = "RLE Plot - Day 5 labaled by Treatment group",
        xlab    = "Sample",
        ylab    = "Relative Log Expression",
        ylim    = c(-0.35, 0.35))

# Add legend
legend("topright",
       legend = names(my_palette),
       fill   = my_palette,
       title  = "Treatment Group",
       cex    = 0.8)
################################################################################
# Convert log2CPM data to matrix
mat <- as.matrix(cpm_data)

# Create phenotype data using treatment groups
pd <- data.frame(Treatment = new_group,
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
################################################################################
# Convert log2CPM data to matrix
mat <- as.matrix(log(filtered+1))

# Create phenotype data using treatment groups
pd <- data.frame(Treatment = new_group,
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
plotRLE(ses,
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

################################################################################
## CPM only
mat <- as.matrix(cpm_only)

# Create phenotype data using treatment groups
pd <- data.frame(Treatment = new_group,
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
plotRLE(ses,
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
################################################################################
# Calculate the median expression for each gene e)
gene_medians <- apply(original, 1, median)

# Compute the RLE values: for each gene, subtract the gene median from each sample's value
rle_values_ori <- sweep(original, 1, gene_medians, FUN = "-")

# Convert the RLE matrix into a data frame and add a column for gene names
rle_data_ori <- as.data.frame(rle_values_ori)
rle_data_ori$Gene <- rownames(rle_values_ori)

# Melt the data frame to long format
rle_long_ori <- melt(rle_data_ori, id.vars = "Gene", variable.name = "Sample", value.name = "RLE")

# Attach new_group 
rle_long_ori$Group <- rep(new_group, each = nrow(original))

ggplot(rle_long_ori, aes(x = Sample, y = RLE, fill = Group)) +
  geom_boxplot(outlier.size = 0.01) +
  labs(title = "RLE Plot using original paper normalization method",
       x = "Sample", 
       y = "Relative Log Expression") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        legend.title = element_text(size = 10)) +
  coord_cartesian(ylim = c(-0.6, 0.6))



