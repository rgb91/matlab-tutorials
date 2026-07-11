%% DEMO 3 - FILE INPUT / OUTPUT: getting data in and out of MATLAB
% Session 8 - Signal Processing I
%
% Real EEG data lives in files. Before you can analyse it you must LOAD it.
% This demo shows the three file types you will meet most often.
%
% IMPORTANT: set MATLAB's "Current Folder" to the folder that contains the
% 'data' folder, OR adjust the paths below. The sample files live in ./data

clear; clc; close all;
dataDir = 'data';      % change if your files are somewhere else

%% ============================================================
%  PART A - .mat files (MATLAB's own format)
%  ============================================================
% A .mat file stores named variables. eeg_sample.mat contains:
%   signal  (1024x1 numbers), fs (the sampling rate), t (the time vector)

% Method 1: load straight into the workspace
% load() reads the file and creates variables in your workspace with the
% SAME names they had when they were originally saved.
% fullfile() joins folder and file name in the right way for any operating
% system — it uses '/' on Mac/Linux and '\' on Windows automatically.
% This is safer than hardcoding 'data/eeg_sample.mat' as a string.
load(fullfile(dataDir,'eeg_sample.mat'));   % creates: signal, fs, t

% whos lists all workspace variables and shows their size, bytes, and type.
% Running "whos signal fs t" limits the list to just those three names.
whos signal fs t                            % list what just appeared

% Method 2 (safer): load into a STRUCT so variable names cannot clash
% A struct is a container that groups related variables under one name.
% Accessing: S.signal, S.fs, S.t  (dot notation: struct_name.field_name)
% This avoids accidentally overwriting an existing workspace variable that
% happens to share a name with something inside the .mat file.
S = load(fullfile(dataDir,'eeg_sample.mat'));

% numel() returns the TOTAL number of elements in an array.
% For a column vector of length 1024, numel = 1024. Use numel rather than
% length() when you want to be explicit about counting all elements.
fprintf('Loaded %d samples at %g Hz from the .mat file\n', numel(S.signal), S.fs);

figure;
plot(S.t, S.signal); xlim([0 1]);   % show just the first second
xlabel('Time (s)'); ylabel('Amplitude (\muV)');   % \muV renders as μV
title('Signal loaded from eeg\_sample.mat');        % \_ prevents subscript formatting

% Saving a .mat file:
% list the variable NAMES you want to keep as separate string arguments.
% Only those variables are written — you do not have to save the whole workspace.
mySig = S.signal; Fs = S.fs;
save('my_output.mat', 'mySig', 'Fs');       % writes my_output.mat
disp('Saved my_output.mat');

%% ============================================================
%  PART B - .csv files (comma-separated, opens in Excel)
%  ============================================================
% eeg_sample.csv has a header row: time_s,amplitude_uV  then two columns.
% CSV is useful because other software (Python, Excel, R) can also read it.

% Method 1: readmatrix -> plain numeric matrix
% readmatrix() automatically detects and SKIPS the text header row, then
% returns a pure numeric matrix. Good when you just need the numbers.
M = readmatrix(fullfile(dataDir,'eeg_sample.csv'));
tCsv   = M(:,1);    % : means "all rows"; 1 = first column  = time
sigCsv = M(:,2);    % second column = amplitude

% Method 2: readtable -> keeps the column NAMES from the header
% readtable() returns a "table" object. Think of it like a spreadsheet in
% MATLAB. You can access columns by their header names using dot notation:
%   T.time_s        T.amplitude_uV
% This makes your code self-documenting and avoids magic column indices.
T = readtable(fullfile(dataDir,'eeg_sample.csv'));

% head(T, n) shows the first n rows of the table — like a quick preview.
% Equivalent to Python's DataFrame.head(3).
head(T,3)                                  % preview the first 3 rows

figure;
plot(tCsv, sigCsv); xlim([0 1]);
xlabel('Time (s)'); ylabel('Amplitude (\muV)');
title('Signal loaded from eeg\_sample.csv');

% Writing a .csv:
% Square brackets [ , ] HORIZONTALLY concatenate two column vectors into a
% two-column matrix. writematrix() then writes it as a comma-separated file.
% Note: writematrix does NOT write a header row by default.
writematrix([tCsv, sigCsv], 'my_output.csv');
disp('Saved my_output.csv');

%% ============================================================
%  PART C - .txt files (plain text numbers)
%  ============================================================
% eeg_sample.txt has ONE column of amplitude values and NO header.
% Plain text files are simple but lose column name information.

% readmatrix works here too — it handles both .csv and whitespace-separated
% .txt files. It is the all-rounder for loading numeric data.
sigTxt = readmatrix(fullfile(dataDir,'eeg_sample.txt'));
fprintf('Loaded %d values from the .txt file\n', numel(sigTxt));

% For a simple whitespace numeric file, load() also works and names the
% variable after the file:
%   load('data/eeg_sample.txt'); -> creates a variable called eeg_sample

% TALKING POINT (decision rule — choose based on the file type you have):
%   .mat  -> when the data came from MATLAB and keeps variable names
%   .csv  -> spreadsheet-style data; use readtable if columns are named
%   .txt  -> raw numbers; readmatrix is the safe all-rounder
%
% For real EEG data you will more likely encounter .mat (from EEGLAB/FieldTrip)
% or binary formats like .edf — but the loading principle is the same.
