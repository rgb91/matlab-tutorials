# Session 13 — Progress Report
**Date:** Saturday 5 July 2026 · 2 hours · NSBV BC2001 MATLAB Prep

## Topic
ANOVA (comparing three or more groups) and turning multi-subject data into publication-quality figures — with a short SEM / t-test bridge from Sessions 11–12.

## Details of what was covered

**SEM & t-test recap (bridge).** Revisited SEM = SD/√n and the mean ± 2×SEM ≈ 95% CI rule, and stressed SD (spread of subjects) vs SEM (uncertainty in the mean). Showed why running many pairwise t-tests inflates the false-positive rate (three groups → 3 tests → ~14% family-wise error), which motivates ANOVA. Ran `ttest2` on a fresh, moderate-effect dataset (control vs treatment N170 amplitude: t(30) = −2.27, **p = 0.031**, d = 0.80) so the student practised interpreting a real p-value rather than "p ≈ 0".

**One-way ANOVA.** Introduced the idea F = between-group variance ÷ within-group variance. Used `anova1` on resting alpha power across control / mild / severe groups, giving **F(2,45) = 30.5, p < 0.001**. Emphasised the data-shaping step students trip on: one long value column plus a matching group-label vector. Read off F, both degrees of freedom, and p from the ANOVA table.

**Post-hoc comparisons.** Used `multcompare` (Tukey HSD) to find which pairs differ — all three group pairs were significantly different (control > mild > severe). Reinforced that a significant ANOVA alone doesn't say which groups differ.

**Multi-subject averaging & figures.** Averaged ERPs across 20 subjects (`mean(X,1)` down the columns), computed SEM at each time point, and drew grand-average waveforms with shaded SEM error bands. Built an erp-image colour map (`imagesc` + `parula`, one shared colour scale, `colorbar`) to show single-subject variability, and a per-subject peak bar chart with SEM and paired dots. Covered `exportgraphics` for high-resolution publication figures, and why to avoid the `jet` colormap.

**In-class exercises (hands-on).** Exercise 1: one-way ANOVA on firing rate under three stimulus contrasts (F(2,42) = 39.0). Exercise 2: build a grand-average figure with SEM bands for eyes-open vs eyes-closed EEG.

**Handout:** Statistics Concepts explainer (t-tests, ANOVA, p-values, SD vs SEM vs CI, and a "which plot?" guide with diagrams).

## Homework given
`homework_s13.m` — a P300 dose study (placebo / low dose / high dose, independent subjects). Full pipeline:

1. Grand-average figure for all three conditions with SEM shading.
2. An erp-image colour map for the high-dose group.
3. Per-subject peak amplitude (250–450 ms) → `anova1` → `multcompare`.
4. A two-sentence write-up reporting the means ± SEM and the ANOVA result.

Expected result: peaks placebo 3.2 / low 4.9 / high 6.7 µV; F(2,39) = 40.4, p < 0.001; all pairs differ. Solution in `solutions/homework_s13_SOLUTION.m`.

## Plans for next session (Session 14 — 11 July)
Python bridge: rebuild the exact same EEG workflow in NumPy / Matplotlib / SciPy.
- NumPy arrays vs MATLAB matrices — 0-based indexing, `ddof=1` for sample SD, `axis=0` vs `axis=1`.
- Load the same `.mat` files with `scipy.io.loadmat`; descriptive stats.
- t-tests (`ttest_ind`, `ttest_1samp`, `ttest_rel`) and one-way ANOVA (`f_oneway`) + Tukey post-hoc (statsmodels).
- Grand-average figures with `fill_between` SEM bands and `imshow` colour maps.
- Take-home: `exercise_python.ipynb` (reproduce today's ANOVA and figures in Python).
