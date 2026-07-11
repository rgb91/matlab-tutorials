# Session 10 — Pipeline, Data Structures & Epoching
**Date:** Friday 27 June 2026 · **Length:** 2 hours · NSBV BC2001 MATLAB Prep

## What's in this folder

- `Session10_LessonPlan_Instructor.docx` — full instructor notes (scripted lines, expected answers, timing). **Start here.**
- `Session10_LessonPlan_Student.docx` — lighter student-facing version (topics, key code, reference links).

### `warmup/`
- `warmup_fileio_revision.m` — 5 quick File I/O revision tasks (give to student)
- `warmup_fileio_revision_SOLUTION.m` — answers (keep for yourself)
- `get_spectrum.m` — helper function

### `live_scripts/`
Four demo scripts to run in class (in order):
1. `demo1_pipeline.m` — full load → notch → bandpass → spectrum (carry-over from S9)
2. `demo2_structs_cellarrays.m` — structs and cell arrays basics
3. `demo3_organize_dataset.m` — loading multi-subject files into a struct array
4. `demo4_epoching.m` — epoch extraction, baseline correction, averaging, ERP
- `get_spectrum.m` / `clean_eeg.m` — helper functions

### `exercises/`
- `exercise1_organize_subjects.m` — in-class exercise: build struct array
- `exercise2_epoch_and_average.m` — in-class exercise: epoching
- `homework_s10.m` — take-home: write extract_epochs function
- `get_spectrum.m` / `clean_eeg.m` — helpers

### `solutions/`
- `exercise1_SOLUTION.m` / `exercise2_SOLUTION.m` — in-class solutions
- `extract_epochs.m` — homework function solution
- `homework_s10_SOLUTION.m` — homework Part B solution

### `data/`
- `pipeline_eeg.mat / .csv` — 8-channel recording for pipeline demo (6, 10, 20 Hz + 60 Hz noise)
- `subject_S01.mat / S02 / S03` — multi-subject data (alpha 10 Hz + beta 22 Hz, varying amplitudes)
- `continuous_eeg.mat` — 10 s continuous EEG with 20 event markers (for epoching)
- `homework_S01.mat / S02 / S03` — homework files with ground-truth epochs
- `_generate_data.py` — how data was made (not needed in class)

## Setup before class
Open MATLAB, set the **Current Folder** to this unzipped folder so `data/...` paths resolve. Run scripts section-by-section with **Ctrl+Enter**.

## Answer key (quick reference)
- Pipeline dominant frequency: **10 Hz** (alpha)
- Subject S01: age 22, control, alpha=5.0, beta=2.5
- Subject S02: age 25, treatment, alpha=3.0, beta=4.0
- Subject S03: age 21, control, alpha=6.0, beta=1.5
- ERP peak: ~100 ms post-stimulus (8 Hz damped sinusoid template)
- Epoch window: −100 ms to +300 ms (103 samples at 256 Hz)
