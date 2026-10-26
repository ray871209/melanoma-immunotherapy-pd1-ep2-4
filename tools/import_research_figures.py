#!/usr/bin/env python3
"""Import the 43 original figure PNGs from the curated ZIP into this local Git repo.

Run from the cloned repository root:
  python3 tools/import_research_figures.py /path/to/melanoma_research_figures_complete.zip
  git add results/figures
  git commit -m "figures: add original master's research plots"
  git push

This script DOES NOT authenticate to GitHub, commit, or push. It does not modify
image pixel data. It rejects unexpected paths and missing canonical figures.
"""
from pathlib import Path
import sys
import zipfile

EXPECTED_MAIN = {
    "base_heatmap.png",
    "kegg_pathway_effects_original.png",
    "pca_comparison_slide.png",
    "pvalue_combo_vehicle.png",
    "rle_comparison_slide.png",
    "rle_cpm.png",
    "rle_cpm_tmm.png",
    "rle_raw.png",
    "tumour_purity.png",
    "volcano_combo_vehicle_adjusted.png",
    "volcano_combo_vehicle_unadjusted.png",
    "volcano_controls_adjusted.png",
    "volcano_controls_unadjusted.png",
}

EXPECTED_SUPPLEMENTARY = {
    f"{prefix}_{contrast}.png"
    for prefix in ("adjusted", "unadjusted", "controls_adjusted", "controls_unadjusted")
    for contrast in (
        "anti_pd1_epat", "anti_pd1_vehicle", "combo_anti_pd1",
        "combo_epat", "combo_vehicle", "epat_vehicle",
    )
} | {
    f"pvalue_{contrast}_adjusted_vs_unadjusted.png"
    for contrast in (
        "anti_pd1_epat", "anti_pd1_vehicle", "combo_anti_pd1",
        "combo_epat", "combo_vehicle", "epat_vehicle",
    )
}

def main():
    if len(sys.argv) != 2:
        raise SystemExit("Usage: python3 tools/import_research_figures.py <complete_figures.zip>")
    root = Path(__file__).resolve().parents[1]
    if not (root / ".git").exists():
        raise SystemExit("Run this from a cloned Git repository (missing .git directory).")

    archive = Path(sys.argv[1]).expanduser().resolve()
    dest = root / "results" / "figures"

    with zipfile.ZipFile(archive) as z:
        entries = {n for n in z.namelist() if n.endswith(".png")}
        needed = {f"main/{n}" for n in EXPECTED_MAIN} | {
            f"supplementary/{n}" for n in EXPECTED_SUPPLEMENTARY
        }
        missing = needed - entries
        unexpected = entries - needed
        if missing or unexpected:
            raise SystemExit(f"Unexpected archive structure: missing={sorted(missing)}, extra={sorted(unexpected)}")
        if len(needed) != 43:
            raise SystemExit("Internal figure manifest has an unexpected size.")
        for entry in sorted(needed):
            source_bytes = z.read(entry)
            if not source_bytes.startswith(b"\x89PNG\r\n\x1a\n"):
                raise SystemExit(f"Not a PNG image: {entry}")
            outfile = dest / entry
            outfile.parent.mkdir(parents=True, exist_ok=True)
            outfile.write_bytes(source_bytes)
    print("Imported 43 original PNG images into results/figures/{main,supplementary}.")
    print("Review figures, then run: git add results/figures && git commit && git push")

if __name__ == "__main__":
    main()
