# MATLAB Learning Plan — NSBV BC2001 Neuroscience Lab

**Course:** NSBV BC2001 Laboratory in Neuroscience, Barnard College, Spring 2026
**Purpose:** Summer preparation to build confident working knowledge of MATLAB before the fall module
**Structure:** 10 lectures × 2 hours (teaching + hands-on) + take-home exercises each session

---

## What MATLAB Is Actually Used For in This Course

Three distinct modules require MATLAB:

| Course Module | When | What you do in MATLAB |
|---|---|---|
| Lab Skills 1 — statistics workshop | Week 4 (2/9–2/13) | Variables, vectors, basic stats, experimental design |
| EEG — single-subject & group analysis | Weeks 11–13 (3/30–4/17) | Epoching, ERP averaging, group-level comparisons |
| Electrophysiology — earthworm recordings | Weeks 14–15 (4/20–5/1) | Action potential analysis, conduction velocity, figures for lab report |
| Lab Final Exam (MATLAB component, open-notebook) | Week 16 (5/8–5/14) | Any of the above |

---

## Key Deadlines

| Milestone | Date |
|---|---|
| MATLAB first assessed — Week 4 workshop + exit ticket | 2/9–2/13 |
| EEG1: intro and test run | 3/30–4/3 |
| EEG2: experiment + single-subject HW | 4/6–4/10 |
| EEG3: single-subject + group-level analysis | 4/13–4/17 |
| Electrophysiology 1 — earthworm recordings | 4/20–4/24 |
| Lab Report Draft due | 4/24 |
| Electrophysiology 2 — earthworm recordings | 4/27–5/1 |
| Lab Report Final Draft due | 5/5 |
| Lab Final Exam (MATLAB open-notebook) | 5/8–5/14 |

---

## Before You Start (Do This Before Lecture 1)

1. **Install MATLAB** — Barnard/Columbia has a student license. Check at [software.columbia.edu](https://software.columbia.edu) or ask IT.
2. **Create your MATLAB folder** — `~/Documents/MATLAB/` or on MATLAB Drive (Google Drive works too).
3. **Start your digital notebook** — a Google Doc or Notion page. You must bring it to every lab. It is open-book during the MATLAB portion of the final exam. Start it now.
4. **Complete MATLAB Onramp** — free, ~2 hours, on [MathWorks Academy](https://matlabacademy.mathworks.com/). Do this before Lecture 1. It covers the basics so lecture time can go deeper.

---

## Notebook Template

Use this header for every session entry:

```
Date:
Lecture topic:
New functions learned:
Key syntax notes:
Common mistakes to avoid:
```

Keep it updated after every lecture. Your TAs will check it periodically.

---

## 10-Lecture Curriculum

### Lecture 1 — MATLAB Environment & Variables

**Topics**
- MATLAB interface: Command Window, Editor, Workspace, File Browser
- Scripts (`.m` files) vs the live command line
- Variable types: scalars, strings, logical
- Basic arithmetic and operator precedence
- `disp`, `fprintf`, `clear`, `clc`
- Notebook setup: write your first entry today

**Hands-on exercise**
Write a script that defines several neuroscience-themed variables (e.g. membrane potential in mV, firing rate in Hz, number of trials) and prints them with descriptive labels.

**Take-home exercise**
Define at least 10 variables of different types. Perform arithmetic on them. Save the script. Write your first notebook entry explaining what each variable type is and when you would use it.

**Reference materials**
- [MATLAB Getting Started documentation](https://uk.mathworks.com/help/matlab/getting-started-with-matlab.html)
- [YouTube — MATLAB Onramp playlist (MathWorks official, free)](https://www.youtube.com/watch?v=T_ekAD7U-wU)

---

### Lecture 2 — Vectors & Matrices

**Topics**
- Row vs column vectors; creating with `[]`, `linspace`, `zeros`, `ones`
- Indexing: single element, range, `end` keyword
- Matrix operations: transpose, element-wise vs matrix arithmetic (`.*`, `*`)
- Useful functions: `size`, `length`, `numel`, `reshape`
- Why vectors matter: time series data, trial data, electrode recordings

**Hands-on exercise**
Create a vector of 100 time points (0 to 1 second at 100 Hz) and a corresponding vector of simulated membrane potential values. Index into it to extract a specific 200 ms window.

**Take-home exercise**
Create a 10×5 matrix where each row is a neuron and each column is a trial. Extract: (1) all data from neuron 3, (2) trial 2 across all neurons, (3) a 3×3 sub-matrix from the top-left corner. Add indexing syntax rules to your notebook.

**Reference materials**
- [MATLAB Arrays documentation](https://uk.mathworks.com/help/matlab/learn_matlab/matrices-and-arrays.html)
- [YouTube — MATLAB Tech Talks: Vectors and Matrices](https://www.youtube.com/watch?v=mPKoNTz9DCI)

---

### Lecture 3 — Plotting & Visualisation

**Topics**
- `plot`, `scatter`, `bar`, `histogram`
- Labels: `xlabel`, `ylabel`, `title`, `legend`
- Subplots: `subplot(rows, cols, index)`
- Saving figures: `saveas`, `exportgraphics`
- Good practice: always label axes with units; figures must be self-explanatory for lab reports

**Hands-on exercise**
Plot a simulated EEG-like sinusoidal signal over time. Add proper axis labels with units and a title. Create a subplot with the raw signal on top and a histogram of amplitude values below.

**Take-home exercise**
Generate a matrix of simulated data (5 neurons × 20 trials, use `randn`). Plot: (1) mean response per neuron as a bar chart, (2) a histogram of all values, (3) a time series for one neuron. Export the figure as a `.png`. This is the format you will use in your lab report.

**Reference materials**
- [MATLAB 2D Plotting documentation](https://uk.mathworks.com/help/matlab/2-and-3d-plots.html)
- [YouTube — Plotting in MATLAB (MathWorks)](https://www.youtube.com/watch?v=YHe7MGBQZ4c)

---

### Lecture 4 — Control Flow

**Topics**
- `if` / `elseif` / `else`
- `for` loops: iterating over indices and arrays
- `while` loops and break conditions
- Logical operators: `&&`, `||`, `~`, `==`, `>`
- Practical use: threshold detection, classifying trials, automating repetitive analysis steps

**Hands-on exercise**
Write a script that loops through a vector of voltage values and flags any value above a threshold as a spike. Count total spikes and print the result. This is the core logic of action potential detection.

**Take-home exercise**
Given a vector of reaction times from a hypothetical experiment, write a script that: (1) classifies each trial as fast, medium, or slow using thresholds, (2) counts each category, (3) plots a bar chart of the counts. Add loop and conditional syntax rules to your notebook.

**Reference materials**
- [MATLAB Control Flow documentation](https://uk.mathworks.com/help/matlab/control-flow.html)
- [YouTube — For loops and if statements in MATLAB](https://www.youtube.com/watch?v=5L0NqwYxC3A)

---

### Lecture 5 — Functions & Reusable Scripts

**Topics**
- Function syntax: `function output = myFunc(input)`
- Single vs multiple input/output arguments
- Variable scope: why workspace variables don't exist inside functions
- Calling functions from scripts
- Why functions matter: writing reusable analysis steps you can call on each subject's data

**Hands-on exercise**
Write a function `detectSpikes(voltageVector, threshold)` that returns the indices and count of spikes. Call it from a script on simulated voltage data. Then modify it to also return the mean inter-spike interval.

**Take-home exercise**
Write a function `normaliseTo01(v)` that normalises any vector to the range [0, 1]. Write a second function `computeStats(v)` that returns mean, std, min, and max as separate outputs. Test both in a script. Add function syntax to your notebook.

**Reference materials**
- [MATLAB Functions documentation](https://uk.mathworks.com/help/matlab/functions.html)
- [YouTube — Writing functions in MATLAB](https://www.youtube.com/watch?v=8LMZ2kq1f8o)

---

### Lecture 6 — Loading, Saving & Organising Data

**Topics**
- `load` / `save` (`.mat` files)
- `readmatrix`, `writematrix`, `readtable` (CSV/Excel)
- `struct` arrays for organising experiment metadata
- Setting up a consistent folder structure for lab work
- Canvas submission: saving `.m` files correctly, checking uploads

**Hands-on exercise**
Import a CSV file containing simulated EEG channel data. Extract one channel, compute its mean and standard deviation, and save the result to a `.mat` file. Practice the full load → process → save workflow.

**Take-home exercise**
Create a `struct` representing one EEG recording session (fields: `subjectID`, `date`, `samplingRate`, `data`, `channelLabels`). Save it, reload it in a fresh script, and verify all fields. Log your folder and file organisation approach in your notebook — you will use this structure for real data in Weeks 11–13.

**Reference materials**
- [MATLAB Import Data documentation](https://uk.mathworks.com/help/matlab/import_export/ways-to-import-text-files.html)
- [YouTube — Loading and saving data in MATLAB](https://www.youtube.com/watch?v=_j9MVVVHqwA)

---

### Lecture 7 — Descriptive Statistics & Experimental Design

**Topics**
- `mean`, `std`, `var`, `median`, `min`, `max`
- Operating along dimensions: `mean(X, 1)` vs `mean(X, 2)`
- z-scoring with `zscore`; normalising data
- Experimental design concepts in MATLAB: control vs experimental condition, between-subject vs within-subject, sample size N
- Presenting statistics in figures: bar charts with error bars using `errorbar`
- This is the core content of the Week 4 workshop

**Hands-on exercise**
Given a matrix of simulated response amplitudes (rows = subjects, columns = conditions), compute: mean and std per condition, then plot a bar chart with error bars. Add a horizontal line at the grand mean. Label everything.

**Take-home exercise**
Simulate two experimental conditions (e.g., 20 trials each, different means). Compute descriptive statistics for each. Plot them side by side with error bars. Write 3 sentences in your notebook interpreting the difference between conditions. This is the format you'll use in your lab report results section.

**Reference materials**
- [MATLAB Statistics documentation](https://uk.mathworks.com/help/stats/)
- [YouTube — Basic statistics in MATLAB](https://www.youtube.com/watch?v=YjNi4h2hXu8)

---

### Lecture 8 — Signal Processing Basics

**Topics**
- What sampling rate means; Nyquist theorem (intuition only — no maths)
- `fft` and power spectra: identifying dominant frequencies
- Simple filtering: `lowpass`, `highpass`, `bandpass` (Signal Processing Toolbox)
- EEG frequency bands: delta, theta, alpha, beta, gamma — what they are, how to filter for them
- Visualising signals and spectra side by side

**Hands-on exercise**
Generate a signal composed of two sine waves (10 Hz alpha + 60 Hz noise). Apply a low-pass filter to remove the noise. Plot the original and filtered signals in one subplot, and their power spectra in another subplot.

**Take-home exercise**
Take a noisy signal (provide template), identify its dominant frequency using FFT, apply a bandpass filter around that frequency, and plot before vs after. Write a short explanation in your notebook of why filtering is necessary before EEG analysis.

**Reference materials**
- [MATLAB Signal Processing Toolbox documentation](https://uk.mathworks.com/help/signal/)
- [YouTube — FFT in MATLAB explained (Mike X Cohen)](https://www.youtube.com/watch?v=mkGsMWi_j4Q)
- [YouTube — Filtering signals in MATLAB](https://www.youtube.com/watch?v=d1KnOfUakSE)

---

### Lecture 9 — EEG Analysis

**Topics**
- Loading real-format EEG data (continuous signal, channel × time matrix)
- Epoching: cutting continuous data into time-locked segments around events
- Baseline correction: subtracting the pre-stimulus mean
- Event-related averaging (ERP): averaging across epochs to extract signal from noise
- Single-subject analysis → group-level analysis: averaging across subjects, computing group mean and SEM
- Visualising ERP waveforms with shaded confidence intervals

**Hands-on exercise**
Given a simulated continuous EEG array and a vector of event timestamps, write a script that: (1) epochs the data (±500 ms around each event), (2) applies baseline correction, (3) computes the single-subject ERP, (4) plots the result with a baseline period marked.

**Take-home exercise**
Extend the script to handle multiple subjects: loop over a cell array of epoch matrices, compute the ERP for each, then compute the group mean and SEM. Plot the group ERP with a shaded ±1 SEM band. This is the analysis you will do in Weeks 12–13.

**Reference materials**
- [EEGLAB documentation](https://sccn.ucsd.edu/eeglab/index.php)
- [YouTube — EEG analysis in MATLAB (Mike X Cohen)](https://www.youtube.com/watch?v=2qOWM6dVsZM)
- Mike X Cohen, *Analyzing Neural Time Series Data* (reference text — not required reading, but useful)

---

### Lecture 10 — Electrophysiology Analysis & Full Workflow

**Topics**
- Earthworm electrophysiology context: what the recording looks like (voltage vs time, two recording sites)
- Loading and plotting raw electrophysiology recordings
- Action potential detection: threshold crossing to find spike times
- Conduction velocity: using timing difference between two electrodes and known distance
- Comparing conditions: effect of stimulus intensity or temperature on spike properties
- Producing publication-quality multi-panel figures for the lab report
- Full workflow run-through: load → detect → measure → plot → save → export figure

**Hands-on exercise**
Given two simulated voltage traces (proximal and distal electrodes), write a script that: (1) detects spikes in each trace using threshold crossing, (2) computes the conduction velocity from the mean delay between electrodes and the known inter-electrode distance, (3) plots both traces with detected spikes marked, and (4) saves the figure as a `.pdf` for the lab report.

**Take-home exercise**
Simulate two experimental conditions (e.g., room temperature vs cold saline). For each: detect spikes, compute conduction velocity, compute mean spike amplitude. Produce a two-panel figure comparing conditions. Write a 3-sentence results paragraph as you would in your lab report. This is the format of your Week 14 homework and lab report results section.

**Reference materials**
- [MATLAB Debugging documentation](https://uk.mathworks.com/help/matlab/matlab_prog/debugging-process-and-features.html)
- [MATLAB Cheat Sheet (MathWorks)](https://www.mathworks.com/content/dam/mathworks/fact-sheet/matlab-basic-functions-reference.pdf)
- [YouTube — Mike X Cohen: signal detection in MATLAB](https://www.youtube.com/@mikexcohen1)

---

## Recommended Reference Materials

### Official Documentation
- [MATLAB Getting Started](https://uk.mathworks.com/help/matlab/getting-started-with-matlab.html)
- [MATLAB Function Reference](https://uk.mathworks.com/help/matlab/referencelist.html)
- [Signal Processing Toolbox](https://uk.mathworks.com/help/signal/)
- [Statistics and Machine Learning Toolbox](https://uk.mathworks.com/help/stats/)

### Free Online Courses (do these alongside or between lectures)
- [MATLAB Onramp (MathWorks, free, ~2 hours)](https://matlabacademy.mathworks.com/) — **complete before Lecture 1**
- [Signal Processing Onramp (MathWorks, free)](https://matlabacademy.mathworks.com/details/signal-processing-onramp/signalprocessing) — do before Lecture 8

### YouTube Channels
- [MathWorks MATLAB Tech Talks](https://www.youtube.com/@MATLAB) — official, clear explanations of core concepts
- [Mike X Cohen — neuroscience-specific MATLAB](https://www.youtube.com/@mikexcohen1) — directly relevant to EEG, filtering, and signal analysis

---

*Based on the official NSBV BC2001 Spring 2026 syllabus, Barnard College.*
