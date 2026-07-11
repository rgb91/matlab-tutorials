%% EXERCISE 2: Epoch Extraction & ERP
%  Session 10 — In-class exercise (~12 min)
%  ─────────────────────────────────────────
%  Load continuous_eeg.mat and extract epochs around each event.
%  Perform baseline correction and compute the ERP.
%
%  TASKS:
%  1. Load the continuous data and inspect the variables
%  2. Define an epoch window: 100 ms before to 300 ms after stimulus
%  3. Extract epochs for channel 2 (Pz) into a matrix
%  4. Apply baseline correction (subtract pre-stimulus mean per trial)
%  5. Compute the ERP (average across trials)
%  6. Plot: single trials in grey, ERP in bold, vertical line at t=0

%% TODO 1: Load data
% load continuous_eeg.mat, then print the number of events and channels



%% TODO 2: Define epoch window
% pre_stim = 0.1 seconds, post_stim = 0.3 seconds
% Convert to samples using round(seconds * fs)
% Create the epoch_time axis with linspace



%% TODO 3: Extract epochs for channel 2 (Pz)
% Create a matrix: epochs = zeros(n_events, epoch_length)
% Loop through event_samples, compute start_idx and end_idx
% Don't forget boundary checks!



%% TODO 4: Baseline correction
% Find which samples are before t=0 using epoch_time < 0
% For each trial, subtract the mean of the baseline period



%% TODO 5: Compute the ERP
% Average across rows (trials) using mean(..., 1)



%% TODO 6: Plot the result
% Grey lines for single trials, bold blue for ERP
% Mark stimulus onset with a red dashed vertical line
% Label axes in milliseconds


