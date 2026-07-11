%% HOMEWORK — Session 10
%  Due: before Session 11
%  ─────────────────────────────────────────────────────────────
%
%  PART A: Write an extract_epochs function  (save as extract_epochs.m)
%
%  The function should have this signature:
%    [epochs, epoch_time] = extract_epochs(data_1d, fs, event_samples, pre_s, post_s)
%
%  Inputs:
%    data_1d       — 1-D vector of continuous EEG (single channel)
%    fs            — sampling frequency in Hz
%    event_samples — vector of event sample indices
%    pre_s         — seconds before stimulus to include (e.g. 0.1)
%    post_s        — seconds after stimulus to include (e.g. 0.3)
%
%  Outputs:
%    epochs     — matrix of size (n_valid_trials × epoch_length)
%                 with baseline correction already applied
%    epoch_time — 1-D vector of times relative to stimulus (seconds)
%
%  Requirements:
%    - Skip trials that would go out of bounds
%    - Apply baseline correction: subtract mean of pre-stimulus samples
%    - Return epoch_time from -pre_s to +post_s
%
%  ─────────────────────────────────────────────────────────────
%  PART B: Apply your function to 3 homework data files
%
%  Files: homework_S01.mat, homework_S02.mat, homework_S03.mat
%  Each contains: continuous (1×N), fs, event_samples, epoch_time,
%                 epochs_ground_truth, subject_id, condition
%
%  Tasks:
%  1. Load each file
%  2. Use YOUR extract_epochs function on the 'continuous' data
%  3. Compare your epochs to epochs_ground_truth — they should match
%  4. Compute the ERP for each subject
%  5. Plot all 3 ERPs on one figure with a legend
%  ─────────────────────────────────────────────────────────────

%% Part B: Test your function

subject_ids = {'S01', 'S02', 'S03'};

% TODO: Loop through the 3 homework files
% For each:
%   1. Load the file
%   2. Call extract_epochs on the 'continuous' data
%   3. Check your output matches epochs_ground_truth
%   4. Compute the ERP
%   5. Store the ERP for plotting

% TODO: Plot all 3 ERPs on one figure

