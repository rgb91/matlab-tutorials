# Session 13 — ANOVA, Multi-subject Averaging & Publication Figures
**Date:** Saturday 5 July 2026 · **Length:** 2 hours · NSBV BC2001 MATLAB Prep

Bridges from the descriptive-stats / t-test work in Sessions 11–12 into
comparing **three or more** groups (ANOVA), then into turning **many subjects**
into a single **publication-quality figure** (grand averages, SEM error bars,
colour maps). No warmup this session — we open straight on the SEM/t-test bridge.
Session 14 rebuilds the whole workflow in Python.

## Start here
- `Session13_LessonPlan_Instructor.docx` — full instructor notes: run sheet, scripted lines, answer keys, stumbling blocks. **Start here.**
- `Session13_LessonPlan_Student.docx` — lighter student-facing guide (topics, key code, exercises, links).
- `Statistics_Concepts_Explainer.docx` — plain-language companion: t-tests, ANOVA, p-values, SD vs SEM vs CI, and a "which plot?" guide, all with diagrams. Hand out with the session.
- `figures/` — the diagrams used in the explainer, as standalone PNGs (handy for slides or the whiteboard).

## `live_scripts/` — run in class, in order
1. `demo1_sem_ttest_recap.m` — SEM recap + why many t-tests inflate false positives (the motivation for ANOVA).
2. `demo2_anova.m` — one-way `anova1`, the group-label vector, reading F/df/p, `multcompare` post-hoc.
3. `demo3_multisubject_figures.m` — grand average across subjects, SEM shaded bands, erp-image colour map, per-subject peaks, high-res export.

## `exercises/` — hands-on (no warmup)
- `exercise1_anova.m` — one-way ANOVA on firing rate under three stimulus contrasts.
- `exercise2_pubfigure.m` — grand-average figure with SEM shading (eyes open vs closed).
- `homework_s13.m` — take-home: full pipeline on a P300 dose study (figure + colour map + ANOVA + write-up).

## `solutions/` (instructor only)
- `exercise1_anova_SOLUTION.m`, `exercise2_pubfigure_SOLUTION.m`, `homework_s13_SOLUTION.m`

## `data/`
- `anova_data.mat` — resting alpha power (µV²), control / mild / severe, n=16 each — ANOVA demo.
- `multisubject_erp.mat` — Pz P300 for 20 subjects × time, standard vs target — multi-subject figures demo.
- `exercise_anova.mat` — firing rate (Hz), low / medium / high contrast, n=15 each — Exercise 1.
- `exercise_figure.mat` — 16-subject ERP, eyes open vs closed — Exercise 2.
- `homework_s13.mat` — 3-condition P300 dose study (independent subjects) — homework.
- `_generate_data.py` — how the data was made (reproducible, seed 13; not needed in class).

## Setup before class
Open MATLAB, set the **Current Folder** to this folder so `data/...` paths resolve.
Run scripts section-by-section with **Ctrl+Enter**.
`anova1`, `multcompare`, `ttest`, `ttest2`, `boxplot` need the **Statistics and Machine Learning Toolbox**.

## Answer key (quick reference)
- `anova_data`: means control **6.31**, mild 5.11, severe **2.96** µV²; ANOVA **F(2,45) = 30.5, p ≈ 4e-9**; Tukey — all three pairs differ (control–mild p≈0.02, others p<0.001).
- `multisubject_erp`: grand-average peak standard **3.3 µV**, target **6.8 µV**; paired **t(19) = 11.0, p ≈ 1e-9**.
- Exercise 1 (`exercise_anova`): low **12.1**, medium 18.1, high **22.4** Hz; **F(2,42) = 39.0, p ≈ 3e-10**; all pairs differ.
- Exercise 2 (`exercise_figure`): grand-average peak eyes-open **2.8 µV**, eyes-closed **4.8 µV**.
- Homework (`homework_s13`): peaks placebo **3.2**, low 4.9, high **6.7 µV**; **F(2,39) = 40.4, p ≈ 3e-10**; all pairs differ.
