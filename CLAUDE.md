# CLAUDE.md — MATLAB Tutorials Project

## Project purpose
Prepare a neuroscience undergraduate student (Barnard College, NSBV BC2001) for her fall MATLAB module.
Summer prep: ~10 lectures, 2 hours each, taught by Sanjay (also new to MATLAB).

**Goal:** Confident working knowledge of MATLAB for neuroscience lab work.
**Not the goal:** Teach neuroscience, prepare for written exams, cover theory.

## Student profile
- Undergraduate neuroscience student, Barnard College
- MATLAB beginner (zero prior experience assumed)
- Will use MATLAB for: EEG analysis, electrophysiology data, statistics, lab reports
- Course assessed: Week 4 workshop/exit ticket, Weeks 11–13 EEG analysis, Week 14 lab report, May exam

## Instructor profile
- Sanjay Saha (this user) — teaching MATLAB but also learning it alongside the student
- Needs: clear explanations, example scripts that actually run, confidence that material is correct

## Curriculum structure
See `learning-plan.md` for the full 10-lecture plan.

| # | Topic |
|---|---|
| 1 | MATLAB environment & variables |
| 2 | Vectors & matrices |
| 3 | Plotting & visualisation |
| 4 | Control flow (loops, conditionals) |
| 5 | Writing functions & scripts |
| 6 | Loading, saving & organising data |
| 7 | Descriptive statistics |
| 8 | Signal processing basics (FFT, filtering) |
| 9 | EEG & electrophysiology analysis |
| 10 | Revision & exam preparation |

## File conventions
- One `.m` file per lecture: `lecture01_environment.m`, `lecture02_vectors.m`, etc.
- Take-home exercises: `ex01_takehome.m`, `ex02_takehome.m`, etc.
- Solutions (instructor only): `ex01_solution.m`, etc.
- All scripts must run without errors in MATLAB R2023b or later
- Use the Signal Processing Toolbox and Statistics Toolbox where needed (student has campus license)

## How Claude should help
- Write complete, runnable `.m` scripts — no pseudo-code
- Include neuroscience-themed variables and datasets (membrane potential, firing rate, EEG, spike times)
- Keep code simple and readable; student is a beginner
- Explain MATLAB syntax clearly when introducing new concepts
- Flag any function that requires a specific toolbox
- When generating exercises, also generate a solution file
- Reference materials: prefer MathWorks official docs and Mike X Cohen YouTube (neuroscience MATLAB)

## Key reference materials
- MathWorks MATLAB Onramp (free): https://matlabacademy.mathworks.com/
- Mike X Cohen YouTube (EEG/neuroscience MATLAB): https://www.youtube.com/@mikexcohen1
- MathWorks official YouTube: https://www.youtube.com/@MATLAB
- Signal Processing Toolbox docs: https://uk.mathworks.com/help/signal/
- Course syllabus: `NSBV BC2001 Syllabus Spring 26.pdf`
