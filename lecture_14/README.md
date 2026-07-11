# Session 14 — The Same EEG Workflow, in Python
**Date:** Saturday 11 July 2026 · **Length:** 2 hours · NSBV BC2001 MATLAB Prep

The Python bridge. Everything from Session 13 — describe data, t-tests, ANOVA,
multi-subject averaging, publication figures, colour maps — rebuilt in
**NumPy + Matplotlib + SciPy**, on the *same* `.mat` datasets. Same neuroscience,
new tools. No warmup.

## Start here
- `Session14_LessonPlan_Instructor.docx` — run sheet, the three MATLAB→Python gotchas, answer keys. **Start here.**
- `Session14_LessonPlan_Student.docx` — setup, the four packages, key code, exercises, links.

## `notebooks/`
- `session14_python_intro.ipynb` — the taught notebook (run top to bottom). Covers NumPy arrays vs MATLAB matrices, loading `.mat` files, descriptive stats, t-tests, one-way ANOVA + Tukey, grand-average figures with SEM bands, and the erp-image colour map. Ends with a MATLAB→Python cheat sheet. **Already executed with outputs saved.**
- `exercise_python.ipynb` — three take-home tasks (ANOVA, grand-average figure, reproduce the S13 dose homework in Python).

## `solutions/` (instructor only)
- `exercise_python_SOLUTION.ipynb` — worked answers, executed with outputs.

## `data/`
Same files as Session 13 (copied here so the notebooks are self-contained):
`anova_data.mat`, `multisubject_erp.mat`, `exercise_anova.mat`, `exercise_figure.mat`, `homework_s13.mat`.

## Setup before class
```
pip install numpy scipy matplotlib statsmodels
```
Launch Jupyter with the working directory at `notebooks/` so `../data/...` paths resolve.
`statsmodels` is only needed for the Tukey post-hoc (the Python `multcompare`).

## The three MATLAB → Python gotchas
1. **0-based indexing** — `x[0]` is the first element (MATLAB: `x(1)`).
2. **Sample std** — use `x.std(ddof=1)` to match MATLAB's `std`.
3. **Dimensions** — `X.mean(axis=0)` = `mean(X,1)` (down columns / across subjects).

## Answer key (identical to Session 13 — that's the point)
- `anova_data`: **F(2,45) = 30.51, p ≈ 4.2e-9**; all three pairs differ.
- Exercise 1 (`exercise_anova`): **F(2,42) = 38.99, p ≈ 2.7e-10**.
- Exercise 2 (`exercise_figure`): grand-average peak open ≈ **2.7 µV**, closed ≈ **4.8 µV**.
- Exercise 3 (`homework_s13`): peaks placebo 3.17, low 4.89, high 6.72 µV; **F(2,39) = 40.36, p ≈ 3.2e-10**.
