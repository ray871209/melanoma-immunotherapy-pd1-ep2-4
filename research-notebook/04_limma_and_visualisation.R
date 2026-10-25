# limma models, visualisations and downstream comparisons
# Historical master's research code, reorganised from original annotated script.
# Original source lines 773-987. Statements and exploratory work preserved.
# NOTE: These sections reflect an interactive RStudio analysis session;
# they may depend on objects created in other sections or prior sessions.
# They are NOT presented as independently executable clean-session scripts.

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


