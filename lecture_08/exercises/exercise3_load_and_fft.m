%% EXERCISE 3 - Load data from different file types
% Session 8 take-home. Fill in every TODO.
% Make sure the 'data' folder is next to this script (or fix dataDir).

clear; clc; close all;
dataDir = 'data';

% TODO 1: load eeg_sample.csv with readmatrix into a matrix M
M = ;                       % <-- readmatrix(...)
tCsv   = M(:,1);            % time column
sigCsv = M(:,2);            % amplitude column

% TODO 2: load the SAME amplitudes from eeg_sample.txt with readmatrix
sigTxt = ;                  % <-- readmatrix(...)

% TODO 3: confirm the two signals are (essentially) identical.
% Hint: max(abs(sigCsv - sigTxt)) should be a tiny number.
maxDiff = ;                 % <-- fill in
fprintf('Largest difference between csv and txt signals = %.2e\n', maxDiff);

% TODO 4: using the csv signal, work out the sampling rate Fs from the
% time column (Fs = 1 / time step). Then build the amplitude spectrum.
Fs = ;                      % <-- 1 / (tCsv(2) - tCsv(1))
N  = numel(sigCsv);
% ... build Y, P2, P1, f as in Demo 1 ...

% TODO 5: report the dominant frequency and plot the spectrum (0..50 Hz).

% CHECK: Fs should be 256 Hz and the dominant frequency should be 8 Hz.
