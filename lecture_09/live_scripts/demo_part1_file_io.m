%% PART 1: FILE INPUT / OUTPUT
%  Session 9 — 20 June 2026
%  MATLAB concepts: load, readmatrix, readtable, struct access, whos
%  ─────────────────────────────────────────────────────────────────

%% 1A — Loading a .mat file
%  .mat is MATLAB's native binary format.
%  load() brings variables straight into the workspace.

load('eeg_recording.mat');      % creates: data, fs, ch_names, time

% Inspect what arrived
whos                            % shows all workspace variables & sizes

% Key outputs to check:
%   data      8×1024 double     (8 channels, 1024 samples)
%   fs        1×1   double      (256)
%   ch_names  1×8   cell        (channel labels)
%   time      1×1024 double     (0 to ~4 sec)

% Accessing channels
ch1 = data(1, :);               % first channel (row 1)
fprintf('Channel 1 label: %s\n', ch_names{1});  % cell indexing uses {}
fprintf('Number of samples: %d\n', length(ch1));

% Quick plot of channel 1
figure;
plot(time, ch1);
xlabel('Time (s)'); ylabel('Amplitude (\muV)');
title(sprintf('Channel: %s', ch_names{1}));

%% 1B — Loading a .csv file
%  readmatrix() returns a plain numeric matrix.
%  readtable()  returns a table object with column headers.

% Method 1: readmatrix — just the numbers, no headers
csv_data = readmatrix('eeg_data.csv');
fprintf('csv_data size: %d × %d\n', size(csv_data,1), size(csv_data,2));
% 1024 × 8  (rows = time points, columns = channels)
% NOTE: data from .mat was 8×1024 — csv_data is the TRANSPOSE!

% Method 2: readtable — includes the header row as column names
csv_table = readtable('eeg_data.csv');
disp(csv_table(1:5, :));         % first 5 rows
disp(csv_table.Properties.VariableNames);  % column names

% Accessing a column from a table
oz_from_table = csv_table.Oz;    % dot notation: table.ColumnName
fprintf('First 3 Oz values: %.2f  %.2f  %.2f\n', oz_from_table(1:3));

%% 1C — Loading a .txt file
%  Tab-delimited text with mixed content.
%  readtable() handles this well; readmatrix() works for pure numbers.

params = readtable('eeg_params.txt', ...
    'Delimiter', '\t', ...
    'ReadVariableNames', false);
disp(params);
% Var1 = parameter names (text), Var2 = values (text or numeric)

% Extract the sampling rate from the text file
fs_from_file = params.Var2(1); %str2double(params.Var2(1));  % '256' → 256
fprintf('Sampling rate from text file: %d Hz\n', fs_from_file);

%% 1D — Summary: when to use what
%  ┌──────────────┬─────────────────────────────────────────┐
%  │ File type     │ Best function                           │
%  ├──────────────┼─────────────────────────────────────────┤
%  │ .mat          │ load('file.mat')                        │
%  │ .csv (numbers)│ readmatrix('file.csv')                  │
%  │ .csv (mixed)  │ readtable('file.csv')                   │
%  │ .txt (numbers)│ readmatrix('file.txt')                  │
%  │ .txt (mixed)  │ readtable('file.txt','Delimiter','\t')  │
%  └──────────────┴─────────────────────────────────────────┘

fprintf('\n--- Part 1 complete. ---\n');
