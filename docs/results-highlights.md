# Research results at a glance

These are **historical results as documented in the 2025 thesis, appendix and supervisor meeting slides**, not newly computed output.

## Quality control

- 39 original samples across four treatment groups and two collection days.
- After reviewing the PCA outlier, sample `AM6_7.1_S30` was excluded, leaving 38 samples for downstream analysis.
- The final low-expression threshold retained 14,917 genes.

## Immune-related analysis

- Immune deconvolution approaches were compared during the project.
- BASE provides cell-type enrichment **scores**; these should not be described as absolute cell fractions.
- BASE, together with ESTIMATE-derived tumour purity, was used for the main covariate-adjustment comparisons.

## Differential expression and pathway analysis

The thesis examined six treatment contrasts under models with different covariate configurations. The meeting slides document, among other results, the **combination vs vehicle** comparison using BASE + tumour purity adjustment, with adjusted KEGG enrichment evidence for:

- Hematopoietic cell lineage
- Cytokine-cytokine receptor interaction
- Efferocytosis
- Fluid shear stress and atherosclerosis
- Osteoclast differentiation
- Pertussis
- Systemic lupus erythematosus

The enrichment list is reproduced here only as a summary of the research narrative. For the transcribed historical KEGG p-values, Benjamini corrections and DAVID FDR fields, see [original KEGG enrichment notes](pathway-enrichment-kegg.md). For all model definitions and gene memberships, consult the thesis and source exports. It is not an independent validation.

## Interpretation

Comparing unadjusted and adjusted models helped illustrate the impact of tumour purity and estimated immune composition on apparent expression differences. These analyses are exploratory and observational; the outputs do not establish a causal mechanism or clinical efficacy.

## Figures

The [66 original researcher-uploaded PNGs](original-figures-gallery.md) are archived, without image editing, alongside separately identified redrawn portfolio SVG diagrams. Individual original plots retain sequential archive IDs until the scientific panel identity has been verified. Before public release, image content and reuse rights still need review.
