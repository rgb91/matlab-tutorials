# Session 11 — Epoching Recap, Descriptive Statistics & t-tests
**Date:** Wednesday 1 July 2026 · **Length:** 2 hours · NSBV BC2001 MATLAB Prep

First session after a one-week break, so the warmup is longer than usual.
Opens with the two-condition epoching recap, then introduces statistics:
descriptive stats and t-tests. ANOVA is deferred to Session 12.

## What's in this folder

- `Session11_LessonPlan_Instructor.docx` — full instructor notes (scripted lines, expected answers, timing). **Start here.**
- `Session11_LessonPlan_Student.docx` — lighter student-facing version (topics, key code, reference links).

### `warmup/`
- `warmup_revision.m` — 8 revision tasks (vectors, structs, cell arrays, multi-file loading, basic stats, epoching) — give to student
- `warmup_revision_SOLUTION.m` — answers (keep for yourself)

### `live_scripts/`
Three demo scripts to run in class (in order):
1. `demo1_epoching_recap.m` — epoch by condition → two ERPs (standard vs target)
2. `demo2_descriptive_stats.m` — mean, median, std, var, SEM, histograms, error bars
3. `demo3_ttest.m` — one-sample `ttest`, two-sample `ttest2`, reading p-values
- `extract_epochs.m` — helper (the function the student wrote for HW 10)

### `exercises/`
- `exercise1_descriptive_stats.m` — in-class: describe eyes-open vs eyes-closed alpha
- `exercise2_ttest.m` — in-class: two-sample t-test on the same data
- `homework_s11.m` — take-home: write `condition_stats` function + apply it
- `extract_epochs.m` — helper

### `solutions/`
- `exercise1_descriptive_stats_SOLUTION.m` / `exercise2_ttest_SOLUTION.m`
- `condition_stats.m` — homework Part A function solution
- `homework_s11_SOLUTION.m` — homework Part B solution

### `data/`
- `continuous_eeg.mat` — 12 s, 2-channel EEG, 30 events in 2 conditions (standard/target) — for the epoching recap
- `group_data.mat` — resting alpha power (µV²), control vs treatment (n=20 each) — descriptive stats + t-test demos
- `exercise_data.mat` — alpha peak amplitude (µV), eyes-open vs eyes-closed (n=18 each) — in-class exercises
- `homework_data.mat` — mean ERP amplitude (µV) for 24 subjects + condition labels — homework
- `_generate_data.py` — how the data was made (not needed in class)

## Setup before class
Open MATLAB, set the **Current Folder** to this folder so `data/...` paths resolve.
Run scripts section-by-section with **Ctrl+Enter**.
`ttest`, `ttest2`, and `boxplot` need the Statistics and Machine Learning Toolbox.

## Answer key (quick reference)
- Warmup: mean firing rate **16.4 Hz**; **4** neurons above mean; `ch_names{3}` = `'Pz'`; **30** events.
- `group_data`: control mean **5.25**, median 5.63, std 1.23, SEM 0.27; treatment mean **3.21**, std 1.05.
- `ttest2(control, treatment)`: **t(38) = 5.65, p ≈ 1.7e-6** → significant.
- One-sample `ttest(control)`: t(19) ≈ 19.1, p ≈ 7e-14.
- Exercise (`exercise_data`): eyes-open mean **3.86**, eyes-closed mean **6.43**; `ttest2` **t(34) = −6.66, p ≈ 1.2e-7**.
- Homework (`homework_data`): control n=12 mean **7.71**, patient n=12 mean **5.44**; `ttest2` **t(22) = 3.28, p ≈ 0.003**.
- Epoching recap (Pz peak, 50–250 ms): standard mean ≈ **6.6 µV**, target mean ≈ **10.4 µV**.
