# Session 8 — Signal Processing I: FFT & Spectrum + File I/O
**Date:** Saturday 14 June 2026 · **Length:** 2 hours · NSBV BC2001 MATLAB prep

## What's in this folder
- `Lesson_Plan_Session08.docx` — full instructor notes (scripted lines + expected answers). **Start here.**
- `live_scripts/` — the four demo scripts to run in class, in order:
  1. `demo1_fft_basics.m` — fft, two-sided result, fftshift, frequency axis, single-sided amplitude spectrum
  2. `demo2_amplitude_power_spectrum.m` — amplitude vs power spectrum, dominant & top-3 frequencies
  3. `demo3_file_io.m` — load/save `.mat`, `.csv`, `.txt`
  4. `demo4_load_and_analyze.m` — full load → FFT → spectrum → report pipeline
- `data/` — sample data the scripts load:
  - `eeg_sample.mat / .csv / .txt` — synthetic recording, **dominant frequency 8 Hz** (also 15, 30 Hz)
  - `mystery_signal.csv` — homework challenge, **dominant frequency 12 Hz** (also 5, 25 Hz)
  - `_generate_data.py` — how the data was made (not needed in class)
- `exercises/` — four take-home exercises with TODO blanks (give these to the student)
- `solutions/` — complete worked solutions (keep for yourself)

## Setup before class
Open MATLAB, set the **Current Folder** to this unzipped folder so the `data/...` paths in the scripts resolve. Run scripts section-by-section with **Ctrl+Enter**.

## Answer key (homework)
| Exercise | Answer |
|---|---|
| 1 — build spectrum | peaks at 7 Hz (≈2.0) and 40 Hz (≈1.0) |
| 2 — dominant frequency | dominant 18 Hz; top three 18, 33, 5 Hz |
| 3 — load from csv/txt | Fs = 256 Hz, dominant 8 Hz, csv vs txt difference ≈ 0 |
| 4 — mystery signal | dominant 12 Hz (weaker 5 Hz and 25 Hz) |

## Reference links
- MATLAB `fft`: https://www.mathworks.com/help/matlab/ref/fft.html
- Basic Spectral Analysis: https://www.mathworks.com/help/matlab/math/basic-spectral-analysis.html
- MathWorks Tech Talk — DFT & FFT: https://www.mathworks.com/videos/understanding-the-discrete-fourier-transform-and-the-fft-1700042348737.html
- 3Blue1Brown — Fourier Transform (visual): https://www.youtube.com/watch?v=spUNpyF58BY
- PhysioNet EEG datasets: https://physionet.org/content/?topic=eeg
- OpenNeuro EEG (BIDS): https://openneuro.org/search/modality/eeg
- EEGLAB: https://sccn.ucsd.edu/eeglab/index.php

## Next session
Session 9 — Signal Processing II: band-pass & notch filtering (`butter`, `filtfilt`) to clean noisy signals.
