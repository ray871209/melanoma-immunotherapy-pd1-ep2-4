# Selection of BASE for the final analysis

The supervisor meeting slides record exploratory trials using quanTIseq, xCell, EPIC, mMCP-counter and BASE. Later meeting slides show four main differential expression adjustments:

1. treatment + BASE scores + tumour purity
2. treatment + tumour purity
3. treatment + BASE scores
4. treatment only

Those later slides also show BASE-focused figures and KEGG enrichment results. The researcher confirms that the final decision was to use BASE rather than quanTIseq for the principal adjustment models.

The thesis Methodology section also describes quanTIseq models among six candidate specifications. We preserve that historical discrepancy: quanTIseq was investigated, but should not be presented as a selected final modelling covariate.

Other explorations include ComBat-Seq, RUVg, RUVs and RUV-III/PRPS. These are not automatically final steps.

The meeting notes identify AM6_7.1_S30 as the QC outlier excluded from downstream analysis, leaving 38 samples from 39.

The user-confirmed gene filtering criterion is CPM >= 0.5 in at least 3 samples. No analysis was re-executed to write this note.
