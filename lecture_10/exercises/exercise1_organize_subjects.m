%% EXERCISE 1: Organise Multi-Subject Data
%  Session 10 — In-class exercise (~12 min)
%  ─────────────────────────────────────────
%  You have 3 subject files: subject_S01.mat, subject_S02.mat, subject_S03.mat
%  Each contains: data, fs, ch_names, time, age, condition
%
%  TASKS:
%  1. Load all 3 files into a struct array called 'dataset'
%  2. Print a summary table of all subjects (id, age, condition, # channels)
%  3. Find which subjects are in the 'control' condition
%  4. Compute and store the spectrum for channel 1 of each subject
%  5. Plot all 3 spectra on one figure with a legend

%% TODO 1: Define subject IDs and load in a loop
subject_ids = {'S01', 'S02', 'S03'};

% TODO: create an empty struct, loop through subject_ids,
%       build filenames with sprintf, load with tmp = load(filename),
%       and store each subject's data in dataset(i)



%% TODO 2: Print a summary of all subjects
% Use fprintf in a loop to print: id, age, condition, number of channels



%% TODO 3: Find control subjects
% Loop through dataset, use strcmp to check condition, collect indices



%% TODO 4: Compute spectrum for channel 1 of each subject
% Use get_spectrum() and store results in dataset(i).freq and dataset(i).spectrum



%% TODO 5: Plot all spectra on one figure
% Use a loop, different colors, add legend with subject IDs, xlim to [0 50]


