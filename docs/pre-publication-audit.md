# Pre-publication safety and provenance check

**Review date:** 2026-10-26. **Repository status:** Private. This is a limited audit and does **not** certify the repository or its Git history as free of confidential information.

## Completed: current text/code file scan

The currently tracked text/code materials in the repository were screened for common signatures of:
- email addresses;
- simple hard-coded credential assignments (`password`, `secret`, `token`, `api_key`);
- `/Users/<name>/` absolute home paths;
- PEM/OpenSSH private-key headers; and
- common written references to student IDs, dates of birth and passport numbers.

**Result:** No matches were detected among the 32 readable text/code files examined. This is a pattern-based check, not a thorough content review. Credentials can be structured differently, and personally identifying or sensitive information may occur in nonstandard formats.

## Still unverified

1. **66 embedded PNG images:** Not visually screened for student identifiers, names, personal contacts, screen captures, or third-party copyrighted material. The current neutral filenames do not tell us what individual pixels contain.
2. **Full Git history:** Recent commit metadata was accessible, but the contents of historical versions were **not** comprehensively checked. Removing a problematic file in a new commit does not erase earlier commits.
3. **External housekeeping gene set:** The supplied MSigDB/GSEA-derived `HOUNKPE_HOUSEKEEPING_GENES.v2024.1.Mm.tsv` was deliberately not added; check applicable attribution, licensing and redistribution terms before uploading its full contents.
4. **DAVID workbooks:** `DAVIDChartReport_List_2_2025-09-28.xlsx` and `Pathway enrichment.xlsx` were supplied but are not in GitHub. The spreadsheet-cell reading operation was unsuccessful in this environment. No spreadsheet metrics have been reported or re-created.
5. **Scientific provenance:** The thesis data are publicly linked from GEO GSE160788; verify that all exported figure images are the author's research figures and that the original experiment, annotation sources and software are appropriately acknowledged.
6. **R code execution:** The historical notebook and standalone scripts were not executed or fully parsed in a recreated environment. Exploratory blocks, missing objects and potential errors are documented in [the archive audit](research-archive-audit.md).

## Recommended publication decision

**Not yet cleared for Public.** Keep the repository private until the 66 images and entire Git history have been visually/content reviewed and the source attributions are complete.

## Safe disclosure language

This repository preserves a 2025 master's historical bulk-RNA-seq research analysis, with original annotated code, separate exploratory scripts, source research figures and a recorded R package session. It is not an independently verified one-command reproduction of all reported figures.

## GitHub-specific final checks

- View every original PNG before publishing; remove or appropriately handle any personal/confidential details or restricted imagery.
- Inspect historical commits and old file versions, particularly initial uploads and any deleted files. If a secret was committed, revoke/rotate it before rewriting history.
- Inspect GitHub's **Security** features and secret scanning availability for the repository, then perform any necessary local historical scanning.
- Verify README relative image links and linked references when viewed without authenticated access.
- Choose a license deliberately; **do not assume that adding a software license also licenses source-study data or third-party reference sets**.
- Only change Repository visibility after the checks above.

**Update (2026-10-26):** Author-supplied *text representations* of the pathway enrichment and KEGG exports are now preserved at [pathway enrichment / KEGG notes](pathway-enrichment-kegg.md), with raw pasted content under `archive/pathway-enrichment/`. These are not copies of the binary Excel workbooks, and Excel worksheet-level identity and formatting remain unverified.
