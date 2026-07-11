# Session 14 — Progress Report
**Date:** Saturday 11 July 2026 · 2 hours · NSBV BC2001 MATLAB Prep

## Topic
The Python bridge — rebuilding the same EEG analysis workflow from Session 13 in Python (NumPy, Matplotlib, SciPy), so the student can move between MATLAB and Python.

## Details of topics covered

**NumPy arrays vs MATLAB matrices.** Creating and indexing arrays, slicing, and vectorised maths. Emphasised the three main differences from MATLAB: 0-based indexing (`x[0]` is the first element), sample standard deviation needs `ddof=1` to match MATLAB, and `axis=0` vs `axis=1` for "across subjects" vs "within a subject".

**Loading data.** Read the same `.mat` files from Session 13 with `scipy.io.loadmat`, and flattened saved row-vectors with `.ravel()`.

**Descriptive statistics.** Mean, median, standard deviation, and SEM in NumPy — confirming the numbers match the MATLAB results exactly.

**Statistical tests.** t-tests in SciPy (`ttest_1samp`, `ttest_ind`, `ttest_rel`) and one-way ANOVA (`f_oneway`), plus the Tukey post-hoc (`pairwise_tukeyhsd` from statsmodels) as the Python version of `multcompare`. Verified the ANOVA gave the same F, df, and p as MATLAB (F(2,45) = 30.5, p < 0.001).

**Plotting with Matplotlib.** Histograms and bar-with-error-bar charts, grand-average ERP figures with SEM shading using `fill_between`, and erp-image colour maps using `imshow` with the `viridis` colormap (the Python equivalent of MATLAB's `parula`).

**Wrap-up.** A MATLAB → Python cheat sheet mapping each function used across the two languages, so the student has a quick reference going forward.
