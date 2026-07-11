%% SOLUTION — EXERCISE 1: FILE I/O
%  ─────────────────────────────────

%% Task 1: Load the .mat file
load('eeg_recording.mat');

n_channels = size(data, 1);    % 8
n_samples  = size(data, 2);    % 1024

fprintf('Channels: %d, Samples: %d\n', n_channels, n_samples);

%% Task 2: Extract and plot Oz
oz = data(4, :);

figure;
plot(time, oz);
xlabel('Time (s)');
ylabel('Amplitude');
title(sprintf('Channel: %s', ch_names{4}));

%% Task 3: Load the CSV two ways
csv_matrix = readmatrix('eeg_data.csv');
csv_table  = readtable('eeg_data.csv');

fprintf('csv_matrix size: %d × %d\n', size(csv_matrix,1), size(csv_matrix,2));
disp(csv_table.Properties.VariableNames);

%% Task 4: Compare .mat and .csv
oz_from_csv = csv_matrix(:, 4);   % column 4

match = isequal(round(oz, 4), round(oz_from_csv', 4));
fprintf('Data matches: %d\n', match);
% Transpose needed because oz is a row (1×1024) and oz_from_csv is a
% column (1024×1).  We round because CSV stores only 4 decimal places.

%% Task 5: Load the text file
params = readtable('eeg_params.txt', ...
    'Delimiter', '\t', ...
    'ReadVariableNames', false);

fs_check = str2double(params.Var2{1});
fprintf('fs from .mat: %d, fs from .txt: %d\n', fs, fs_check);

fprintf('\n--- Exercise 1 solution complete! ---\n');
